#!/bin/bash

set -eox pipefail

echo "================ init environment ================"
# 如果 .env 文件存在, 则加载 .env 文件
if [ -f .env ]; then
  source .env
fi

operator_values_file=$local_operator_values_file
if [ "$operator_values_file" == "" ]; then
  operator_values_file="./cloud-agent-operator/biz/values.yaml"
fi
namespace=$local_namespace
if [ "$namespace" == "" ]; then
  namespace="cloud-agent-operator"
fi

echo "namespace==${namespace}"
echo "operator_values_file==${operator_values_file}"


kubectl create ns $namespace || true
# 安装 crd
kubectl apply -f ./crds/cloud-agent-operator/crd.yaml
kubectl apply -f ./crds/cloud-agent-operator/rbac.yaml

# 安装中间件
kubectl apply -n $namespace -f ./cloud-agent-operator/intra/redis.yaml

# 安装 operator
helm upgrade -n $namespace cloud-agent-operator ./cloud-agent-operator/biz \
  --install --create-namespace --wait --cleanup-on-fail --recreate-pods \
  --values $operator_values_file

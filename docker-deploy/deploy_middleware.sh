#!/bin/bash

# 创建etcd数据目录并设置权限
echo "创建 ./etcd/data 目录并设置权限为 775"
mkdir -p ./etcd/data
chmod 775 ./etcd/data

# 拉镜像
echo "开始拉取中间服务的 Docker 镜像"
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/mysql:8.0
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/redis:6.2
docker pull --platform=linux/amd64 rabbitmq:3.11
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/etcd:3.5

# 构建中间服务的 Docker 镜像
echo "开始构建 docker-compose-middle.yaml 中定义的中间服务镜像"
docker compose -f docker-compose-middle.yaml build

# 启动中间服务的 Docker 容器
echo "启动 docker-compose-middle.yaml 中定义的中间服务容器，并在后台运行"
docker compose -f docker-compose-middle.yaml up -d

echo "所有操作完成"

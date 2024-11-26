#!/bin/bash
set -eox pipefail


# 创建一个堆栈来存储要执行的命令
DEFER_STACK=()

# defer 函数实现
defer() {
    # 将命令添加到堆栈开头(模拟LIFO)
    DEFER_STACK=("$@" "${DEFER_STACK[@]}")
}

# 清理函数 - 按照LIFO顺序执行所有defer的命令
cleanup() {
    for cmd in "${DEFER_STACK[@]}"; do
        eval "$cmd"
    done
}

# 注册EXIT信号处理器
trap cleanup EXIT

echo "================ init environment done. ================"


# 中间件依赖
docker compose -f docker-compose-middle.yaml up -d
echo "================ start check mysql status ================"
mysql_container_name=$(docker ps |grep mysql | awk '{print $1}')
echo "mysql_container_name==${mysql_container_name}"

# 检查 mysql 日志, 直到 mysql 初始化完成
echo "================ check mysql log ================"
while true; do
    mysql_log=$(docker logs $mysql_container_name 2>&1 |grep 'Server' |grep 'mysqld' | grep "starting as process 1" || true)
    if [ "$mysql_log" != "" ]; then
        break
    fi
    sleep 1
done
echo "================ check mysql status done ================"


echo "================ start check rabbitmq status ================"
rabbitmq_container_name=$(docker ps |grep rabbitmq | awk '{print $1}')
echo "rabbitmq_container_name==${rabbitmq_container_name}"
# 检查 rabbitmq 日志, 直到 rabbitmq 初始化完成
while true; do
    rabbitmq_log=$(docker logs $rabbitmq_container_name 2>&1 | grep "Server startup complete" || true)
    if [ "$rabbitmq_log" != "" ]; then
        break
    fi
    sleep 1
done
echo "================ check rabbitmq status done ================"

echo "================ start setup rabbitmq ================"
docker exec -it $rabbitmq_container_name /bin/bash -c "rabbitmqctl add_vhost codo" || true
docker exec -it $rabbitmq_container_name /bin/bash -c "rabbitmqctl set_permissions -p codo codo \".*\" \".*\" \".*\"" || true
echo "================ setup rabbitmq done ================"

echo "================ start setup mysql ================"
# 将 codo_mid/migrate_scripts/*.sql 拷贝到 mysql 容器中
kubectl cp ./codo_mid/migrate_scripts $namespace/$mysql_container_name:/tmp/migrate_scripts
# 执行数据库初始化脚本
kubectl exec -it -n $namespace $mysql_container_name -- /bin/bash -c "mysql -uroot -proot_password < /tmp/migrate_scripts/migrate_db.sql" || true
kubectl exec -it -n $namespace $mysql_container_name -- /bin/bash -c "mysql -uroot -proot_password < /tmp/migrate_scripts/migrate_cnmp.sql" || true
echo "================ setup mysql done ================"

echo "================ start deploy biz pods ================"
# 业务组件
helm upgrade -n $namespace codo-biz ./codo --create-namespace --install --wait --cleanup-on-fail \
 --values $biz_values_file \
 --values $biz_images_file \
 --set "namespace=$namespace"

echo "================ deploy biz pods done ================"

kubectl get pods -n $namespace

echo "================ deploy biz pods done ================"

echo "================ start check biz pods status ================"
admin_pod_name=$(kubectl get pods -n $namespace |grep admin | awk '{print $1}')
echo "admin_pod_name==${admin_pod_name}"
# 循环检查 pod 状态, 直到 RUNNING
while true; do
    pod_status=$(kubectl get pods -n $namespace | grep $admin_pod_name | awk '{print $3}' || true)
    echo "admin pod status is $pod_status"
    if [ "$pod_status" == "Running" ]; then
        break
    fi
    sleep 1
done
echo "admin pod is running"

# 进入 admin 容器, 执行 python3 manage.py db_init, 将数据库初始化
kubectl exec -it -n $namespace $admin_pod_name -- /bin/bash -c "python3 manage.py db_init" || true
# 进入 admin 容器, 执行 python3 manage.py token_init, 将获取的 token 作为 gatewayInnerApiToken 的值
gateway_inner_api_token=$(kubectl exec -it -n $namespace $admin_pod_name -- /bin/bash -c "python3 manage.py token_init" | tr -d '\r' | tr -d '\n')
echo "gateway_inner_api_token==$gateway_inner_api_token"
# helm 重新部署 biz 组件, 传入 api_token
helm upgrade --recreate-pods -n $namespace codo-biz ./codo --create-namespace --install --wait --cleanup-on-fail \
 --values $biz_values_file \
 --values $biz_images_file \
 --set "namespace=$namespace" \
 --set "gatewayInnerApiToken=$gateway_inner_api_token"

echo "================ congratulation!!! deploy done ================"
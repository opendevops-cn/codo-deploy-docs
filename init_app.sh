#!/bin/bash

# 执行docker命令获取token
TOKEN=$(docker exec codo_mg python3 manage.py token_init | tr -d '\\r')

# 更新或替换.env文件中的CODO_AUTH_KEY变量的值
sed -i "s/^CODO_AUTH_KEY=.*/CODO_AUTH_KEY=\"$TOKEN\"/" .env

echo "Token成功更新到.env文件的CODO_AUTH_KEY变量中"

echo "开始初始化数据库"
docker exec -it codo_mg python3 manage.py db_init

echo "开始重启应用"
docker-compose -f docker-compose-app.yaml restart

echo "开始服务和路由注册"
sh init_etcd.sh

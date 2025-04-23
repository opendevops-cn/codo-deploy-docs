#!/bin/bash

echo -e "开始启动应用镜像"

docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-gateway:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-frontend:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-admin:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-cmdb:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-flow-api:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-flow-loop:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-flow-queue:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-exec-task:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/flow-task-log:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/flow-agent-log:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-agent-server:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-cnmp:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-notice:latest
docker pull --platform=linux/amd64 registry.cn-shanghai.aliyuncs.com/ss1917/codo-k2:latest

# 启动应用镜像并等待启动完成
docker compose -f docker-compose-app.yaml up -d
if [ $? -ne 0 ]; then
  echo "应用镜像启动失败"
  exit 1
fi
echo "应用镜像启动成功，等待 5 秒..."
sleep 5

# 执行docker命令获取token
TOKEN=$(docker exec codo_mg python3 manage.py token_init | tr -d '\r\n')

# 更新或替换.env文件中的CODO_AUTH_KEY变量的值
sed -i "s/^CODO_AUTH_KEY=.*/CODO_AUTH_KEY=\"$TOKEN\"/" .env

echo "Token成功更新到.env文件的CODO_AUTH_KEY变量中"

echo "更新配置文件"
chmod +x gen_config.sh
./gen_config.sh

echo "开始初始化数据库"
cat ./db_init.sql| docker exec -i mysql mysql -ucodo -pss1917
docker exec -it codo_mg python3 manage.py db_init

echo "开始重启应用"
docker compose -f docker-compose-middle.yaml restart
docker compose -f docker-compose-app.yaml down
docker compose -f docker-compose-app.yaml up -d


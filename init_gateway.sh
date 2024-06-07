#!/usr/bin/env bash
JSON_FILE=$1
REDIS_HOST=$(grep "^DEFAULT_REDIS_HOST=" .env | cut -d '=' -f 2)
REDIS_PORT=$(grep "^DEFAULT_REDIS_PORT=" .env | cut -d '=' -f 2)
REDIS_PASSWORD=$(grep "^DEFAULT_REDIS_PASSWORD=" .env | cut -d '=' -f 2)

ETCD_HOST=$(grep "^DEFAULT_ETCD_HOST=" .env | cut -d '=' -f 2)
ETCD_PORT=$(grep "^DEFAULT_ETCD_PORT=" .env | cut -d '=' -f 2)
ETCD_DATA_PREFIX=$(grep "^etcd_prefix=" .env | cut -d '=' -f 2)

ECTD_HOST_PORT="http:\/\/$ETCD_HOST:$ETCD_PORT"
DATA_PREFIX=$(echo "$ETCD_DATA_PREFIX" | sed 's/\//\\\//g')

#------------------------更新redis配置 start----------------------
sed -i  's/\("host":\s"\).*/\1'"$REDIS_HOST"'",/g' $JSON_FILE
sed -i  's/\("port":\s"\).*/\1'"$REDIS_PORT"'",/g' $JSON_FILE
sed -i  's/\("auth_pwd":\s"\).*/\1'"$REDIS_PASSWORD"'",/g' $JSON_FILE
#------------------------更新redis配置 end----------------------
#------------------------更新etcd配置 start----------------------
sed -i  's/\("http_host":\s"\).*/\1'"$ECTD_HOST_PORT"'",/g' $JSON_FILE
sed -i  's/\("data_prefix":\s"\).*/\1'"$DATA_PREFIX"'"/g' $JSON_FILE
#------------------------更新etcd配置 end----------------------
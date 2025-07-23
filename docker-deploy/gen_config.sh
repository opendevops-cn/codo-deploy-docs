#!/bin/bash

# 脚本用于生成 notice 和 monitor 的配置文件
# 从 .env 文件加载环境变量

# 定义颜色
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# 输出带颜色的信息
info() {
    echo -e "${GREEN}[INFO] $1${NC}"
}

warn() {
    echo -e "${YELLOW}[WARN] $1${NC}"
}

error() {
    echo -e "${RED}[ERROR] $1${NC}"
}

# 检查 .env 文件是否存在
if [ ! -f .env ]; then
    error ".env 文件不存在，请先创建 .env 文件"
    exit 1
fi

# 加载 .env 文件中的环境变量
info "正在加载 .env 文件..."
# 导出环境变量，忽略空行和注释
# 加载 .env 文件中的环境变量 - 使用更安全的方式
# 逐行读取 .env 文件内容并设置环境变量
while IFS= read -r line || [ -n "$line" ]; do
    # 跳过注释行和空行
    if [[ ! "$line" =~ ^#.*$ ]] && [[ -n "$line" ]]; then
        # 分离变量名和值
        var_name=$(echo "$line" | cut -d= -f1)
        var_value=$(echo "$line" | cut -d= -f2-)

        # 移除可能的引号
        var_value=$(echo "$var_value" | sed -e 's/^"//' -e 's/"$//' -e "s/^'//" -e "s/'$//")

        # 设置环境变量
        export "$var_name"="$var_value"
    fi
done < .env

# 验证必要的环境变量是否存在
check_env_vars() {
    local missing=false
    for var in "$@"; do
        if [ -z "${!var}" ]; then
            error "缺少环境变量: $var"
            missing=true
        fi
    done
    
    if [ "$missing" = true ]; then
        exit 1
    fi
}

# 检查必要的环境变量
check_env_vars \
    "DEFAULT_DB_DBHOST" "DEFAULT_DB_DBPORT" "DEFAULT_DB_DBUSER" "DEFAULT_DB_DBPWD" \
    "DEFAULT_REDIS_HOST" "DEFAULT_REDIS_PORT" "DEFAULT_REDIS_PASSWORD" \
    "DEFAULT_ETCD_HOST" "DEFAULT_ETCD_PORT" "CODO_MONITOR_DEFAULT_DB_DBNAME"

# 创建目录（如果不存在）
mkdir -p notice
mkdir -p monitor/control
mkdir -p log

# 生成 notice 的配置文件
generate_notice_config() {
    info "正在生成 notice 配置文件..."
    
    cat > notice/config.yaml << EOF
# 项目元信息
metadata:
  name: "codo-notice"
  env: PRE
  gatewayPrefix: "${CODO_API_GW}"
  gatewayToken: "${CODO_AUTH_KEY}"

# 中间件
middleware:
  jwt:
    authKeyName: "auth_key"

# 服务注册
etcdRegistry:
  endpoints:
    - "${DEFAULT_ETCD_HOST}:${DEFAULT_ETCD_PORT}"

# 可观测性相关
otel:
  trace:
    endpoint: "${DEFAULT_OTEL_TRACE_ENDPOINT:-http://jaeger:14268/api/traces}"
    insecure: ${DEFAULT_OTEL_TRACE_INSECURE:-true}
  metric:
    enableExemplar: ${DEFAULT_OTEL_METRIC_ENABLE_EXEMPLAR:-true}
  log:
    level: ${DEFAULT_OTEL_LOG_LEVEL:-debug}

# 运输层相关
server:
  # 控制+通知接口配置
  http:
    addr: "0.0.0.0:8000"
    timeout: 1s
  # 第三方 webhook 接入
  thirdPartHook:
    network: "tcp"
    addr: "0.0.0.0:9001"
    timeout: 1s
  # metrics 配置
  prometheus:
    enable: ${DEFAULT_PROMETHEUS_ENABLE:-true}
    network: "${DEFAULT_PROMETHEUS_NETWORK:-tcp}"
    addr: "${DEFAULT_PROMETHEUS_ADDR:-0.0.0.0:8003}"
    path: "${DEFAULT_PROMETHEUS_PATH:-/metrics}"
  # golang pprof 配置
  pprof:
    enable: ${DEFAULT_PPROF_ENABLE:-true}
    network: "${DEFAULT_PPROF_NETWORK:-tcp}"
    addr: "${DEFAULT_PPROF_ADDR:-0.0.0.0:8004}"

# 通知渠道回调配置
hook:
  larkCard:
    verificationToken: "xxxxx"
    encryptKey: "xxxxx"

# 通知渠道配置
notifyConfig:
  # email 配置
  email:
    host: smtp.feishu.cn
    port: 465
    user: codo@codo.com
    password: xxx

  # 阿里通知配置
  aliyun:
    dxAccessId: LT____
    dxAccessSecret: obyElU_____
    dxSignName: CODO通知
    dxTemplate: SMS_20___
    dhAccessId: LTAI4F____
    dhAccessSecret: wFqdUb____
    dhTtsCode: TTS_21006____
    dhCalledShowNumber: "xxx"
    enable: true

  # 腾讯通知配置
  txyun:
    dxAccessId: xxx
    dxAccessSecret: xxx
    dxSignName: CODO通知
    dxTemplate: xxx
    dxAppId: xxx
    dhAccessId: xxx
    dhAccessSecret: xxx
    dhTemplate: xxx
    dhAppId: xxx
    enable: true

  # 飞书配置
  fsapp:
    appId: "xxx"
    appSecret: "xxxxx"

  # 钉钉通知配置
  ddapp:
    appId: xxx
    appSecret: xxx-xx
    agentId: "xxx"

  # 微信通知配置
  wxapp:
    agentId: 112233
    agentSecret: xxx
    cropId: xxx

# 数据库和缓存相关
data:
  database:
    link: "${DEFAULT_DB_DBUSER}:${DEFAULT_DB_DBPWD}@tcp(${DEFAULT_DB_DBHOST}:${DEFAULT_DB_DBPORT})/codo-notice?loc=Local&charset=utf8mb4&parseTime=True"
    debug: true
    prefix: codo_
  redis:
    addr: ${DEFAULT_REDIS_HOST}:${DEFAULT_REDIS_PORT}
    password: ${DEFAULT_REDIS_PASSWORD}
    readTimeout: 0.2s
    writeTimeout: 0.2s
    db: 2
EOF

    info "notice 配置文件生成完成: notice/config.yaml"
}

generate_agent_server_config() {
  info "正在生成 agent server 配置文件..."
  cat > codo-agent-server/conf.yaml << EOF
# HTTP 服务端口
PORT: 8000
# GRPC 通信端口
RPC-PORT: 8001
# websocket 连接专用端口
WS-PORT: 8002
# metrics 端口
PROM-PORT: 8003
# 性能采集端口
PPROF-PORT: 8004
# 本机服务监听地址
BIND-ADDRESS: 0.0.0.0


# 日志存放地址
ROOT-PATH: /data/logs/agent-server.log
# 日志等级
LOG-LEVEL: DEBUG


# MQ配置
MQCONFIG:
  ENABLED: false
  SCHEMA: "amqp"
  HOST: "127.0.0.1"
  PORT: 5672
  USERNAME: "admin"
  PASSWORD: "123456"
  VHOST: "codo"


# MYSQL 配置
DB-CONFIG:
  DB-TYPE: mysql
  DB-USER: root
  DB-PASSWORD: 123456
  DB-HOST: 127.0.0.1
  DB-NAME: codo_agent_server
  DB-TABLE-PREFIX: codo_
  DB-FILE: ""
  DB-PORT: 3306


# REDIS 配置
REDIS:
  R-HOST: 127.0.0.1
  R-PORT: 6379
  R-PASSWORD: ""
  R-DB: 1
# REDIS 发布订阅配置
# 用于:
#  CDMB 任务同步
#  CODO 任务分发
PUBLISH:
  P-HOST: 127.0.0.1
  P-PORT: 6379
  P-PASSWORD: ""
  P-DB: 1
  P-ENABLED: true

# 组网配置, 用于 CODO 异地组网流量分发
MESH-CONFIG:
  MESH-PORT: 9998
  SSL-PUBLIC-KEY-FILEPATH: /data/ca.crt
  SSL-PRIVATE-KEY-FILEPATH: /data/ca.key

# 第三方接口配置
THIRD-PARTY-API-CONFIG:
  AUTH-KEY: "${CODO_AUTH_KEY}"
  CMDB-API-CONFIG:
    REGISTER-AGENT-API: "${CODO_API_GW}/api/cmdb/api/v2/cmdb/agent/"

# OTEL 配置
OTEL:
  # pyroscope 服务地址
  PYROSCOPE:
    SERVER-ADDRESS: ""
    BASIC-AUTH-USER: ""
    BASIC-AUTH-PASSWORD: ""
EOF
}

# 执行生成配置文件函数
generate_notice_config
generate_agent_server_config

info "所有配置文件生成完成！"

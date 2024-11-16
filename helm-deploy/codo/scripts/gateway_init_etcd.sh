#!/usr/bin/env bash

# 函数定义：发送请求函数
send_request() {
  local endpoint="$1"
  local payload="$2"

  response=$(curl -sS -X POST "http://codo-gateway:8888$endpoint" \
             -H "X-Api-Token: api_token_xxxx" \
             -d "$payload")
  # 检查curl命令的返回码
  if [[ $? -ne 0 ]]; then
    echo "Failed to send request to $endpoint"
    exit 1
  fi

  # 检查响应中是否包含"ok"
  if [[ "$response" != "ok" ]]; then
    echo "Error: Unexpected response from $endpoint: $response"
    exit 1
  fi

  echo "Request to $endpoint successful"
}

# 路由配置函数
configure_route() {
  local key="$1"
  local serviceName="$2"
  local rewriteRegex="$3"
  local rewriteReplace="$4"

  send_request "/api/admin/routes/save" '{
    "key": "'"$key"'",
    "protocol": "http",
    "remark": "",
    "prefix": "'"$key"'",
    "service_name": "'"$serviceName"'",
    "status": 1,
    "plugins": ["rewrite", "discovery", "tracing"],
    "props": {
        "rewrite_url_regex": "'"$rewriteRegex"'",
        "rewrite_replace": "'"$rewriteReplace"'"
    }
  }'
}

# 服务配置函数
configure_service() {
  local key="$1"
  local serviceName="$2"
  local upstream="$3"

  send_request "/api/admin/services/save" '{
    "key": "'"$key"'",
    "service_name": "'"$serviceName"'",
    "upstream": "'"$upstream"'",
    "weight": 1,
    "status": 1
  }'
}

# 配置路由
configure_route "/api/mg/*" "mg" "^/api/mg/" "/"
configure_route "/api/acc/*" "mg" "^/api/acc" "/v4/na"
configure_route "/api/p/*" "mg" "^/api/p/" "/"
configure_route "/api/agent/*" "agent" "^/api/agent/" "/api/"
configure_route "/api/cmdb/*" "cmdb" "^/api/cmdb/" "/"
configure_route "/api/job/*" "job" "^/api/job/" "/"
configure_route "/api/kerrigan/*" "kerrigan" "^/api/kerrigan/" "/"
configure_route "/api/noc/*" "noc" "^/api/noc/" "/"
configure_route "/api/v2/cmdb/*" "cmdb" "^/api/cmdb/" "/"
configure_route "/api/cnmp/*" "cnmp" "^/api/cnmp/" "/"
configure_route "/api/cnmp-ws/*" "cnmp-ws" "^/api/cnmp-ws/" "/"

# 配置服务
configure_service "/mg/codo-adminv4.<namespace>.svc.cluster.local:8000" "mg" "codo-adminv4.<namespace>.svc.cluster.local:8000"
configure_service "/p/codo-adminv4.<namespace>.svc.cluster.local:8000" "p" "codo-adminv4.<namespace>.svc.cluster.local:8000"
configure_service "/cmdb/codo-cmdb.<namespace>.svc.cluster.local:8000" "cmdb" "codo-cmdb.<namespace>.svc.cluster.local:8000"
configure_service "/job/codo-flow-control.<namespace>.svc.cluster.local:8000" "job" "codo-flow-control.<namespace>.svc.cluster.local:8000"
configure_service "/kerrigan/codo-kerrigan.<namespace>.svc.cluster.local:8000" "kerrigan" "codo-kerrigan.<namespace>.svc.cluster.local:8000"
configure_service "/agent/codo-agent-server.<namespace>.svc.cluster.local:8080" "agent" "codo-agent-server.<namespace>.svc.cluster.local:8080"
configure_service "/cnmp/codo-cnmp.<namespace>.svc.cluster.local:8000" "cnmp" "codo-cnmp.<namespace>.svc.cluster.local:8000"
configure_service "/cnmp-ws/codo-cnmp.<namespace>.svc.cluster.local:8001" "cnmp-ws" "codo-cnmp.<namespace>.svc.cluster.local:8001"
exit 0
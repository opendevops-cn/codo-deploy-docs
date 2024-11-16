#!/bin/bash

# 函数：构建镜像并检查构建结果
build_image() {
    local service_name=$1
    local dockerfile_path=$2
    local image_name=$3
    echo "开始构建 ${service_name} 镜像..."
    cd "$dockerfile_path" || exit
#    if sudo docker build --no-cache --build-arg SERVICE_NAME="${service_name}" . -t "${image_name}"; then
    if sudo docker build  --build-arg SERVICE_NAME="${service_name}" . -t "${image_name}"; then
        echo "${service_name} 镜像构建成功！"
        cd ..
    else
        echo "构建 ${service_name} 镜像失败！"
        exit 1
    fi
}

# 构建codo-admin-image
build_image "admin-mg-api" "codo-adminv4" "codo-admin-image"

# 构建codo-frontend-image
build_image "frontend-converge" "codo-frontend-converge" "codo-frontend-image"

# 构建codo-gateway-image
build_image "gateway" "codo-gateway" "codo-gateway-image"

# 构建codo-cmdb-image
build_image "cmdb" "codo-cmdb" "codo-cmdb-image"

# 构建codo-job-api-image
build_image "control-api" "codo-flow" "codo-job-api-image"

# 构建codo-flow-loop-image
build_image "flow-loop" "codo-flow" "codo-flow-loop-image"

# 构建codo-flow-queue-image
build_image "flow-queue" "codo-flow" "codo-flow-queue-image"

# 构建codo-cron-job-image
build_image "cron" "codo-flow" "codo-cron-job-image"

# 构建codo-exec-task-image
build_image "exec-task" "codo-flow" "codo-exec-task-image"

# 构建codo-task-log-image
build_image "task-log" "codo-flow" "codo-task-log-image"

# 构建codo-agent-log-image
build_image "agent-log" "codo-flow" "codo-agent-log-image"

# 构建codo-kerrigan-image
build_image "kerrigan" "codo-kerrigan" "codo-kerrigan-image"

# 构建codo-agent-server-image
build_image "agent-server" "codo-agent-server" "codo-agent-server-image"

# 构建codo-flow-f-image
build_image "codo-flow-f" "codo-flow-f" "codo-flow-f-image"

echo "所有镜像构建完成！"

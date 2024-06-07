#!/bin/bash

# 启动 RabbitMQ 服务
echo "Starting RabbitMQ server..."
rabbitmq-server -detached
sleep 15

# 设置默认用户
if [ -n "$RABBITMQ_DEFAULT_USER" ] && [ -n "$RABBITMQ_DEFAULT_PASS" ]; then
  echo "Setting default user: $RABBITMQ_DEFAULT_USER"
  rabbitmqctl add_user $RABBITMQ_DEFAULT_USER $RABBITMQ_DEFAULT_PASS &&
  rabbitmqctl set_user_tags $RABBITMQ_DEFAULT_USER administrator
fi

# 启用管理插件
echo "Enabling management plugins..."
rabbitmq-plugins enable rabbitmq_management
rabbitmq-plugins enable rabbitmq_shovel rabbitmq_shovel_management

# 创建 vhost
if [ -n "$RABBITMQ_VHOST" ]; then
  echo "Creating vhost: $RABBITMQ_VHOST"
  rabbitmqctl add_vhost $RABBITMQ_VHOST
fi

# 创建用户
if [ -n "$RABBITMQ_USER" ] && [ -n "$RABBITMQ_PASS" ]; then
  echo "Creating user: $RABBITMQ_USER"
  rabbitmqctl add_user $RABBITMQ_USER $RABBITMQ_PASS
  rabbitmqctl set_user_tags $RABBITMQ_USER administrator
fi

# 授权用户
if [ -n "$RABBITMQ_VHOST" ] && [ -n "$RABBITMQ_USER" ]; then
  echo "Setting permissions for user $RABBITMQ_USER on vhost $RABBITMQ_VHOST"
  rabbitmqctl set_permissions -p $RABBITMQ_VHOST $RABBITMQ_USER '.' '.' '.'
fi
rabbitmqctl set_permissions -p '/' $RABBITMQ_USER '.' '.' '.'

echo "RabbitMQ setup completed."

# 停止 RabbitMQ 服务
echo "Stopping RabbitMQ server..."
rabbitmqctl stop

# 以 RabbitMQ 默认启动命令重新启动服务
echo "Starting RabbitMQ server..."
rabbitmq-server

# Dockerfile

# 使用官方 RabbitMQ 镜像作为基础镜像
#FROM rabbitmq:3.11
FROM registry.cn-shanghai.aliyuncs.com/ss1917/rabbitmq:3.11

# 复制定义的 RabbitMQ 配置文件
#COPY rabbitmq.conf /etc/rabbitmq/rabbitmq.conf

# 添加自定义脚本以在容器启动时创建 vhost、用户并进行授权
COPY init.sh /init.sh
RUN chmod +x /init.sh

# 在容器启动时运行初始化脚本
CMD ["/init.sh"]
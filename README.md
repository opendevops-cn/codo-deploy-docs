# codo项目部署

## 项目简介

- 本项目采用微服务架构，完成全球一站式运维体系建设。

- Demo 地址：https://demo.opendevops.cn/user/login  `用户：demo 密码：2ZbFYNv9WibWcR7GB6kcEY`
-

```text
codo
├── codo-admin # 管理后台
├── codo-agent-server # 底层管控
├── codo-cloud-agent-operator # 执行云原生任务
├── codo-cmdb # 数据资产、多云资源管理
├── codo-cnmp # 云原生管理平台
├── codo-flow-servers # 任务平台、作业调度执行
├── codo-monitor # 可观测平台
├── codo-notice #  通知中心
├── codo-frontend # 前端应用、流量入口(API流量 先进这里再路由到 gateway)
├── codo-gateway # API网关
└── codo-kerrigan # 配置中心

```

## 环境依赖

- 操作系统：Rocky Linux 9.1以上 x86_64
- Python版本：3.9
- Docker版本：最新稳定版本
- Docker Compose版本：最新稳定版本
- mysql: 8.0
- redis: 6.2
- rabbitmq: 3.11
- etcd: 3.5

## 部署方式
- [k8s-helm 部署](./helm-deploy/README.md)
- [docker 部署](./docker-deploy/README.md)
- [安装 codo-agent](./codo-agent-install-steps.md)

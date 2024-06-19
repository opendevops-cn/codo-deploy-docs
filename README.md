# CODO项目部署

## 项目简介

- 本项目采用微服务架构，完成全球一站式运维体系建设

- 项目说明

```shell
codo
├── services              # 服务目录
│   ├── codo-gateway      # API网关、流量入口
│   ├── codo-admin        # 管理后台
│   ├── codo-cmdb         # 配置平台、多云资源管理
│   ├── codo-flow         # 任务平台、作业调度执行
│   ├── codo-notice       # 通知中心
│   ├── codo-kerrigan     # 配置中心
├── ├── codo-frontend-converge      # 前端入口
├── ├── codo-agent-server      # 执行任务依赖agent
├── 
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

- 开发环境使用docker-compose方式, 完成管理后台、网关服务、前端项目、任务平台、配置中心、Agent-server的部署.
- 部署时先部署中间件, 中间件正常运行后部署应用.

## 快速部署

- 安装docker以及docker-compose工具
- docker安装命令参考 **[rockylinux操作系统]**

```shell
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
sudo dnf install docker-ce docker-ce-cli containerd.io
sudo systemctl start docker
sudo systemctl enable docker
```

- docker-compose安装命令参考 **[rockylinux操作系统]**

```shell
sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

--- 

- 修改配置文件 <span style="color: yellow;">【可选】[.env](.env)
  中已经配置项目中所需的账密信息,不修该则使用全局默认配置</span>
- 构建中间件

```shell
docker-compose -f docker-compose-middle.yaml build
```

- 启动中间件
  mysql、rabbitmq构建镜像时完成初始化操作

```shell
docker-compose -f docker-compose-middle.yaml up -d
```

- 修改etcd文件夹权限

```shell
chmod 777 ./etcd/data
```

---

- 启动应用镜像

> 强制拉取和创建 `docker-compose -f docker-compose-app.yaml up -d --pull --force-recreate`

```shell
docker-compose -f docker-compose-app.yaml up -d
```

--- 

- 初始化系统

```shell
sh ./init_app.sh
```

- 管理后台创建超级用户

> 默认的admin 密码为 1qazXSW@

```shell
docker exec -it codo_mg python3 manage.py createsuperuser
```
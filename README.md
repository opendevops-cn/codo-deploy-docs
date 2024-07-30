# CODO项目部署

## 项目简介

> CODO 项目基于微服务架构，旨在构建全球一站式运维体系。项目目录结构如下：

| 目录                           | 说明          |
|------------------------------|-------------|
| `codo`                       | 根目录         |
| ├── `services`               | 服务          |
| │   ├── `codo-gateway`       | 天门网关、后端流量入口 |
| │   ├── `codo-admin`         | 管理后台        |
| │   ├── `codo-cmdb`          | 配置平台、多云资源管理 |
| │   ├── `codo-flow`          | 任务平台、作业调度   |
| │   ├── `codo-notice`        | 消息中心（升级中）   |
| │   ├── `codo-kerrigan`      | 配置中心        |
| │   ├── `codo-cnmp`          | 云原生平台（暂未上线） |
| │   └── `codo-agent-server`  | 执行任务依赖agent |
| └── `codo-frontend-converge` | 前端基座、前端流量入口 |

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

- 开发环境使用docker-compose方式, 完成管理后台、网关服务、前端项目、任务平台、CMDB、配置中心、Agent-server的部署.
- 部署时先部署中间件, 中间件正常运行后部署应用.

## 快速部署

- 安装 Docker 和 Docker-compose
    - Docker安装命令参考 **[Rocky Linux 9 操作系统]**

  ```shell
  sudo dnf install dnf-plugins-core
  sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
  sudo dnf install docker-ce docker-ce-cli containerd.io
  sudo systemctl start docker
  sudo systemctl enable docker
  ```

    - docker-compose安装命令参考 **[Rocky Linux 9 操作系统]**

  ```shell
  sudo curl -L "https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose
  ```

--- 

- 修改配置文件 <span style="color: yellow;">【可选】[.env](.env)
  中已经配置项目中所需的账密信息,不修该则使用全局默认配置</span>

--- 

- 部署中间件  <span style="color: yellow;"> 如需依赖已有中间件则需要修改[.env](.env)配置

```shell
sh ./deploy_middleware.sh
```

--- 

- 启动服务并初始化

```shell
sh ./init_app.sh
```

- 管理后台创建超级用户

> 默认的admin 密码为 1qazXSW@

```shell
docker exec -it codo_mg python3 manage.py createsuperuser
```

--- 

## Agent 部署

在部署应用程序时，默认情况下会同时部署 Agent Server。默认的 Server 地址设置为 `ip:8081`。

[点击这里下载Agent](https://github.com/opendevops-cn/codo-agent-server)

> <font color="red">注意：在生产环境中，为了确保数据传输的安全性，使用 Agent Server 和 Agent Proxy
> 时需要为这两个组件配置证书。这样可以保护系统免受潜在的中间人攻击或其他安全威胁。</font>

#### 启动 proxy （可选）

```bash
codo-agent --url ws://ip:8081/api/v1/codo/agent?clientId=8888 -s --log-dir /data/logs/codo  --client-type master
```

#### 启动 agent

- 直连模式（测试推荐）

```bash
codo-agent --url ws://ip:8081/api/v1/codo/agent?clientId=codo-test -s --log-dir /data/logs/codo --row-limit 2000 --client-type normal

```

- 代理模式（需要启动proxy，生产推荐）

```bash
codo-agent --url ws://proxy_ip:20800/api/v1/codo/agent?clientId=codo-test:8888 -s --log-dir /data/logs/codo --row-limit 2000 --client-type normal

```

[Agent安装文档](https://github.com/opendevops-cn/codo-agent-server/blob/main/%E5%AE%89%E8%A3%85%E6%96%87%E6%A1%A3.md)

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
- 修改配置文件 <span style="color: yellow;">【可选】[.env](.env)中已经配置项目中所需的账密信息,不修该则使用全局默认配置</span>
- 构建中间件
```shell
mkdir -p rabbitmq/rabbitmq
docker-compose -f docker-compose-middle.yaml build
```

- 修改etcd文件夹权限
```shell
chmod 777 ./etcd/data
```

- 启动中间件
```shell
# mysql、rabbitmq构建镜像时完成初始化操作
docker-compose -f docker-compose-middle.yaml up -d
```
--- 

构建应用镜像

- 修改配置
```shell
# 使用[.env](.env)中的配置   
cp ./codo-gateway/conf/app.example.json ./codo-gateway/conf/app.json
cp ./codo-agent-server/conf/conf.template.yaml ./codo-agent-server/conf.yaml # agent-server 配置文件 
```
- 构建镜像
```shell
sh ./build_images.sh
```

- 启动镜像
```shell
docker-compose -f docker-compose-app.yaml up -d
```
--- 

数据初始化

- 管理后台数据初始化
```shell
docker exec -it codo_mg python3 manage.py db_init
```
- 管理后台创建超级用户
```shell
docker exec -it codo_mg python3 manage.py createsuperuser
```
etcd初始化

- 服务和路由注册
```shell
# P.S. 其中该脚本中的`X-Api-Token`参数要和./codo-gateway/conf/app.json文件中`tokens`中参数保持一致
sh ./init_etcd.sh
```
---
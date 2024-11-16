# helm部署

## 依赖
- helm
- k8s

## 一键部署
```
[root@harilou helm]# helm install -n <namespace> codo codo -f codo/values.yaml -f codo/images.yaml
```

## 统一端口规则
### 通用
- http: 8000
- grpc: 8001
- websocket: 8002
- metrics: 8003
- pprof: 8004
### 额外端口
- extra: 9000 - 9999

## svc 端口
1. admin-v4  
   1. http - 8000
2. tianmen(gateway)
   1. http 8888
   2. grpc 11000
3. agent server 
   1. http 8000
   2. ws 8002
   3. metrics 8003
   4. mesh 9998
4. cmdb
   1. http - 8000
5. cnmp 
   1. http - 8000
   2. ws - 8002
   3. metrics - 8003
   4. pprof - 8004
6. kerrigan
   1. http - 8000
7. flow 
   1. http - api 8000
   2. http - cron 9000
8. monitor
   1. http - 8000
9. notice
   1. http - 8000 

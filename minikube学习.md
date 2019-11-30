


# minikube命令
```bash
# 创建群集 也就是创建虚拟机
minikube start
# 创建第二个群集
minikube start -p cluster2
# 停止本地集群
minikube stop
```

## 删 delete
```bash
# 删除本地集群
minikube delete
# 删除所有个人资料
minikube delete --all
# 删除个人资料和.minikube目录
minikube delete --purge
# 删除所有本地群集和配置文件
minikube delete --purge --all
```

## 缓冲 cache
```bash
# 缓冲docker镜像
minikube cache add ubuntu:16.04
# 查看缓冲列表
minikube cache list
# 删除缓冲镜像
minikube cache delete <image name>
```

## 开始 start
```bash

# 设置使用的虚拟驱动
minikube start --vm-driver=hyperv 

# 国内启动minikube
minikube start --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers --vm-driver=hyperv 
# 大陆用于镜像下载加速
--image-mirror-country=cn
# 采用阿里云镜像站的资源下载
--image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

# 加速器可以到阿里云获取加速地址
--registry-mirror=https://im0hy9gl.mirror.aliyuncs.com

# 用containerd容器 也可以用docker
--container-runtime=containerd


```
## 配置
```bash
# 设置默认使用的虚拟驱动
minikube config set vm-driver hyperv
# 设置默认内存分配大小
minikube config set memory 4096
```

## 声明式配置
```bash
#把某个类型po svc deploy转为yaml 对象需要后期处理
kubectl get <kind>/<name> -o yaml > <kind>_<name>.yaml
kubectl get deploy cq -o yaml > 123.yaml

#通过以上导出修改后可以进行更新编排替换原有的配置
kubectl replace -f <kind>_<name>.yaml

#把某个类型po svc deploy转为yaml 声明方式 更负责编排
kubectl replace --save-config -f 123.yaml


```

# 操作相关 kubectl

```bash
# 连接到容器中
kubectl attach -it <name>
kubectl attach -it cq-78c488ccdf-zljp6 
# 进入容器  在容器中执行命令
kubectl exec -it cq-78c488ccdf-zljp6 sh
kubectl exec cq-78c488ccdf-zljp6 env

kubectl exec -it cq-pod sh

# 给pod添加一个标签v1
kubectl label pod $POD_NAME app=v1
```


# 查看命令 kubectl

```bash
# 查看客户端和服务端版本
kubectl version

# 查看窗格
kubectl get po -A
# 列出指定运行pod的信息
kubectl get po -l run=cq              pod
kubectl get services -l run=cq        服务器
# 查看节点  也就是虚拟机或实体机
kubectl get node
kubectl get nodes
# 为节点添加标签
kubectl label nodes <your-node-name> disktype=ssd
# 查看pod所运行在那个节点上
kubectl get pods --output=wide
# 等同上面 -w 是实时刷新
kubectl get pods -o wide -w
kubectl get pods -o lab
# 查看pods
kubectl get pods
#获取部署的应用 等同 docker ps
kubectl get deployments
# 显示有关您的ReplicaSet对象的信息
kubectl get replicasets
kubectl describe replicasets
# 查看pod详细信息
kubectl describe pods
kubectl describe deployments
kubectl describe deployment
# 查看服务
kubectl get svc,po,deploy
kubectl describe svc <depName>
kubectl describe svc cqa
kubectl describe services example-service
kubectl get pods --selector="run=load-balancer-example" --output=wide
```

# 创建
```bash
# 创建应用
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1

kubectl create -f 123.yaml

# 公开pod端口
kubectl expose deployment cq --external-ip="172.17.0.26" --port=9000 --target-port=9000
kubectl expose deployment cqa --external-ip="127.0.0.1" --port=9000 --target-port=9000

# 创建deployment并公开端口 并设置环境变量
kubectl run cq \
--image=coolq/wine-coolq \
--env="VNC_PASSWD=19920818" \
--env="COOLQ_ACCOUNT=2970532291" \
--port=9000 \
--hostport=9000
# 公开服务 等于创建了service
kubectl expose deployment cq --type=NodePort --port=9000 --target-port=9000 --name=cq-service 
# 从编排配置文件中创建
kubectl apply -f https://k8s.io/examples/service/access/hello-application.yaml
kubectl expose deployment hello-world --type=NodePort --name=example-service

```

# 删 kubectl delete
```bash
# 要删除服务，请输入以下命令：
kubectl delete services example-service
# 要删除正在运行Hello World应用程序的Deployment，ReplicaSet和Pod，请输入以下命令：
kubectl delete deployment hello-world

# 要删除Deployment （及其pod）  不要直接删除pod Deployment会复活这个pod
kubectl delete deployment cq
kubectl delete po cq-78c488ccdf-zljp6
```



# 其他
1. eval $(minikube docker-env --shell bash)
1. eval $(minikube docker-env --shell powershell)


export

minikube start --docker-env=HTTP_PROXY=$HTTP_PROXY --docker-env HTTPS_PROXY=$HTTPS_PROXY --docker-env NO_PROXY=$NO_PROXY --vm-driver=hyperv --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
minikube start --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers



minikube start \
  --docker-env=HTTP_PROXY=$HTTP_PROXY \
  --docker-env HTTPS_PROXY=$HTTPS_PROXY \
  --docker-env NO_PROXY=$NO_PROXY \
  --vm-driver=hyperv \
  --image-mirror-country=cn \
  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
  --container-runtime=containerd

minikube start \
    --image-mirror-country=cn \
    --container-runtime=containerd \
    --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com \
    --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.5.0.iso

minikube start `
--vm-driver=hyperv `
--registry-mirror=https://im0hy9gl.mirror.aliyuncs.com `
--iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.5.1.iso


minikube cache add coolq/wine-coolq
minikube cache add hello-world


del env:HTTP_PROXY,HTTPS_PROXY

del env:HTTPS_PROXY

ls env:HTT* | del

minikube ip



docker安装报错

原因是卸载不干净有残余注册表
1. 关闭安装进程
1. 进入注册表编辑器：WIN+R，输入 regedit，回车
1. 建议在以下操作前先备份注册表：文件->导出
1. 找到 Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker for Windows 并删除

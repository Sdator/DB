
- [minikube命令行](#minikube%e5%91%bd%e4%bb%a4%e8%a1%8c)
  - [启动](#%e5%90%af%e5%8a%a8)
  - [删delete](#%e5%88%a0delete)
  - [缓冲cache](#%e7%bc%93%e5%86%b2cache)
  - [配置](#%e9%85%8d%e7%bd%ae)
  - [声明式配置](#%e5%a3%b0%e6%98%8e%e5%bc%8f%e9%85%8d%e7%bd%ae)
- [kubectl](#kubectl)
- [查看命令 kubectl](#%e6%9f%a5%e7%9c%8b%e5%91%bd%e4%bb%a4-kubectl)
- [创建](#%e5%88%9b%e5%bb%ba)
- [删 kubectl delete](#%e5%88%a0-kubectl-delete)
- [kubectl](#kubectl-1)
- [其他](#%e5%85%b6%e4%bb%96)
- [更新](#%e6%9b%b4%e6%96%b0)
  - [start](#start)




# minikube命令行
## 启动
```bash
# 创建群集 也就是创建虚拟机
minikube start
# 创建第二个群集
minikube start -p cluster2

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

## 删delete
```bash
# 删除本地集群
minikube delete
# 删除所有个人资料
minikube delete --all
# 删除个人资料和.minikube目录
minikube delete --purge
# 删除所有本地群集和配置文件
minikube delete --purge --all
# 停止本地集群
minikube stop

```

## 缓冲cache
```bash
# 缓冲docker镜像
minikube cache add ubuntu:16.04
# 查看缓冲列表
minikube cache list
# 删除缓冲镜像
minikube cache delete <image name>
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



# kubectl

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



# kubectl

```bash
# 查看资源列表和资源短写
kubectl api-resources
# 查看资源详细
kubectl explain <po>

# 查看详细信息
kubectl describe <po>


# 查看群集的详细信息及其运行状况
kubectl cluster-info

# 使用以下命令查看集群中的节点
kubectl get nodes

#创建容器 pod
kubectl create deployment first-deployment --image=katacoda/docker-http-server
# 暴露服务器 first-deployment
# 开启80端口
kubectl expose deployment first-deployment --port=80 --type=NodePort

# 根据yaml规则创建容器？
kubectl apply -f /opt/kubernetes-dashboard.yaml
# 查看仪盘表启动进度
# 查看kube-system名称空间中的Pod
kubectl get pods -n kube-system  -w

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


```bash
# 删除环境变量
unset HTTPS_PROXY
unset HTTP_PROXY
```


Unable to connect to the server: dial tcp 172.17.204.77:8443: connectex: No connection could be made because the target machine actively refused it.




```bash
# minikube
设置默认驱动方式
minikube config set vm-driver hyperv

# 启用仪盘表 web管理页面
minikube addons enable dashboard

# 删除节点也就是虚拟机
minikube delete
```

# 更新
```bash
# 更新pod副本数量
kubectl scale -n default deployment cq --replicas=1
```

## start

选项：`--kubernetes-version k8s版本`  
用法：`--kubernetes-version v1.16.0`    
作用：使用指定版本的k8b

选项：`--vm-driver=<enter_driver_name>`  
用法：`--vm-driver=hyperv`    
作用：使用指定虚拟机

```bash
--vm-driver=hyperv          #指定虚拟驱动方式为微软的hyperv 
--hyperv-virtual-switch     #hyperv虚拟交换机名称。默认为首次发现

--network-plugin=cni \
--enable-default-cni \
--container-runtime=containerd \    # 指定底层容器
--bootstrapper=kubeadm
--network-plugin=cni \
--enable-default-cni \
--extra-config=kubelet.container-runtime=remote \
--extra-config=kubelet.container-runtime-endpoint=unix:///run/containerd/containerd.sock \
--extra-config=kubelet.image-service-endpoint=unix:///run/containerd/containerd.sock \
--bootstrapper=kubeadm
--wait=false                # 直到启动成功

minikube start \
--docker-env HTTP_PROXY=$HTTP_PROXY \
--docker-env HTTPS_PROXY=$HTTPS_PROXY \
--docker-env NO_PROXY=$NO_PROXY \
--image-mirror-country cn \
--vm-driver=hyperv


# 国内用 有效
minikube start --vm-driver=hyperv --registry-mirror https://im0hy9gl.mirror.aliyuncs.com --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers


minikube start --vm-driver=hyperv \
--registry-mirror https://im0hy9gl.mirror.aliyuncs.com \
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers


minikube start --vm-driver=hyperv `
--registry-mirror https://im0hy9gl.mirror.aliyuncs.com `
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers









minikube start \
--image-mirror-country cn \
--vm-driver=hyperv

--registry-mirror https://im0hy9gl.mirror.aliyuncs.com

--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers





eval $(minikube docker-env)

env | grep HTTP_PROXY

```



kubectl create deployment cq --image=coolq/wine-coolq 

--port=9000:9000 --type
-v `pwd`:/home/user/coolq 

kubectl expose deployment cq --type=LoadBalancer --port=9000

kubectl expose deployment cq --type=NodePort --port=9000

kubectl delete svc cq

```bash
# 共享文件夹到虚拟机
minikube mount /usr:/host

minikube mount --ip=172.17.204.65 e:\\Git\\cq:/home/docker

minikube ssh --native-ssh=false


172.17.204.65
172.17.204.77

minikube mount $HOME:/host




```



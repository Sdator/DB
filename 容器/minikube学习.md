# minikube命令行

### 配置代理

```bash
# linux 环境变量配置 加入到 ~/.bashrc
export HTTP_PROXY=http://127.0.0.1:10001
export HTTPS_PROXY=https://127.0.0.1:10001
# 不应该走代理的ip段
export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

minikube start \
--docker-env http_proxy=http://127.0.0.1:10001 \
--docker-env https_proxy=http://127.0.0.1:10001 \
--docker-env no_proxy=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

```

### 指定k8s版本

```bash
minikube start \
--kubernetes-version v1.19.0
```
### 指定VM驱动

```bash
minikube start \
--driver=<driver_name>
```

- 支持的驱动
  - virtualbox
  - vmwarefusion
  - kvm2 ([驱动安装](https://minikube.sigs.k8s.io/docs/drivers/#kvm2-driver))
  - hyperkit ([驱动安装](https://minikube.sigs.k8s.io/docs/drivers/#hyperkit-driver))
  - hyperv ([驱动安装](https://github.com/kubernetes/minikube/blob/master/docs/drivers.md#hyperv-driver))

- 请注意，下面的 IP 是动态的，可以更改。可以使用 `minikube ip` 检索。
  - vmware (驱动安装) （VMware 统一驱动）
  - none (在主机上运行Kubernetes组件，而不是在 VM 中。使用该驱动依赖 Docker (安装 Docker) 和 Linux 环境)

  

### 查看IP

```bash
minikube ip
```

## 检查群集状态

```bash
minikube status
```

## 启动
```bash
# 创建群集 也就是创建虚拟机
minikube start
# 创建第二个群集
minikube start -p cluster2

# 设置使用的虚拟驱动
minikube start --vm-driver=hyperv 

# 国内启动minikube
# 采用阿里云镜像站的资源下载
# 加速器可以到阿里云获取加速地址
# 大陆用于镜像下载加速
minikube start \
--image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers \
--registry-mirror=https://im0hy9gl.mirror.aliyuncs.com \
--image-mirror-country=cn

minikube start --vm-driver=virtualbox \
--image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers

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

# kubectl命令行



### 创建第一个

```bash
# 拉取镜像
kubectl create deployment hello-minikube --image=k8s.gcr.io/echoserver:1.10
# 公开端口
kubectl expose deployment hello-minikube --type=NodePort --port=8080
# 列出容器
kubectl get pod

# 列出服务公开地址
minikube service hello-minikube --url

# 查看容器失败原因 ImagePullBackOff状态
kubectl describe pod hello-minikube-64b64df8c9-sxnv9

```



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


## 查看命令 kubectl

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

## 创建
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

## 删 kubectl delete
```bash
# 要删除服务，请输入以下命令：
kubectl delete services example-service
# 要删除正在运行Hello World应用程序的Deployment，ReplicaSet和Pod，请输入以下命令：
kubectl delete deployment hello-world

# 要删除Deployment （及其pod）  不要直接删除pod Deployment会复活这个pod
kubectl delete deployment cq
kubectl delete po cq-78c488ccdf-zljp6
```



## kubectl

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

## 更新
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



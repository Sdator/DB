# minikube

K8S
储存 PV
  - 动态存储 动态供给概念（Dynamic rovisioning）
    - StorageClass
  - 静态供给方式
    - Static Provisioning

创PVC时会动态自动创建PV



什么是 PV, PVC, 为什么用 PV, PVC。
  PV, Persistent Volume. PVC, Persistent Volume Claim. 个人感觉， PV 相当于一个【可用的 存储资源 】的描述文件，PVC 是对于某一类 app 的【存储需求】的描述。

  通过 PV 和 PVC，可以把 app 对存储的需求进行抽象，存储端具体提供什么样的解决方案由运维负责， 而开发者不需要参与。同时，PV 和 PVC 可以解耦 app 和 存储， 有更高的灵活性。



## 配置代理

```bash
# linux 环境变量配置 加入到 ~/.bashrc
export HTTP_PROXY=http://127.0.0.1:10001
export HTTPS_PROXY=https://127.0.0.1:10001
# 不应该走代理的ip段
export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24


$Env:http_proxy = "http://127.0.0.1:10000";$Env:https_proxy = "http://127.0.0.1:10000"

# 把代理传入到容器中
minikube start \
--docker-env http_proxy=http://127.0.0.1:10001 \
--docker-env https_proxy=http://127.0.0.1:10001 \
--docker-env no_proxy=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

```

-

## 查看基础信息

```bash
# 检查群集状态
minikube status
# 查看IP
minikube ip

# 启用仪盘表 web管理页面
minikube addons enable dashboard
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

# 使用containerd容器 也可以用docker
--container-runtime=containerd

minikube start \
  --docker-env=HTTP_PROXY=$HTTP_PROXY \
  --docker-env HTTPS_PROXY=$HTTPS_PROXY \
  --docker-env NO_PROXY=$NO_PROXY \
  --vm-driver=hyperv \
  --image-mirror-country=cn \
  --image-repository=registry.cn-hangzhou.aliyuncs.com/google_containers
  --container-runtime=containerd
# bash
minikube start \
    --image-mirror-country=cn \
    --container-runtime=containerd \
    --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com \
    --iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.5.0.iso

# powershell
minikube start `
--vm-driver=hyperv `
--registry-mirror=https://im0hy9gl.mirror.aliyuncs.com `
--iso-url=https://kubernetes.oss-cn-hangzhou.aliyuncs.com/minikube/iso/minikube-v1.5.1.iso
```



## 删(delete)

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



## 缓冲(cache)

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



## 文件共享

```bash
# 共享文件夹到虚拟机
minikube mount /usr:/host
minikube mount --ip=172.17.204.65 e:\\Git\\cq:/home/docker
minikube ssh --native-ssh=false
minikube mount $HOME:/host
```



## 代理

- 直接设置环境变量即可传达给minikube

```bash
# linux
export HTTP_PROXY=http://<proxy hostname:port>
export HTTPS_PROXY=https://<proxy hostname:port>
export NO_PROXY=localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24

# 删除环境变量
unset HTTPS_PROXY
unset HTTP_PROXY
```

```powershell
# powershell
# 临时生效
$env:HTTP_PROXY="http://127.0.0.1:10001"
$env:HTTPS_PROXY="htts://127.0.0.1:10001"
$env:NO_PROXY="$(minikube ip),localhost,127.0.0.1,10.96.0.0/12,192.168.99.0/24,192.168.39.0/24"


```

## 命令行

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



## W10端口转发

```bash
# 添加端口转发
# 当收到来自本地8086端口的访问转发到minikube节点
netsh interface portproxy add v4tov4 listenport=8086 listenaddress=127.0.0.1 connectport=32211 connectaddress=$(minikube ip)
netsh interface portproxy add v4tov4 listenport=8086 listenaddress=192.168.3.2 connectport=32211 connectaddress=$(minikube ip)
netsh interface portproxy add v4tov4 listenport=8086 listenaddress=172.24.98.47 connectport=32211 connectaddress=$(minikube ip)

# 所有地址访问这个端口都会转发到minkube节点中
netsh interface portproxy add v4tov4 listenport=8086 listenaddress=0.0.0.0 connectport=32211 connectaddress=$(minikube ip)

# 查看系统中的所有转发规则
netsh interface  portproxy show  v4tov4

# 删除端口转发
netsh interface portproxy del v4tov4 listenport=8086 listenaddress=127.0.0.1
netsh interface portproxy del v4tov4 listenport=8086 listenaddress=192.168.3.2
netsh interface portproxy del v4tov4 listenport=8086 listenaddress=172.24.98.47
```





## 报错解决

- 内存预留是否足够

- 命令行终端是否以管理员权限执行（右击管理员、sudo）

- 网络是否畅通（代理、阿里镜像）

- 硬盘空间是否充足



# kubectl命令行

## 创建

```bash
# 创建应用、从编排配置文件中创建
kubectl create deployment kubernetes-bootcamp --image=gcr.io/google-samples/kubernetes-bootcamp:v1
kubectl create -f 123.yaml
kubectl apply -f /opt/kubernetes-dashboard.yam

# 创建实例过程
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

# 官方例子
kubectl apply -f https://k8s.io/examples/service/access/hello-application.yaml
kubectl expose deployment hello-world --type=NodePort --name=example-service

# 创建deployment并公开端口 并设置环境变量
kubectl run cq \
--image=coolq/wine-coolq \
--env="VNC_PASSWD=终端密码" \
--env="COOLQ_ACCOUNT=Q号" \
--port=9000 \
--hostport=9000
# 公开服务 等于创建了service
kubectl expose deployment cq --type=NodePort --port=9000 --target-port=9000 --name=cq-service

#创建容器 pod
kubectl create deployment first-deployment --image=katacoda/docker-http-server
# 暴露服务器80端口
kubectl expose deployment first-deployment --port=80 --type=NodePort

```

## 容器互动

```bash
# 连接到容器中
kubectl attach -it <name>
kubectl attach -it cq-78c488ccdf-zljp6
# 连接到容器中并执行命令
kubectl exec -it cq-78c488ccdf-zljp6 sh
kubectl exec -it cq-pod sh
kubectl exec cq-78c488ccdf-zljp6 env

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

## 查

### 节点（node）

```bash
# 查看节点  也就是虚拟机或实体机
kubectl get node
kubectl get nodes
# 为节点添加标签
kubectl label nodes <your-node-name> disktype=ssd
```
### 容器集（POD）

```bash
# 查看pods
kubectl get po
kubectl get pod
kubectl get pods
# 查看所有窗格
kubectl get po -A
# 列出指定运行pod的信息
kubectl get po -l run=cq              pod
# 查看pod所运行在那个节点上
kubectl get pods --output=wide
# 等同上面 -w 是实时刷新
kubectl get pods -o wide -w
kubectl get pods -o lab
kubectl get pods --selector="run=load-balancer-example" --output=wide

# 更新pod副本数量
kubectl scale -n default deployment cq --replicas=1
```
### 部署（deployments）

```bash
#获取部署的应用 等同 docker ps
kubectl get deploy
kubectl get deployments

# 显示有关您的ReplicaSet对象的信息
kubectl get replicasets
kubectl describe replicasets
```
### 服务（Service）
```bash
kubectl get svc
kubectl get services
kubectl get services -l run=cq        服务器
```

### 详细信息

```bash
# 查看详细信息
kubectl describe <po>
# 查看pod详细信息
kubectl describe pods <name>
kubectl describe deployments <name>
kubectl describe deployment <name>
# 查看服务
kubectl describe svc <depName>
kubectl describe svc cqa
kubectl describe services example-service
```



### 其他信息

```bash
# 查看客户端和服务端版本
kubectl version

# 查看资源列表和资源短写
kubectl api-resources

# 查看资源详细
kubectl explain <po>

# 查看群集的详细信息及其运行状况
kubectl cluster-info


# 查看仪盘表启动进度
# 查看kube-system名称空间中的Pod
kubectl get pods -n kube-system  -w
```

### 公开服务


```bash
# 公开pod端口
kubectl expose deployment cq --external-ip="172.17.0.26" --port=9000 --target-port=9000
kubectl expose deployment cqa --external-ip="127.0.0.1" --port=9000 --target-port=900
```

## 删（delete）

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

```bash

1. eval $(minikube docker-env --shell bash)
1. eval $(minikube docker-env --shell powershell)


export

minikube start --docker-env=HTTP_PROXY=$HTTP_PROXY --docker-env HTTPS_PROXY=$HTTPS_PROXY --docker-env NO_PROXY=$NO_PROXY --vm-driver=hyperv --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers
minikube start --registry-mirror=https://im0hy9gl.mirror.aliyuncs.com --image-repository registry.cn-hangzhou.aliyuncs.com/google_containers





minikube cache add coolq/wine-coolq
minikube cache add hello-world


del env:HTTP_PROXY,HTTPS_PROXY

del env:HTTPS_PROXY

ls env:HTT* | del

```



## docker安装报错

1. 原因是卸载不干净有残余注册表

2. 关闭安装进程

3. 进入注册表编辑器：WIN+R，输入 regedit，回车
4. 建议在以下操作前先备份注册表：文件->导出
5. 找到 Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Docker for Windows 并删除

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
minikube start \
--vm-driver=hyperv \
--registry-mirror https://im0hy9gl.mirror.aliyuncs.com \
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers


minikube start \
--image-mirror-country cn \
--vm-driver=hyperv \
--registry-mirror https://im0hy9gl.mirror.aliyuncs.com
--image-repository registry.cn-hangzhou.aliyuncs.com/google_containers

eval $(minikube docker-env)

env | grep HTTP_PROXY


kubectl create deployment cq --image=coolq/wine-coolq
--port=9000:9000 --type
-v `pwd`:/home/user/coolq

kubectl expose deployment cq --type=LoadBalancer --port=9000
kubectl expose deployment cq --type=NodePort --port=9000
kubectl delete svc cq
```

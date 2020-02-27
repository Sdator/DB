# 容器入门

- [容器入门](#%e5%ae%b9%e5%99%a8%e5%85%a5%e9%97%a8)
- [卸载](#%e5%8d%b8%e8%bd%bd)
  - [卸载旧版本](#%e5%8d%b8%e8%bd%bd%e6%97%a7%e7%89%88%e6%9c%ac)
  - [卸载 docker](#%e5%8d%b8%e8%bd%bd-docker)
  - [卸载 docker-compose](#%e5%8d%b8%e8%bd%bd-docker-compose)
- [安装](#%e5%ae%89%e8%a3%85)
  - [Debian 环境](#debian-%e7%8e%af%e5%a2%83)
  - [CentOS 环境](#centos-%e7%8e%af%e5%a2%83)
  - [Raspbian 环境](#raspbian-%e7%8e%af%e5%a2%83)
  - [docker-compose安装](#docker-compose%e5%ae%89%e8%a3%85)
- [其他](#%e5%85%b6%e4%bb%96)
  - [你的第一个容器](#%e4%bd%a0%e7%9a%84%e7%ac%ac%e4%b8%80%e4%b8%aa%e5%ae%b9%e5%99%a8)
  - [设置开机启动](#%e8%ae%be%e7%bd%ae%e5%bc%80%e6%9c%ba%e5%90%af%e5%8a%a8)
> 2019/2/27 AM By：Air

# 卸载
## 卸载旧版本
```bash
# Debian
apt-get remove docker docker-engine docker.io containerd runc
# ContOS
yum remove docker \
    docker-client \
    docker-client-latest \
    docker-common \
    docker-latest \
    docker-latest-logrotate \
    docker-logrotate \
    docker-engine
```

## 卸载 docker
```bash
# 卸载 docker
apt-get purge docker-ce
# 清除所有镜像和容器、卷
rm -rf /var/lib/docker
```
## 卸载 docker-compose
```bash
# curl 安装对应的卸载方法
rm -rf /usr/local/bin/docker-compose
```

# 安装
+ 请使用 sudo 提权安装
+ 指定版本会有说明 否则就是通用的
+ 参考
  + [docker-compose安装](https://docs.docker.com/compose/install/)
  + [docker安装](https://docs.docker.com/install/linux/docker-ce/debian/#install-using-the-convenience-script)

## Debian 环境
```bash
apt-get update
# 安装基础软件包以允许apt通过HTTPS使用存储库
apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg2 \
    software-properties-common
# 添加Docker的官方GPG密钥
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
# 验证您现在是否拥有带有指纹的密钥
apt-key fingerprint 0EBFCD88
# 使用稳定版的储存库
add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/debian \
   $(lsb_release -cs) \
   stable"
# 更新
apt-get update
# 安装容器社区版
apt-get install docker-ce docker-ce-cli containerd.io
```

## CentOS 环境
```bash
# 安装所需的软件包
yum install -y yum-utils \
  device-mapper-persistent-data \
  lvm2
# 使用稳定版的储存库
yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
# 安装 docker 社区版
yum install docker-ce docker-ce-cli containerd.io
# 启动容器服务
systemctl start docker
```

## Raspbian 环境
>其他系统也能用这个脚本安装 但此脚本主要是针对开发环境用的 非生产环境
```bash
curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
```

## docker-compose安装
+ alpine 环境需要安装以下依赖包
+ apk add --update py-pip python-dev libffi-dev openssl-dev gcc libc-dev make
```bash
# 下载
curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# 授权运行
chmod +x /usr/local/bin/docker-compose
# 创建软连接
ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
```




# 其他
## 你的第一个容器
```bash
docker run hello-world
```

## 设置开机启动
```bash
systemctl enable docker
```



# BBR 安装
- [BBR 安装](#bbr-%e5%ae%89%e8%a3%85)
  - [要求](#%e8%a6%81%e6%b1%82)
  - [安装BBR](#%e5%ae%89%e8%a3%85bbr)
  - [升级内核](#%e5%8d%87%e7%ba%a7%e5%86%85%e6%a0%b8)
  - [某些报错解决](#%e6%9f%90%e4%ba%9b%e6%8a%a5%e9%94%99%e8%a7%a3%e5%86%b3)
  - [验证](#%e9%aa%8c%e8%af%81)
> 2019/2/27 AM By：Air

## 要求
+ linux 内核版本 4.9+

## 安装BBR
+ Debian 9+ 可直接执行开启
+ CentOS 先升级内核版本后再执行
```bash
# 开启 BBR  Debian、ContOS亲测
echo "net.core.default_qdisc=fq" >> /etc/sysctl.conf
echo "net.ipv4.tcp_congestion_control=bbr" >> /etc/sysctl.conf
# 配置立即生效 /etc/sysctl.conf
sysctl -p
```

## 升级内核
+ 内核等于大于 4.9 内核的请跳过 如 Debian

> ### centos
+ 众所周知 centos 的内核版本一直都很低为了稳定 需要手动升级一下
```bash
# 安装 eprl 的源
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -Uvh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
# 安装最新的内核版本
yum --enablerepo=elrepo-kernel install kernel-ml -y
# 查看启动顺序 顶部显示的为当前启动的内核
egrep ^menuentry /etc/grub2.cfg | cut -f 2 -d \'
egrep ^menuentry /boot/grub2/grub.cfg | cut -f 2 -d \'
# 设置启动内核
# 方法1 通过上方的命令获取到内核名字 如 'CentOS Linux (5.5.4-1.el7.elrepo.x86_64) 7 (Core)'
grub2-set-default 'CentOS Linux (5.5.4-1.el7.elrepo.x86_64) 7 (Core)'
# 方法2 可以通过序号来设置启动顺序 从0开始
grub2-set-default 2
# - 0 [ ] CentOS Linux (3.10.0-1062.el7.x86_64) 7 (Core)
# - 1 [ ] CentOS Linux (5.5.3) 7 (Core)
# - 2 [x] CentOS Linux (4.14.168-bbrplus) 7 (Core)
# - 3 [ ] CentOS Linux (4.9.13-1.el7.centos.x86_64) 7 (Core)
# 重启
reboot
```



## 某些报错解决
>grub
```bash
# 修复默认引导内核
grub2-mkconfig -o /boot/grub2/grub.cfg
```


## 验证
```bash
# 查看系统现有的内核
rpm -qa | grep kernel
# 查看默认启动内核
grub2-editenv lis
# 查看内核是否是否 4.9+
uname -r
# 查看 bbr 模块是否已加载
lsmod | grep bbr
# 查看配置
sysctl -n net.ipv4.tcp_congestion_control
sysctl net.ipv4.tcp_congestion_control net.core.default_qdisc
# 未开启
# net.ipv4.tcp_congestion_control = cubic
# net.core.default_qdisc = pfifo_fast
# 开启
# net.ipv4.tcp_congestion_control = bbr
# net.core.default_qdisc = fq
```


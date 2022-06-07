# WSL2 下玩容器

+ 权限不足的自己补上 sudo 命令

## 安裝【这里用原生方法】

+ 此安装方式只适合用于测试环境下使用，切勿部署到生产环境

下载并安装：

```bash
> curl -fsSL https://get.docker.com -o get-docker.sh && sh get-docker.sh
 ```

启动容器服务：

```bash
> service docker start
 ```

## 添加开机脚本

+ 由于 WSL2 的 systemctl 工具是删减版，因此我们需要编写一个脚本来自动开机执行容器服务
+ 脚本只需执行一次

```bat
@echo off
title 添加容器开机运行脚本    by：絕 250740270
chcp 65001>nul
call :fixpath "%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup\runDocker.vbs" legal_path

@REM 添加到开机运行
(
echo ' 创建终端对象
echo Set ws = WScript.CreateObject^("WScript.Shell"^)
echo ' 隐藏运行
echo ws.run "wsl -u root service docker start", vbhide
) > "%legal_path%"

start shell:startup

@rem del %0

pause
exit

:fixpath
    set %2=%~fs1
goto :eof
```

## 容器开启远程服务

复制到终端中执行：

```bash
# 新版测试能用  如果报错尝试添加  "iptables": false
cat > /etc/docker/daemon.json <<EOF
{
  "hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2333"],
  "registry-mirrors": ["https://registry.docker-cn.com"]
}
EOF
```

重启容器：

```bash
> sudo service docker restart
```

检测监听端口是否正确：

```bash
> sudo apt install
> sudo netstat -lntp | grep dockerd
```

### daemon.json 配置说明

打开远程服务：

```json
"hosts": ["unix:///var/run/docker.sock", "tcp://0.0.0.0:2378"]
```

国内镜像加速：

```json
"registry-mirrors": ["https://registry.docker-cn.com"],
```

不使用 ptables 可以解决部分平台报错, 但也有可能会导致容器无法和宿主机通信，个人猜测是关闭后导致端口转发条目失效了

```json
"iptables": false
```

## 宿主机远程管理容器服务

### 安装docker-cli

手动下载【自行配置环境变量】：
<https://download.docker.com/win/static/stable/x86_64/>

or

scoop 安装方式：

```powershell
> scoop install docker
```

设置环境变量：

```powershell
 [environment]::SetEnvironmentvariable("DOCKER_HOST", "[::1]:2333", "User")
```

or

```powershell
 [environment]::SetEnvironmentvariable("DOCKER_HOST", "localhost:2333", "User")
```

测试是否能查看远端服务：

```powershell
> docker ps
```

## 问题

### localhost

+ 可通过 localhost 访问子系统中的服务
+ localhost 会被解析为 ipv6 [::1] 而无需做端口映射或修改 hosts
+ Win7\XP下的 localhost是`127.0.0.1`，而W10是 `[::1]`【这是个大坑】

### vscode 连接远程容器

在设置中添加 ：
`"docker.host": "tcp://[::1]:2223"`

正常情况下以为填 `localhost` 即可, 但因为一些特殊情况 `localhost` 被解析为`127.0.0.1` 的`IPV4`地址,会导致服务无法连上，原因是 wsl2 只监听了服务的 `ipv6` 地址而没有做 `ipv4` 地址的监听，这个可以从监听端口上看到。

### ipv4 偷跑？

由于我通过任务计划创建了一个任务 当系统开机时使用 system 权限执行 wsl 命令。

等我重启进了桌面后通过访问子系统中的服务发现连不上。进入 wsl 后测试 ping 百度提示报错信息，然后根据网上的教程修改了 `/etc/resolv.conf`、`/etc/systemd/resolved.conf` 配置均没有效果。

最后通过`禁用\开启`本地虚拟网卡和`重置网络`解决了。【用魔法打败魔法】

> 错误信息 ping: baidu.com: Temporary failure in name resolution

## 参考

+ Linux 原生方法安装【推荐】：
  + <https://docs.docker.com/engine/install/debian/#install-using-the-repository>
+ docker for window：
  + <https://docs.microsoft.com/zh-cn/windows/wsl/tutorials/wsl-containers>
+ W10 下 WSL2 安装教程：
  + <https://github.com/Sdator/DB/blob/master/WSL2/WSL2%E9%83%A8%E7%BD%B2%E6%95%99%E7%A8%8B.md>
+ 配置细节：
  + <https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user>
  + <https://docs.docker.com/engine/security/rootless/>

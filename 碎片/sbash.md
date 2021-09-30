````bash

v2ray: /usr/bin/v2ray /etc/v2ray

/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

PATH=/root/.vscode-server/bin/26076a4de974ead31f97692a0d32f90d735645c0/bin

v2ray: /usr/bin/v2ray /etc/v2ray

PATH=$PATH:

:/usr/local/sbin:/usr/local/bin
:/usr/sbin
:/u

/usr/bin/v2ray/v2ctl
/usr/bin/v2ray/v2ray

寻找文件
  whereis
    whereis 是一个小巧好用的文件寻找工具，它专门用来寻找可执行的程序、原始程序和使用手册
    只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man说明文件（参数-m）和源代码文件（参数-s）。如果省略参数，则返回所有信息
    whereis -b v2ray


which [ 程序名称 ]
  定位一个程序文件
  在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果
  which v2ray

mlocate daemon.json
  利用索引快速寻找文件

# locate 命令进化
mlocate hosts
slocate   安全的
locate    原始的

yum install mlocate
apt install mlocate

updatebd



可以利用journalctl工具查看日志
sudo journalctl -b -u v2ray
sudo journalctl -b -u docker

access.log：包含正常连接的消息
error.log：仅包含错误连接的消息





```bash
# 1. Caddy 安装

curl https://getcaddy.com | bash -s personal
#查看安装位置
which caddy
#out /usr/local/bin/caddy
#出于安全考虑，切勿以root身份运行Caddy二进制文件。 为了让Caddy能够以非root用户身份绑定到特权端口（例如80,443），您需要运行setcap命令，如下所示
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy



# 1. Caddy 配置

#为Caddy创建一个专用的系统用户：caddy和一组同名的用户：
sudo useradd -r -d /var/www -M -s /sbin/nologin caddy
#注意：此处创建的用户caddy只能用于管理Caddy服务，不能用于登录。

#创建存储SSL证书的目录：
sudo mkdir /etc/ssl/caddy
sudo chown -R caddy:root /etc/ssl/caddy
sudo chmod 0770 /etc/ssl/caddy

#创建一个专用目录来存储Caddy配置文件Caddyfile：
sudo mkdir /etc/caddy
# 设置文件所属用户组
sudo chown -R root:caddy /etc/caddy


#创建名为Caddyfile的Caddy配置文件：
sudo touch /etc/caddy/Caddyfile
# 设置用户组
sudo chown caddy:caddy /etc/caddy/Caddyfile
# 设置文件权限
sudo chmod 444 /etc/caddy/Caddyfile
# tee命令用于将数据重定向到文件，另一方面还可以提供一份重定向数据的副本作为后续命令的stdin。简单的说就是把数据重定向到给定文件和屏幕上。
cat <<EOF | sudo tee -a /etc/caddy/Caddyfile
mydomain.me # 域名
{
  log ./caddy.log
  proxy /ray localhost:36722 { # 36722是V2ray配置的端口
    websocket
    header_upstream -Origin
  }
}
EOF


# 1. 为caddy创建系统服务配置
curl -s https://raw.githubusercontent.com/mholt/caddy/master/dist/init/linux-systemd/caddy.service -o /etc/systemd/system/caddy.service

#为Caddy Web服务器创建主目录/ var / www，为您的站点创建主目录/var/www/example.com：
sudo mkdir -p /var/www/hxun.xyz
sudo chown -R caddy:caddy /var/www

# 1. 写入一些配置信息
参考 https://segmentfault.com/a/1190000018242765?utm_source=tag-newest

# 1. 重载服务文件
sudo systemctl daemon-reload
# 启动服务
sudo systemctl start caddy.service
# 开机自动运行
sudo systemctl enable caddy.service
# 查看服务状态
service v2ray status	| systemctl status caddy.service
服务参考：https://www.cnblogs.com/zdz8207/p/linux-systemctl.html

# 一键生成自动启动脚本
caddy -service install -conf /etc/caddy/Caddyfile


systemctl restart v2ray.service && systemctl start caddy.service

# 重启服务
service v2ray restart
service caddy restart

service caddy start


#添加开机自启
systemctl enable v2ray
systemctl enable caddy

# 启动cappy服务
/usr/local/bin/caddy -log stdout -agree=true -conf=/etc/caddy/Caddyfile -root=/var/tmp

# 日常查看指令
netstat -tlnp
ps -aux | grep cadd

# 一键BBR
# 参考 https://teddysun.com/489.html
# https://www.cnblogs.com/bluestorm/p/11484503.html
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

https://www.moerats.com/archives/10/
```bash

v2ray: /usr/bin/v2ray /etc/v2ray

/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

PATH=/root/.vscode-server/bin/26076a4de974ead31f97692a0d32f90d735645c0/bin

v2ray: /usr/bin/v2ray /etc/v2ray

PATH=$PATH:

:/usr/local/sbin:/usr/local/bin
:/usr/sbin
:/u

/usr/bin/v2ray/v2ctl
/usr/bin/v2ray/v2ray

寻找文件
  whereis
    whereis 是一个小巧好用的文件寻找工具，它专门用来寻找可执行的程序、原始程序和使用手册
    只能用于程序名的搜索，而且只搜索二进制文件（参数-b）、man说明文件（参数-m）和源代码文件（参数-s）。如果省略参数，则返回所有信息
    whereis -b v2ray


which [ 程序名称 ]
  定位一个程序文件
  在PATH变量指定的路径中，搜索某个系统命令的位置，并且返回第一个搜索结果
  which v2ray

mlocate daemon.json
  利用索引快速寻找文件

# locate 命令进化
mlocate hosts
slocate   安全的
locate    原始的

yum install mlocate
apt install mlocate

updatebd



可以利用journalctl工具查看日志
sudo journalctl -b -u v2ray
sudo journalctl -b -u docker

access.log：包含正常连接的消息
error.log：仅包含错误连接的消息





```bash
# 1. Caddy 安装

curl https://getcaddy.com | bash -s personal
#查看安装位置
which caddy
#out /usr/local/bin/caddy
#出于安全考虑，切勿以root身份运行Caddy二进制文件。 为了让Caddy能够以非root用户身份绑定到特权端口（例如80,443），您需要运行setcap命令，如下所示
sudo setcap 'cap_net_bind_service=+ep' /usr/local/bin/caddy



# 1. Caddy 配置

#为Caddy创建一个专用的系统用户：caddy和一组同名的用户：
sudo useradd -r -d /var/www -M -s /sbin/nologin caddy
#注意：此处创建的用户caddy只能用于管理Caddy服务，不能用于登录。

#创建存储SSL证书的目录：
sudo mkdir /etc/ssl/caddy
sudo chown -R caddy:root /etc/ssl/caddy
sudo chmod 0770 /etc/ssl/caddy

#创建一个专用目录来存储Caddy配置文件Caddyfile：
sudo mkdir /etc/caddy
# 设置文件所属用户组
sudo chown -R root:caddy /etc/caddy


#创建名为Caddyfile的Caddy配置文件：
sudo touch /etc/caddy/Caddyfile
# 设置用户组
sudo chown caddy:caddy /etc/caddy/Caddyfile
# 设置文件权限
sudo chmod 444 /etc/caddy/Caddyfile
# tee命令用于将数据重定向到文件，另一方面还可以提供一份重定向数据的副本作为后续命令的stdin。简单的说就是把数据重定向到给定文件和屏幕上。
cat <<EOF | sudo tee -a /etc/caddy/Caddyfile
mydomain.me # 域名
{
  log ./caddy.log
  proxy /ray localhost:36722 { # 36722是V2ray配置的端口
    websocket
    header_upstream -Origin
  }
}
EOF


# 1. 为caddy创建系统服务配置
curl -s https://raw.githubusercontent.com/mholt/caddy/master/dist/init/linux-systemd/caddy.service -o /etc/systemd/system/caddy.service

#为Caddy Web服务器创建主目录/ var / www，为您的站点创建主目录/var/www/example.com：
sudo mkdir -p /var/www/hxun.xyz
sudo chown -R caddy:caddy /var/www

# 1. 写入一些配置信息
参考 https://segmentfault.com/a/1190000018242765?utm_source=tag-newest

# 1. 重载服务文件
sudo systemctl daemon-reload
# 启动服务
sudo systemctl start caddy.service
# 开机自动运行
sudo systemctl enable caddy.service
# 查看服务状态
service v2ray status	| systemctl status caddy.service
服务参考：https://www.cnblogs.com/zdz8207/p/linux-systemctl.html

# 一键生成自动启动脚本
caddy -service install -conf /etc/caddy/Caddyfile


systemctl restart v2ray.service && systemctl start caddy.service

# 重启服务
service v2ray restart
service caddy restart

service caddy start


#添加开机自启
systemctl enable v2ray
systemctl enable caddy

# 启动cappy服务
/usr/local/bin/caddy -log stdout -agree=true -conf=/etc/caddy/Caddyfile -root=/var/tmp

# 日常查看指令
netstat -tlnp
ps -aux | grep cadd

# 一键BBR
# 参考 https://teddysun.com/489.html
# https://www.cnblogs.com/bluestorm/p/11484503.html
wget --no-check-certificate https://github.com/teddysun/across/raw/master/bbr.sh && chmod +x bbr.sh && ./bbr.sh

https://www.moerats.com/archives/10/
````

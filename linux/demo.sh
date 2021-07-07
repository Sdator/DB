#!/bin/bash

# 从网卡中删除动态ip
delip() {
    # 列出所有动态ip 和 广播地址 使用符号 - 连接起来
    addr=$(ip addr show eth0 | grep "inet\b" | awk '{print $2"-"$4}')
    for str in $addr; do
        # 从循环条目中取出 ip
        # ip=$(echo "${str}" | awk -F "-" '{print $1}')
        # 从循环条目中取出 广播地址
        # broadcast=$(echo "${str}" | awk -F "-" '{print $2}')
        # 从网卡中删除动态 ip
        # ip addr del "${ip}" broadcast "${broadcast}" dev eth0
        echo "ip addr del $(echo "${str}" | awk -F "-" '{print $1}') broadcast $(echo "${str}" | awk -F "-" '{print $2}') dev eth0"
    done

}

# 设置用户执行权限
userComRun() {
    echo 设置用户执行权限
    cat >/etc/sudoers.d/my <<EOF
# 设置普通可以不用密码执行容器命令
username ALL = (root) NOPASSWD: /usr/sbin/service docker *
EOF
}

# 添加开机运行脚本 ❌
addInitSc() {
    echo 添加开机运行脚本
    # 开机启动容器服务
    cat >/etc/init.d/my <<EOF
#!/bin/sh
service docker start
EOF
}

# 容器添加登录启动
# CMD & PowerShell   taskschd.msc
# schtasks /create /tn runDocker /ru system /RL HIGHEST /sc ONSTART /tr "wsl -u root -e service docker start"
runDocker() {
    echo 设置用户执行权限
    cat >/etc/sudoers.d/my <<EOF
# 设置普通可以不用密码执行容器命令
air ALL = (root) NOPASSWD: /usr/sbin/service docker *
EOF
    chmod 0440 /etc/sudoers.d/my
    echo 登录启动容器服务
    # 登录启动容器服务
    cat >/etc/profile.d/my.sh <<EOF

#!/bin/sh
# 如果容器没有运行就执行命令
sudo service docker status || sudo service docker start
EOF
}
runDocker
echo 456
cat /etc/sudoers.d/my
cat /etc/profile.d/my.sh

# ===================大量实验结果===========================
# find /mnt/c/Windows/ -name "hosts" -type f
# cut
# wsl -e ip addr show eth0
# ip addr show eth0 | grep "10\b" | awk '{print $2"-"$4}' |
#     ip addr show eth0 | grep "inet\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "for str in AA; do echo "$(echo \$str)"; done"
# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "for str in AA; do echo \"ip addr del \$(echo \$str | awk -F - '{print \$1}') broadcast \$(echo \$str | awk -F - '{print \$2}') dev eth0\"; done"

# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "for str in AA; do echo ip addr del \$(echo \$str | awk -F - '{print \$1}') broadcast \$(echo \$str | awk -F - '{print \$2}') dev eth0; done"

# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "for str in AA; do ip addr del \$(echo \$str | awk -F - '{print \$1}') broadcast \$(echo \$str | awk -F - '{print \$2}') dev eth0; done"

# # 1
# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | ip addr del $(echo \$str | awk -F - '{print $1}') broadcast $(echo \$str | awk -F - '{print $2}') dev eth0

# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | echo "ip addr del \$(echo \$str | awk -F - '{print \$1}') broadcast \$(echo \$str | awk -F - '{print \$2}') dev eth0"

# # 2
# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "echo ip addr del \$(echo AA | awk -F - '{print \$1}') broadcast \$(echo AA | awk -F - '{print \$2}') dev eth0"
# # 3
# ip addr show eth0 | grep "inet 10\b" | awk '{print $2"-"$4}' | xargs -I AA sh -c "ip addr del \$(echo AA | awk -F - '{print \$1}') broadcast \$(echo AA | awk -F - '{print \$2}') dev eth0"

# ip addr add 10.0.0.1/10 broadcast 10.0.0.255 dev eth0
# ip addr add 10.0.0.2/10 broadcast 10.0.0.255 dev eth0
# ip addr add 10.0.0.3/10 broadcast 10.0.0.255 dev eth0
# ip addr add 10.0.0.4/10 broadcast 10.0.0.255 dev eth0

# ip addr show eth0

# 4: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
#     link/ether 00:15:5d:d4:a1:d4 brd ff:ff:ff:ff:ff:ff
#     inet 172.22.184.178/20 brd 172.22.191.255 scope global eth0
#        valid_lft forever preferred_lft forever
#     inet6 fe80::215:5dff:fed4:a1d4/64 scope link
#        valid_lft forever preferred_lft forever

# ip addr show eth0 | grep "inet\b" | awk '{print $2,$4}' | xargs -pI{} ip addr del "$(awk '{print $1}')" broadcast "$(awk '{print $2}')" dev eth0
# ip addr del "$(awk '{print $1}')" broadcast "$(awk '{print $2}')" dev eth0

# cat <"1.txt" | awk '{print $1"-"$2}' | xargs sh -c "for f in \"\$@\";do echo \"\$f\";done"
# cat <"1.txt" | awk '{print $1"-"$2}' | xargs sh -c "for f in \$@;do echo \$f;done"

# cat <"1.txt" | awk '{print $1"-"$2}' | xargs sh -c "for f in \$@;do ip=$(echo "\$f" | awk -F "-" '{print \$1}');echo \$ip ;done"
# cat <"1.txt" | awk '{print $1"-"$2}' | xargs sh -c "for f in \$@;do ip=echo \$f|awk -F - '{print \$1}';echo \$ip ;done"

# sh -c 'cat <"1.txt"| awk {print\ \$1}'
# sh -c 'cat <"1.txt"| awk "{print \$1}"'
# sh -c "cat <\"1.txt\"| awk '{print \$1}'"

# cat <"1.txt" | awk '{print $1"-"$2}' | xargs sh -c "for f in \$@;do echo \$f|awk -F - '{print \$1}' ;done"

# cat <"1.txt" | awk '{print $1"-"$2}' | xargs -I AA echo "$(echo AA|awk -F - '{print $1}')"

# cat <"1.txt" | awk '{print $1"-"$2}' | xargs -I AA sh -c "echo AA|awk -F - '{print \$1}';echo AA|awk -F - '{print \$2}'"
# cat <"1.txt" | awk '{print $1"-"$2}' | xargs -I AA sh -c 'echo "$(echo AA|awk -F - "{print \$1}")"'
# cat <"1.txt" | awk '{print $1"-"$2}' | xargs -I AA sh -c 'echo $(echo AA|awk -F - "{print \$1}")'

# ip addr show eth0 | grep "inet\b" | awk '{print $2,$4}' | xargs -pI{} ip addr del "$(awk '{print $1}')" broadcast "$(awk '{print $2}')" dev eth0

# cat <"1.txt" | awk '{print $1,$2}' |xargs sh -c "for f in \"\$@\"; do printf '%s\n' \"\$f\"; done"

# for f in *; do printf '%s\n' "$f"; awk '{print $1}' < "$f"

# cat <"1.txt" | awk '{print $1,$2}' |xargs sh -c "for f in \$@; do printf '%s\n' \$f; awk '{print \$1}' < \"\$f""

# ; awk '{print $1}'
#  xargs -I {} sh -c "echo {}; awk '{print $1}'"

# cat <1.txt | awk '{print $2}'
# cat <1.txt | gawk "{print \$2}"

# cat <"1.txt" | awk "{print $1}"

#  "$({} | awk '{print $1}') broadcast $({} | awk '{print $2}') dev eth0"'

#  $(ip addr show eth0 | grep "inet\>" | awk '{print $4}')

# for str in "10.0.0.2" "10,0.0.100" ;do

# ip addr del "${ip}" broadcast "${broadcast}" dev eth0
# done

# ip addr add "10.0.0.100/32" broadcast "10.0.15.255" dev eth0
# ip addr del "10.0.0.100/24" broadcast "10.0.15.255" dev eth0

# ip addr add "10.0.0.2/32" broadcast "10.0.15.255" dev eth0
# ip addr del "10.0.0.2/24" broadcast "10.0.15.255" dev eth0
# sudo ip addr add 10.0.0.100/255.255.255.255 dev eth0
# sudo ip addr del "10.0.0.2/24" dev eth0

# ip route add default via 10.0.0.2
# 10.0.0.0/24 dev eth0 proto kernel scope link src 10.0.0.2
# ip addr del "" broadcast "${broadcast}" dev eth0

# ip addr show eth0;ip route

# 172.24.147.217/20-172.24.159.255
# 172.24.144.100/32-172.24.159.255
# 10.0.0.100/32-10.0.15.255
# 10.0.0.2/32-10.0.15.255

# default via 10.0.0.2 dev eth0
# 172.17.0.0/16 dev docker0 proto kernel scope link src 172.17.0.1 linkdown
# 172.19.0.0/16 dev br-60501fe12c5e proto kernel scope link src 172.19.0.1 linkdown
# 172.24.144.0/20 dev eth0 proto kernel scope link src 172.24.147.217

# inet 172.24.147.217/20 brd 172.24.159.255 scope global eth0
# inet 172.24.144.100/32 brd 172.24.159.255 scope global eth0
# inet 10.0.0.100/32 brd 10.0.15.255 scope global eth0
# inet 10.0.0.2/32 brd 10.0.15.255 scope global eth0

# link/ether 00:15:5d:e7:e6:6f brd ff:ff:ff:ff:ff:ff
# inet 172.24.147.217/20 brd 172.24.159.255 scope global eth0
#    valid_lft forever preferred_lft forever
# inet 172.24.144.100/32 brd 172.24.159.255 scope global eth0
#    valid_lft forever preferred_lft forever
# inet 10.0.0.100/32 brd 10.0.15.255 scope global eth0
#    valid_lft forever preferred_lft forever
# inet 10.0.0.2/32 brd 10.0.15.255 scope global eth0
#    valid_lft forever preferred_lft forever
# inet6 fe80::215:5dff:fee7:e66f/64 scope link
#    valid_lft forever preferred_lft forever

# ip addr show eth0 | grep "inet\b" | awk '{print $2,$4}'

# for((i=0;i<3;i++)); do touch "test ${i}.log";done

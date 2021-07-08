# ADB 常用指令

## ADB

```shell

adb devices -l # 列出设备

adb root    # 以root权限重新启动adbd
adb unroot  # 在没有root权限的情况下重新启动adbd

adb disable-verity # 禁止dm-verity检查
adb remount # 读写方式重新挂载

# 重启到 boot
# reboot 可选参数 [bootloader|recovery|sideload|sideload-auto-reboot]
adb reboot bootloader
# 重启到 ADB刷机模式 需要 （adb root）
adb reboot sideload
```

## shell

```shell
adb shell "ls -l /data/data/me.piebridge.brevent"


ls -l /data/.dataX.db

mount -o remount,rw /data
# 重新挂载 data 分区设置为可读
mount -o remount,r /data
mount -o ro,remount /data
mount -o rw,remount /

drwxrwx--x  60 system system   4096 2021-03-29 03:28 data
drwxr-xr-x   3 root   root       60 1970-01-01 08:00 res

# 找不到校验程序
$ adb shell avbctl disable-verification
# /system/bin/sh: avbctl: not found

adb disable-verity

```

## 获取剪贴板

```shell
# 启动服务
adb shell am startservice ca.zgrs.clipper/.ClipboardService
# 设置剪贴板内容
adb shell am broadcast -a clipper.set -e text "this can be pasted now"
# 读取剪贴板内容
adb shell am broadcast -a clipper.get

# 读取粘贴板二进制
adb shell service call clipboard 1
```

## 黑域

```shell
adb -d shell sh /data/data/me.piebridge.brevent/brevent.sh
```

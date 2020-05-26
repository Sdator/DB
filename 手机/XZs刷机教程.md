# 索尼XZs刷机教程
+ 最近咸鱼了一台索尼XZs 港版 4+64 双卡版型号为 G8232, 因此以下教程适用于 G8232
+ 以下操作会解锁你的手机导致 TA 分区丢失，会导致部分功能丢失如：超逼真、相机降噪算法消失..
+ 请自行备份 TA 分区后再刷, 由于机主原先已经解锁了所以对我来说无所谓了。

## 科普

在进行刷机之前有必要先认识一下索尼的特别之处，相比以前的刷机方法，索尼多了几重保护，所以和以前的刷机法是不通用的，但大体流程差不多。

+ TA 分区：索尼的特有分区用于保存相关凭证、密钥（DRM Key）等，可用作验证你是否有权使用索尼提供的增值服务
+ DRM 密钥: 索尼服务凭证 存在于TA分区中 也是某些功能的前提如：超逼真、相机降噪, 当解锁后就会丢失 意味着你失去了官方保修
+ SONY RIC: 分区保护 防止挂载 /system 系统分区进行写入
+ DM-Verity：分区完整性校验，当功能启动处于状态，你对系统分区进行了修改会导致无法启动

>以上问题都可通过打补丁、或魔改内核来解决，但 TA 丢失了就真的丢失了！


## 电脑安装adb套件
+ 方法一 
    + scoop install adb    # 如果你没有 scoop 包管理请使用方法二或自行准备
+ 方法二 
    + 手动下载 https://developer.android.com/studio/releases/platform-tools

## 电脑安装驱动
+ Flashtool http://www.flashtool.net/downloads_windows.php
+ Androxyde的驱动程序 https://github.com/Androxyde/Flashtool/tree/master/drivers  
+ 官方驱动 https://developer.sony.com/develop/drivers/

1. 下载 Flashtool64 并安装完成
1. 打开程序根目录找到 drivers 文件夹，打开找到 Flashtool-drivers.exe 双击安装
2. 期间勾选最顶部两项即 boot 和 adb 驱动即可
3. 出现驱动安装许可点击允许确认安装
>如果是 W10 系统安装 google 驱动部分可能会失败红色标记，这时候"关闭驱动签名验证"即可,方法自行百度



## 强刷 41.3.A.2.247 固件 （无需解锁）
1. 打开 Flashtool64 点击最右边的图标下载 XF（XperiFirm）
2. 打开 XperiFirm 找到 Xperia XZs 选择 G8232 dual
3. 在列表中下载想要刷入的版本
   
>当前时间为 2020.4.13 能搜到的最新版为 41.3.A.2.247 以上的步骤才有用  
>但以后出更新了以上步骤获得的最新版不适合本教程的后续步骤，所以你得使用我提供的版本

## 解锁bl
1. 进入索尼官网申请解锁码
1. 进入 bootloader 模式解锁 俗称蓝灯
    1. 手机关机
    1. 按住音量键+ 插入 usb 蓝灯出现松手 正常一秒左右出现，如果你按太久都没蓝灯说明有问题 重来吧
    1. 电脑键入 "fastboot ome 解锁码" 完成解锁

## 安装各种补丁
+ 电信补丁 4gvol
  + http://bbs.gfan.com/android-9530989-1-1.html

+ 修复 DRM 原理是绕过 DRM 验证
  + http://xxxx

+ Magisk root模块管理


+ 谷歌全家桶
  + https://opengapps.org/
  + https://github.com/opengapps/opengapps/wiki/Package-Comparison





## 参考帖子
+ https://forum.xda-developers.com/xzs/development/root-xperia-xzs-t3726911
+ https://forum.xda-developers.com/xperia-z5/development/root-automatic-repack-stock-kernel-dm-t3301605
+ https://forum.xda-developers.com/xzs/how-to/tutorial-step-step-guide-to-gain-root-t3612624
+ http://bbs.gfan.com/forum.php?mod=viewthread&tid=9175592&extra=page%3D1%26filter%3Dtypeid%26typeid%3D12859%26typeid%3D12859
+ https://www.zhihu.com/question/23337303
+ https://www.bilibili.com/video/av66609735/



## 其他有趣的东西
+ https://github.com/phhusson/treble_experimentations/wiki/Generic-System-Image-%28GSI%29-list


adb pull "/sdcard/Pictures/Screenshots/Screenshot_20200413-175541.png" Screenshot_20200413-175541.png 


  Screenshot_20200413-194640.png  Screenshot_20200413-194842.png



4 重启手机进入twrp终端命令界面输入以下命令并回车，来格式化system和vendor
make_ext4fs /dev/block/bootdevice/by-name/system
make_ext4fs /dev/block/bootdevice/by-name/vendor
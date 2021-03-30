# 索尼`XZs`刷机教程
+ 最近咸鱼了一台索尼 `XZs` 港版 4+32 （对方说是4+64被坑了）双卡版型号为 `G8232`, 因此以下教程适用于 `G8232`
+ 以下操作会解锁你的手机导致 TA 分区丢失，会导致部分功能丢失如：超逼真、相机降噪算法消失..
+ 请自行备份 TA 分区后再刷, 由于机主原先已经解锁过了所以对我来说无所谓了。

## 科普

在进行刷机之前有必要先认识一下索尼的特别之处，相比以前的刷机方法，索尼多了几重保护，所以和以前的刷机法是不通用的，但大体流程差不多。

+ TA 分区：索尼的特有分区用于保存相关凭证、密钥（`DRM Key`）等，可用作验证你是否有权使用索尼提供的增值服务
+ `DRM 密钥`: 索尼服务凭证 存在于TA分区中 也是某些功能的前提如：超逼真、相机降噪, 当解锁后就会丢失 意味着你失去了官方保修
+ `SONY RIC`: 分区保护 防止挂载 /system 系统分区进行写入
+ `DM-Verity`：分区完整性校验，当功能处于启动状态，你对系统分区进行了修改会导致无法启动

>以上问题都可通过打补丁、或魔改内核来解决，但 TA 丢失了就真的丢失了！


## 电脑安装`adb`套件
+ 方法一 
    + `scoop install adb`    # 如果你没有 scoop 包管理请使用方法二或自行准备
+ 方法二 
    + 手动下载 https://developer.android.com/studio/releases/platform-tools

## 电脑安装驱动
+ `Flashtool`【推荐】 http://www.flashtool.net/downloads_windows.php
+ `Androxyde` 的驱动程序 https://github.com/Androxyde/Flashtool/tree/master/drivers  
+ 官方驱动 https://developer.sony.com/develop/drivers/

1. 下载 `Flashtool64` 并安装完成
1. 打开程序根目录找到 `drivers` 文件夹，打开找到 `Flashtool-drivers.exe` 双击安装
2. 期间勾选最顶部两项即 `boot` 和 `adb` 驱动即可
3. 出现驱动安装许可点击允许确认安装
>如果是 `W10` 系统安装 `google` 驱动部分可能会失败有错误的红色标记提示，这时候"关闭驱动签名验证"即可

```powershell
# W10 打开 CMD 执行以下命令
bcdedit.exe /set nointegritychecks on 	# 关闭签名
bcdedit.exe /set nointegritychecks off 	# 打开签名
```

## 强刷 `41.3.A.2.247` 固件 （无需解锁）
1. 打开 `Flashtool64` 点击最右边的图标下载 `XF（XperiFirm）`
2. 打开 `XperiFirm` 找到 `Xperia XZs` 选择 `G8232 dual`
3. 在列表中下载想要刷入的版本
4. 刷机包下载好后，切换到`Flashtool64` 进行`ftf`打包，选择 `Tools > bundles > Create`
   1. 第一栏选择`XperiFirm` 下载的刷机包所在路径
   2. 第二栏选择你的型号
   3. 第三栏填写地区英文缩写
   4. 第四栏填写刷机包版本
   5. 再往下方文件列表选中所有文件并点击右方的->箭头按钮添加所有文件到右边。
   6. 最后点击`Create`创建，请耐心等待打包完毕。
5. 打包完毕后点击软件主界面的工具栏左边的雷电图标，选择`Flashmode`点击`ok`。
   1. 第一栏选择打包后的 `ftf`文件所在位置
   2. 第二栏选择机型【如果`Firmwares`中已经显示了你的刷机包可不选】
   3. 在`Firmwares`找到并选中你刚才打包的项目
   4. 勾选 `Wipe Sin`下的所有选项清除这些分区。
   5. 最后点击Flash开始刷机。
6. 手机关机状态下按住音量键下（即减）再插入`USB`，等待刷机完毕即可。



>当前时间为 2020.4.13 能搜到的最新版为 `41.3.A.2.247` 以上的步骤才有用  
>但以后更新了以上步骤获得的最新版不适合本教程的后续步骤，所以你得使用我提供的版本

## 解锁bl
1. 进入索尼官网申请`解锁码`
1. 进入 `bootloader` 模式解锁 俗称蓝灯
    1. 手机关机
    
    1. 按住音量键+ 插入 `usb` 蓝灯出现松手 正常一秒左右出现，如果你按太久都没蓝灯说明有问题 重来吧
    
    1. 电脑键入 "`fastboot oem unlock 0x解锁码`" 完成解锁
    
       > 如：`fastboot oem unlock 0x3695490313CB7CFD`

## 刷入`twrp`

1. 手机`usb`连接电脑
2. 安装 `adb`驱动 `scoop install -g adb`
3. 进入 `bootloader` 蓝灯模式
   1. 方法一
      1. 手机关机
      2. 按住音量键+ 插入 `usb` ，待蓝灯出现松手 正常一秒左右出现，如果你按太久都没蓝灯说明有问题 重来吧
   2. 方法二
      1. 执行命令 `adb reboot bootloader` 
4. 执行命令 `fastboot flash recovery <filename>`  把`twrp`写入`rec`



## 



## 安装各种补丁
+ 电信补丁 `4gvol`
  + http://bbs.gfan.com/android-9530989-1-1.html

+ 修复 `DRM` 原理是绕过 `DRM` 验证
  + http://xxxx

+ `Magisk root`模块管理


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

```
adb pull "/sdcard/Pictures/Screenshots/Screenshot_20200413-175541.png" Screenshot_20200413-175541.png
```



重启手机进入`twrp`终端命令界面输入以下命令并回车，来格式化system和vendor

```
make_ext4fs /dev/block/bootdevice/by-name/system
make_ext4fs /dev/block/bootdevice/by-name/vendor
```



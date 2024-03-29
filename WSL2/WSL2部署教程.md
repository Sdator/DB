# WSL2 基础教程

- [WSL2 基础教程](#wsl2-基础教程)
  - [WSL 2 系统要求](#wsl-2-系统要求)
  - [环境信息](#环境信息)
  - [一次部署过程](#一次部署过程)
  - [分发本土化（中文）](#分发本土化中文)
    - [安装中文版 man 帮助信息](#安装中文版-man-帮助信息)
    - [修改系统语言为中文](#修改系统语言为中文)
  - [WSL 常用命令](#wsl-常用命令)
    - [查看](#查看)
    - [安装](#安装)
    - [运行、停止、删除](#运行停止删除)
    - [切换版本](#切换版本)
    - [旧版 Windows 系统升级 WSL2 方法](#旧版-windows-系统升级-wsl2-方法)
    - [可用发行版](#可用发行版)
  - [参考](#参考)

## WSL 2 系统要求

- 推荐最低安装 W10_2004 以及以上
- 查看 Windows 系统版本
  - 打开 cmd 或 win键 + r 输入 winver
  - 打开 cmd 执行 systeminfo | find "OS 版本"

- 摘自微软官方
  - 若要更新到 WSL 2，需要运行 Windows 10。
  - 对于 x64 系统：版本 1903 或更高版本，采用内部版本 18362 或更高版本。
  - 对于 ARM64 系统：版本 2004 或更高版本，采用内部版本 19041 或更高版本。
  - 低于 18362 的版本不支持 WSL 2。 使用 Windows Update 助手更新 Windows 版本。

  > 如果运行的是 Windows 10 版本1903 或 1909，请在 Windows 菜单中打开“设置”，导航到“更新和安全性”，然后选择“检查更新”。 内部版本号必须是 18362.1049+ 或 18363.1049+，次要内部版本号需要高于 .1049。 阅读详细信息：WSL 2 即将支持 Windows 10 版本 1903 和 1909。

## 环境信息

- 当前系统版本：W10_2H02 19044.1526
- 安装后的发行版：Ubuntu 20.04 LTS 【默认版本】
- WSL版本：2.0

## 一次部署过程

1. 确认在主板 BIOS 里开启了虚拟化
1. 设置 wsl2 为默认配置
    - `wsl --set-default-version 2`
1. 列出支持的发行版(系统、分发)
    - `wsl -l -o`
1. 安装分发 (无参默认安装 ubuntu)
    - `wsl --install [分发]`
1. 系统语言本土化 可选
   - [分发本土化（中文）](#分发本土化中文)

## 分发本土化（中文）

### 安装中文版 man 帮助信息

```bash
> sudo apt install manpages-zh -y
```

### 修改系统语言为中文

- 查看当前系统设置的语言：locale
- 查看当前系统支持的语言：locale -a

生成语言环境：

```bash
> sudo locale-gen zh_CN.UTF-8
```

设置语言：

```bash
> sudo update-locale LANG=zh_CN.UTF-8
```

重启wsl：

- 最简单的又能让语言生效的方法是在一个新的窗口中运行 wsl
- 以下三种方法随便运行一条即可 管理员身份运行

```bash
> wsl -t <发行版名称> # 停止发行版  (PowerShell)
> net stop LxssManager && net start LxssManager # 重启服务    (cmd)
> Restart-Service LxssManager # 重启服务    (PowerShell)
```

测试日期是否显示为中文格式：

```bash
> date
```

如上述方法不起作用请尝试以下操作：

- 另外需要注意您的 `~/.profile`、`~/.bashrc`、`~/.bash_profile` 配置文件中是否设置了语言相关命令

```bash
> sudo dpkg-reconfigure locales
> sudo locale-gen zh_CN
> sudo locale-gen zh_CN.UTF-8
> sudo update-locale LANG="zh_CN.UTF-8" LANGUAGE="zh_CN"  # 设置完后记得重启wsl
```

## WSL 常用命令

### 查看

查看所有发行版详细情况：

```powershell
> wsl -l -v
```

列出当前可用发行版：

```powershell
> wsl -l -o
```

查看当前正在运行的发行版：

```powershell
> wsl --list --running
```

### 安装

- 设置默认安装版本 建议运行一次 当然你要符合使用 [WSL 2 系统要求](#wsl-2-系统要求)
  - wsl --set-default-version 2

默认安装：

```powershell
> wsl --install
```

>默认安装的是WSL1.0的 Ubuntu 20.04 LTS  建议先设定 WSL 默认版本为 2.0

 安装指定版本：

```powershell

> wsl --install -d <发行版名字>
> wsl --install -d Ubuntu
> wsl --install -d Ubuntu-20.04 2
```

导出发行版到 tar 文件：

```powershell
> wsl --export <自定义发行版名称> <导出路径>
> wsl Ubuntu_2022 D:\ubuntu20.04.tar
```

导入分发：

```powershell
> wsl --import <自定义发行版名称> <安装路径> <导入文件路径>
> wsl Ubuntu_2022 D:\OS\Ubuntu D:\linux\Ubuntu.tar
```

>自定义发行版名称 建议不要写成 Ubuntu 避免和原发行版名称冲突

### 运行、停止、删除

运行默认发行版

```powershell
> wsl
```

运行指定发行版：

```powershell
> wsl -d <发行版名称>
```

停止指定的发行版：

```powershell
> wsl -t <发行版名称>
```

停止所有正在运行的发行版：

```powershell
> wsl --shutdown
```

从系统中删除发行版：

```powershell
> wsl --unregister <发行版名称>
```

### 切换版本

- 首先输入命令查看当前版本 `wsl -l -v`，如果 `VERSION` 输出为 `1` 则输入 `wsl --set-version <发行版名字> 2` 把当前发行版切换到 `wsl 2.0` 内核，等待几分钟即可

把现有的版本切换到其他版本：

```powershell
> wsl --set-version <发行版名字> <wsl版本>
> wsl --set-version Ubuntu-20.04 2
```

### 旧版 Windows 系统升级 WSL2 方法

- 以管理员身份打开 PowerShell 并运行

1.启动 linux 子系统功能

```powershell
> dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
```

2.启用 hyper-v 虚拟机

```powershell
> dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

3.安装 WSL2 linux 内核 根据自己系统类型下载并安装

- 查看系统类型：

  ```powershell
  > systeminfo | find "系统类型"
  ```

- X86 ：
  - <https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi>

- arm64：
  - <https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_arm64.msi>

### 可用发行版

- 2022.02.26

```txt
Debian          Debian GNU/Linux
kali-linux      Kali Linux Rolling
openSUSE-42     openSUSE Leap 42
SLES-12         SUSE Linux Enterprise Server v12
Ubuntu          Ubuntu
Ubuntu-16.04    Ubuntu 16.04 LTS
Ubuntu-18.04    Ubuntu 18.04 LTS
Ubuntu-20.04    Ubuntu 20.04 LTS
```

## 参考

- 安装方法：
  - <https://docs.microsoft.com/zh-cn/windows/wsl/install>
  - <https://docs.microsoft.com/zh-cn/windows/wsl/install-manual>
- 详细命令：
  - <https://docs.microsoft.com/en-us/windows/wsl/basic-commands>
- WSL 常见问题：
  - <https://docs.microsoft.com/en-us/windows/wsl/faq>

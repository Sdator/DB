# Scoop入门帮助

## 目录

- [Scoop入门帮助](#scoop%e5%85%a5%e9%97%a8%e5%b8%ae%e5%8a%a9)
  - [目录](#%e7%9b%ae%e5%bd%95)
  - [系统要求](#%e7%b3%bb%e7%bb%9f%e8%a6%81%e6%b1%82)
  - [简介](#%e7%ae%80%e4%bb%8b)
  - [Scoop安装](#scoop%e5%ae%89%e8%a3%85)
  - [自定义包安装目录](#%e8%87%aa%e5%ae%9a%e4%b9%89%e5%8c%85%e5%ae%89%e8%a3%85%e7%9b%ae%e5%bd%95)
  - [门槛](#%e9%97%a8%e6%a7%9b)
  - [常用命令](#%e5%b8%b8%e7%94%a8%e5%91%bd%e4%bb%a4)
  - [例子](#%e4%be%8b%e5%ad%90)
  - [小提示](#%e5%b0%8f%e6%8f%90%e7%a4%ba)

>*`2019/2/10 PM By：Air`*



## 系统要求
* Windows 7 SP1 + / Windows Server 2008 +
* PowerShell 5 + / .NET Framework 4.5 +

## 简介
* Scoop 是一款 Windows 上的软件包管理工具，类似于 Linux 上的 apt、yum 等
* 它可以提升你在 Windows 平台上的开发环境部署效率 
* 你也可以用它来安装一些日常软件，如 7z 、 vscode 、vc 支持库 ，当然还能安装游戏需要某些仓库支持即 `bucket`



## Scoop安装

```powershell
# 启用 powershell 脚本运行
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# 安装 Scoop 需联网
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')

# 自定义 Scoop 安装路径
$env:SCOOP='D:\Applications\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')
```

## 自定义包安装目录
+ 包的意思就是通过 scoop install xx 安装的程序
+ 默认情况下是安装到系统盘，更改后安装需要加参数-g 并且要以管理员身份执行

```powershell
# 自定义 包默认路径
$env:SCOOP_GLOBAL='D:\GlobalScoopApps'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
```

## 门槛
+ 安装 aria2 多线程下载
+ 设置代理

```bash
# 安装aria2
scoop install aria2
# 启用aria2 默认是开启的
scoop config aria2-enabled true
# 修改最大连接数 默认是 5 视机器配置网速而定
# 参数设置过太会堵塞网络，同时网站也有可能会封 IP 或阻断连接
scoop config aria2-max-connection-per-server 50

# 代理设置 建议采用http协议 但无需填写协议前缀 
scoop config proxy proxy.example.org:8080
scoop config proxy 127.0.0.1:8080
scoop config proxy localhost:8080
```


## 常用命令

1. 添加仓库源
   - 默认提供的源可能不包含你需要的软件 可通过添加相关的源来获取
   - 常见的源 extras、games、java 、php 
   - scoop bucket add `bucketName`
   - scoop bucket add extras
  
2. 列出安装了的软件
   - scoop list

3. 安装软件
    - 默认安装
      - scoop install `AppName`
      - scoop install vscode
    - 全局安装
      - scoop install -g `AppName`
      - scoop install -g vscode
    - 安装多个
      - scoop install vscode 7z python crul
      - scoop install -g vscode 7z python crul
  
4. 卸载软件
   - 卸载默认安装的程序
     - scoop uninstall `AppName`
     - scoop uninstall vscode
   - 卸载全局安装的程序
      - scoop uninstall -g vscode

5. 升级软件
   - 升级所有
      - scoop update `AppName`
      - scoop update *
   - 全局升级
      - scoop update -g `AppName`
      - scoop update -g *
    > `*` 表示升级全部软件

6. 搜索软件
   - scoop search `AppName`
   - scoop search vscode
   - scoop search vsco
   > 不填写全名也可以搜索
    
7. 缓存
   - 查看缓存
        - scoop cache
    - 清理所有
        - scoop cache app *
    - 清理指定app
        - scoop cache app `[AppName]`
 
8. 旧版本清理
   - 使用说明
     - scoop cleanup <app> [options]
     - -g 清理全局安装
     - -k 删除过时的缓存
   - 清理指定程序的旧版本
     - scoop cleanup vscode
   - 清理使用了全局安装的旧版本程序
     - scoop cleanup vscode -g
   - 清理所有正常安装的旧版本程序
      - scoop cleanup *
   - 清理所有全局安装的旧版本程序 同时 清理缓存
      - scoop cleanup * -g -k

> 参数可自由组合使用

## 例子
```bash
# 安装7z
scoop install 7zip
# 安装 git (windows)、vscode
scoop install git vscode
# 安装 py 到自定义路径
scoop install -g python


# 卸载 git、vscode
scoop uninstall git vscode
# 卸载全局安装的 py
scoop uninstall -g python


# 升级 py 版本
scoop update -g python

# 清理所有下载缓存即安装包和版本过旧的程序
scoop cleanup * -g -k

```


## 小提示

> 部分 `AppName` 可用通配符 `*` 代替 如：  
> scoop cache rm * 表示清理所有缓存  
> scoop update * 表示升级全部软件  

> 安装安装不带参数，全局安装带参数-g 如:
> scoop install -g vscode

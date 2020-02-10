# Scoop入门帮助

## 目录

- [Scoop入门帮助](#scoop%e5%85%a5%e9%97%a8%e5%b8%ae%e5%8a%a9)
  - [目录](#%e7%9b%ae%e5%bd%95)
  - [系统要求](#%e7%b3%bb%e7%bb%9f%e8%a6%81%e6%b1%82)
  - [简介](#%e7%ae%80%e4%bb%8b)
  - [Scoop安装](#scoop%e5%ae%89%e8%a3%85)
  - [程序安装到自定义目录](#%e7%a8%8b%e5%ba%8f%e5%ae%89%e8%a3%85%e5%88%b0%e8%87%aa%e5%ae%9a%e4%b9%89%e7%9b%ae%e5%bd%95)
  - [小提示](#%e5%b0%8f%e6%8f%90%e7%a4%ba)
  - [常用命令](#%e5%b8%b8%e7%94%a8%e5%91%bd%e4%bb%a4)

>*`2019/2/10 PM By：Air`*



## 系统要求
* Windows 7 SP1 + / Windows Server 2008 +
* PowerShell 5 + / .NET Framework 4.5 +

## 简介
* Scoop 是一款 Windows 上的软件包管理工具，类似于 Linux 上的 apt、yum 等
* 它可以提升你在 Windows 平台上的开发环境部署效率 
* 你也可以用它来安装一些日常软件，如 7z 、 vscode 、vc 支持库 ，当然还能安装游戏`需要某些仓库支持即 bucket `



## Scoop安装

```powershell
# 启用 powershell 脚本运行
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
# 安装 Scoop 需联网
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
```

## 程序安装到自定义目录
```powershell
# 这里的路径修改为你自定义的目录即可

# 正常安装 默认路径
$env:SCOOP='D:\Applications\Scoop'
[Environment]::SetEnvironmentVariable('SCOOP', $env:SCOOP, 'User')

# 全局安装 默认路径
$env:SCOOP_GLOBAL='F:\GlobalScoopApps'
[Environment]::SetEnvironmentVariable('SCOOP_GLOBAL', $env:SCOOP_GLOBAL, 'Machine')
```

## 小提示

> 部分 `AppName` 可用通配符 `*` 代替 如：  
> scoop cache app * 表示清理所有缓存  
> scoop update * 表示升级全部软件  

> 安装安装不带参数，全局安装带参数-g 如:
> scoop install -g vscode


## 常用命令



1. 列出安装了的软件
   - scoop list

2. 安装软件
    - 默认安装
      - scoop install `AppName`
      - scoop install vscode
    - 全局安装
      - scoop install -g `AppName`
      - scoop install -g vscode
    - 安装多个
      - scoop install vscode 7z python crul
      - scoop install -g vscode 7z python crul
  
3. 卸载软件
   - 卸载默认安装的程序
     - scoop uninstall `AppName`
     - scoop uninstall vscode
   - 卸载全局安装的程序
      - scoop uninstall -g vscode

4. 升级软件
   - 升级所有
      - scoop update `AppName`
      - scoop update *
   - 全局升级
      - scoop update -g `AppName`
      - scoop update -g *
    > `*` 表示升级全部软件

5. 搜索软件
   - scoop search `AppName`
   - scoop search vscode
   - scoop search vsco
   > 不填写全名也可以搜索
    
6. 缓存
   - 查看缓存
        - scoop cache
    - 清理所有
        - scoop cache app *
    - 清理指定app
        - scoop cache app `[AppName]`
 
7. 旧版本清理
   - 使用说明
     - scoop cleanup <app> [options]
     - -g 清理全局安装
     - -k 删除过时的缓存
   - 清理指定程序的旧版本
     - scoop cleanup vscode
   - 清理使用了全局安装的程序
     - scoop cleanup vscode -g
   - 清理所有正常安装的程序
      - scoop cleanup *
   - 清理所有全局安装的程序 同时 清理缓存
      - scoop cleanup * -g -k

> 参数可自由组合使用


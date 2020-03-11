# youtube-dl 入门教程


- [youtube-dl 入门教程](#youtube-dl-%e5%85%a5%e9%97%a8%e6%95%99%e7%a8%8b)
  - [安装](#%e5%ae%89%e8%a3%85)
  - [命令格式](#%e5%91%bd%e4%bb%a4%e6%a0%bc%e5%bc%8f)
  - [常用参数](#%e5%b8%b8%e7%94%a8%e5%8f%82%e6%95%b0)
    - [信息相关](#%e4%bf%a1%e6%81%af%e7%9b%b8%e5%85%b3)
    - [下载相关](#%e4%b8%8b%e8%bd%bd%e7%9b%b8%e5%85%b3)
    - [连接相关](#%e8%bf%9e%e6%8e%a5%e7%9b%b8%e5%85%b3)
  - [例子](#%e4%be%8b%e5%ad%90)
>*`2019/2/24 PM By：Air`*

## 安装
```powershell
scoop install -g youtube-dl
```

## 命令格式
```powershell
youtube-dl [参数] 视频地址
```

## 常用参数
### 信息相关
+ `-F` 查看视频提供下载的所有类型 只看不下载
+ `--get-thumbnail` 获取封面连接
+ `-j` 列出视频相关信息json格式
  
### 下载相关
+ `-f` 下载指定视频索引 720p、1080p -F 可列出来
+ `--skip-download` 不下载视频
+ `-s` 不下载视频且不要往硬盘写入任何东西
+ `--console-title` 显示进度条
+ `--newline` 在下一行递增进度条
+ `--external-downloader` 使用外部下载器 目前支持aria2c，avconv，axel，curl，ffmpeg，httpie，wget
+ `--external-downloader-args ARGS` 将这些参数提供给外部下载器
+ `--playlist-items ITEM_SPEC` 下载视频列表指定项目

### 连接相关
+ `--proxy` 使用代理支持 HTTP / HTTPS / SOCKS
+ `--print-traffic` 显示已发送和读取的HTTP流量


## 例子
下载单个视频
```bash
youtube-dl 视频地址
youtube-dl https://www.nicovideo.jp/watch/sm22522560 
```
使用代理
```bash
youtube-dl --proxy 127.0.0.1:10000 https://www.youtube.com/watch?v=fKu0cgaS3KU
```

下载画质最好的mp4命令
```bash
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 视频地址
```

下载整个视频列表
```powershell
youtube-dl 视频列表地址
```

使用aria2c下载
```bash
youtube-dl --external-downloader aria2c --external-downloader-args "-x 16 -k 1M" https://www.youtube.com/watch?v=fKu0cgaS3KU
```

终极下载 组合上面所学
```
youtube-dl --proxy 127.0.0.1:10000 -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --external-downloader aria2c --external-downloader-args "-x 16 -k 1M  --all-proxy 127.0.0.1:10000" https://www.youtube.com/watch?v=fKu0cgaS3KU
```
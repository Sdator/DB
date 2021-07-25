# youtube-dl 入门教程

- [youtube-dl 入门教程](#youtube-dl-入门教程)
  - [安装](#安装)
  - [命令格式](#命令格式)
  - [常用参数](#常用参数)
    - [信息相关](#信息相关)
    - [下载相关](#下载相关)
    - [连接相关](#连接相关)
  - [例子](#例子)
    > _`2019/2/24 PM By：Air`_

## 安装

```powershell
scoop install -g extras/vcredist2010 ffmpeg youtube-dl
```

## 命令格式

```powershell
youtube-dl [参数] 视频地址
```

## 常用参数

### 信息相关

- `-F` 查看视频提供下载的所有类型 只看不下载
- `--get-thumbnail` 获取封面连接
- `-j` 列出视频相关信息 json 格式
- `--list-extractors`列出支持提取列表

### 下载相关

- `-f` 下载指定视频索引 720p、1080p -F 可列出来
- `--skip-download` 不下载视频
- `-s` 不下载视频且不要往硬盘写入任何东西
- `--console-title` 显示进度条
- `--newline` 在下一行递增进度条
- `--external-downloader` 使用外部下载器 目前支持 aria2c，avconv，axel，curl，ffmpeg，httpie，wget
- `--external-downloader-args ARGS` 将这些参数提供给外部下载器
- `--playlist-items ITEM_SPEC` 下载视频列表指定项目

### 连接相关

- `--proxy` 使用代理支持 HTTP / HTTPS / SOCKS
- `--print-traffic` 显示已发送和读取的 HTTP 流量

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

下载画质最好的 mp4 命令

```bash
youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 视频地址
```

下载整个视频列表

```powershell
youtube-dl 视频列表地址
```

使用 aria2c 下载

```bash
youtube-dl --external-downloader aria2c --external-downloader-args "-x 16 -k 1M" https://www.youtube.com/watch?v=fKu0cgaS3KU
```

终极下载 组合上面所学

```
youtube-dl --proxy 127.0.0.1:10000 -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 --external-downloader aria2c --external-downloader-args "-x 16 -k 1M  --all-proxy 127.0.0.1:10000" https://www.youtube.com/watch?v=fKu0cgaS3KU
```

# youtube-dl 入门教程
>### # 安装
```powershell
scoop install -g youtube-dl
```

>### # 命令格式
+ youtube-dl [参数] 视频地址


>### # 常用参数
信息相关
+ `-F` 查看视频提供下载的所有类型 只看不下载
+ `--get-thumbnail` 获取封面连接
+ `-j` 列出视频相关信息json格式
  
下载相关
+ `-f` 下载指定视频索引 720p、1080p -F 可列出来
+ `--skip-download` 不下载视频
+ `-s` 不下载视频且不要往硬盘写入任何东西
+ `--console-title` 显示进度条
+ `--newline` 在下一行递增进度条
+ `--external-downloader` 使用外部下载器 目前支持aria2c，avconv，axel，curl，ffmpeg，httpie，wget
+ `--external-downloader-args ARGS` 将这些参数提供给外部下载器
+ `--playlist-items ITEM_SPEC` 下载视频列表指定项目
+ `youtube-dl -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4` 下载画质最好的mp4命令

2人点赞
Mark备忘


作者：coinpool
链接：https://www.jianshu.com/p/c3c757ab7683
来源：简书
著作权归作者所有。商业转载请联系作者获得授权，非商业转载请注明出处。


连接相关
+ `--proxy` 使用代理支持 HTTP / HTTPS / SOCKS
+ `--print-traffic` 显示已发送和读取的HTTP流量



>### # 常用命令&例子


下载单个视频
```powershell
youtube-dl 视频地址
youtube-dl https://www.nicovideo.jp/watch/sm22522560 
```

下载整个视频列表
```powershell
youtube-dl 视频列表地址
```

使用aria2c下载
```bash
youtube-dl --external-downloader aria2c --external-downloader-args "-x 16 -k 1M" https://www.youtube.com/watch?v=fKu0cgaS3KU

```
youtube-dl --get-filename --get-duration https://www.nicovideo.jp/watch/sm22522560 



youtube-dl --external-downloader aria2c --external-downloader-args "-x 16 -k 1M" https://youtu.be/lWB5ix6_kRs
  



248          webm       1920x1080  1080p 2801k , vp9, 30fps, video only, 71.57MiB
137          mp4        1920x1080  1080p 4159k , avc1.640028, 30fps, video only, 104.51MiB
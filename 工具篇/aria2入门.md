# aria2常用命令

## 参数

+ `-x,--max-connection-per-server [1-16]` 与一个服务器的最大连接数
+ `-k, --min-split-size [xxK/xxM]` 分割文件
+ `--all-proxy 127.0.0.1:10000` 使用代理


## 例子
```bash
# 使用最大连接数下载
aria2c -x 16 url

# 把文件20M每段段下载
aria2c -k 20M url

# 使用代理下载
aria2c --all-proxy 127.0.0.1:10000 url

# 修改最大连接分段并使用代理下载
aria2c -x 16 -k 5M --all-proxy 127.0.0.1:10000 url

```

aria2c -x 16 -k 5M --all-proxy 127.0.0.1:10000 "https://github.com/be5invis/Sarasa-Gothic/releases/download/v0.11.0/sarasa-gothic-ttc-0.11.0.7z"
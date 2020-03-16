>### #参数
+ `-x,--max-connection-per-server [1-16]` 与一个服务器的最大连接数
+  `-k, --min-split-size [xxK/xxM]` 分割文件


## 例子
```bash
aria2c -x 16 -k 5M https://download.lfd.uci.edu/pythonlibs/s2jqpv5t/PyQt4-4.11.4-cp37-cp37m-win_amd64.whl
aria2c -x 16 -k 5M --all-proxy "127.0.0.1:10000" https://download.lfd.uci.edu/pythonlibs/s2jqpv5t/PyQt4-4.11.4-cp37-cp37m-win_amd64.whl

```
javascript:;
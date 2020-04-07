## 格式
+ npk 索引文件
+ npkv 贴图数据



角色三种压缩格式文件
+ *.npk.scz
+ *.npki.scz
+ *.npkv.scz

cmp_scz.bms 解包对应
+ .npk 是.sdr文件的集合
  + 存储着如 mesh， texture 的索引
+ .npki 是 .sdri 的文件集合
  + 储存真正的 vertex buffer & indices buffer  、mesh的buffer
+ .npkv 是.sdrv文件集合
  + 储存 texture buffer 贴图缓存数据

使用KMS配合着
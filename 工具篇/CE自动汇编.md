{$lua}
print('Hello World!')
{$asm}
define(someConstant,1)

## 自动汇编
+ 使用 CEA 格式保存
自动汇编模板
```asm
//// --------------------  主要部分  ---------------------

[ENABLE]
//// --------------------  启用部分 ---------------------
// 脚本开启后使用这里的代码修改


[DISABLE]
//// --------------------  禁用部分  --------------------
// 脚本关闭后使用这里的代码还原

```

自动汇编函数
```asm
# 在当前文件目录中导入 someCeaFile.CEA  后缀可不写
include(someCeaFile) 	
include(someCeaFile.CEA) 

aobScan：将扫描内存以查找给定的字节数组（支持通配符），并在第一个匹配项处放置标签
aobScanModule：将扫描特定模块的给定字节数组（支持通配符），并在第一个匹配项处放置标签
aobScanRegion：将扫描给定字节数组的特定范围（支持通配符），并在第一个匹配项处放置标签
label：启用标签名称一词作为地址
alloc：用指向它的标签分配一个内存区域
dealloc：解除分配由alloc分配的内存块
globalAlloc：将分配一定数量的内存并注册指定的名称
kAlloc：内核分配
fullAccess：使内存区域可读，可写且可执行
reassemble：重新组装给定的地址，在其声明的位置写入。
readMem：读取内存区域并将其写入此指令所在的位置
registerSymbol：将符号添加到用户定义的符号列表中
unregisterSymbol：从用户定义的符号列表中删除符号
define：将指定名称的所有标记替换为任何文本
assert：将检查给定字节的内存地址
include：在该位置包含另一个自动汇编器文件
createThread：将在进程中的指定地址处生成线程
createthreadandwait：将在进程中的指定地址处生成线程，并等待其返回
loadLibrary：将指定的dll注入目标进程
loadBinary：将在指定地址加载二进制文件
struct / endStruct：使用STRUCT和ENDSTRUCT，您可以在自动汇编脚本中定义内部结构
luaCall：执行给定的Lua代码
{$ LUA} / {$ ASM}：{$ LUA}（Lua）和{$ ASM}（Assembler）将开始给定的解析器
{$ STRICT}：{$ STRICT}将通过抛出错误来强制标签声明
align：告诉汇编器对齐给定的字节大小。
{$ TRY} / {$ EXCEPT}：发生异常时，{$ TRY}和{$ EXCEPT}块之间的代码将跳到{$ EXCEPT}部分
```


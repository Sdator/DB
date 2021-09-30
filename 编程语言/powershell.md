## 基本概念

- cmdlet
  - PowerShell 命令称为 cmdlet；读作“command-lets”。
  - 每个 cmdlet 的名称都包含一个“谓词-名词”对 如 Get-xxx、Set-xxx

## 常用指令

| 常用指令    |                                                                                                                                                                                                      |
| ----------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Get-Verb    | 返回大多数命令遵循的谓词的列表。 此外，响应还会说明这些谓词执行哪些操作。 由于大多数命令都遵循这种命名方式，因此，它设置了命令的预期操作，这样有助于你选择适当的命令，也可帮助你在创建命令时为其命名 |
| Get-Command | 检索计算机上安装的所有命令的列表                                                                                                                                                                     |
| Get-Member  | 它在基于对象的输出上运行，并且能够发现可用于命令的对象、属性和方法                                                                                                                                   |
| Get-Help    | 以命令名称为参数调用此命令，将显示一个帮助页面，其中说明了命令的各个部分                                                                                                                             |

```powershell
# 查看版本
$PSVersionTable

# 列举属性方法 xxx | gm
(Get-UICulture).DateTimeFormat | gm

# 格式化
Format-List \*

# 查看帮助
# Get-Help cmdlet
(Get-UICulture).DateTimeFormat | gm

```

## 特殊文件

- DotNetTypes.format.ps1xml

## 查

- Get-Command

### Get-Command

- Verb 动词
- Noun 名词
- ParameterType 返回类型

```powershell
# 按动词 和 名词搜索
Get-Command -Verb Get -Noun a-noun*
# 查找关于 进程Process 类型的所有命令
Get-Command -ParameterType Process


```

```powershell
# 列出项目
Get-ChildItem
Get-ChildItem -Path C:\Test

Get-Culture | Format-List _
Get-UICulture | Format-List _

Get-Culture | gm
(Get-UICulture).DateTimeFormat.ShortDatePattern

System.Globalization.TextInfo
(Get-Culture).TextInfo | gm

```

## 例子

### 过滤

- Property 属性可省略
- Sort-Object @{ e = 'LastWriteTime'; d = $true }, @{ e = 'Name'; a = $true }

#### 哈希填参

```powershell
# 字符串选择属性
# 选择属性 LastWriteTime 降序排列 按文件的最新的写入时间排在最前
# 选择属性 Name 升序排列 如果时间相同则按名字升序排列
Get-ChildItem |
  Sort-Object -Property @{ Expression = 'LastWriteTime'; Descending = $true }, @{ Expression = 'Name'; Ascending = $true } |
  Format-Table -Property LastWriteTime, Name

# Expression 是表达式 可以自定义数值 最终以它为准来排列
# 按写入时间减去创建时间的大小 降序排列
Get-ChildItem |
  Sort-Object -Property @{ Expression = { $_.LastWriteTime - $_.CreationTime }; Descending = $true } |
  Format-Table -Property LastWriteTime, CreationTime

# 对象选择属性的方式
Get-CimInstance -Class Win32_LogicalDisk |
  Select-Object -Property Name, @{
      label      = '容量' # 显示列的名称
      expression = { $_.FreeSpace }
  }

Get-CimInstance -Class Win32_LogicalDisk |
  Select-Object -Property Name, @{
      label      = '容量' # 显示列的名称
      expression = "FreeSpace"
  }

# 哈希表缩写
Sort-Object @{ e = 'LastWriteTime'; d = $true }, @{ e = 'Name'; a = $true }

# 使用变量保存哈希表
$order = @(
  @{ Expression = 'LastWriteTime'; Descending = $true }
  @{ Expression = 'Name'; Ascending = $true }
)
# 通过读入变量的形式加载哈希表 传参
Get-ChildItem |
  Sort-Object $order |
  Format-Table LastWriteTime, Name


[排序](https://docs.microsoft.com/zh-cn/powershell/scripting/samples/sorting-objects?view=powershell-7.1)
[参考1](https://docs.microsoft.com/zh-cn/learn/modules/connect-commands/4-format)


```

## 逻辑运算

| 比较运算符   | 含义                       | 示例（返回 True）             |
| ------------ | -------------------------- | ----------------------------- |
| -eq          | 等于                       | 1 -eq 1                       |
| -ne          | 不等于                     | 1 -ne 2                       |
| -lt          | 小于                       | 1 -lt 2                       |
| -le          | 小于或等于                 | 1 -le 2                       |
| -gt          | 大于                       | 2 -gt 1                       |
| -ge          | 大于或等于                 | 2 -ge 1                       |
| -like        | 相似（文本的通配符比较）   | "file.doc" -like "f\*.do?"    |
| -notlike     | 不相似（文本的通配符比较） | "file.doc" -notlike "p\*.doc" |
| -contains    | 包含                       | 1,2,3 -contains 1             |
| -notcontains | 不包含                     | 1,2,3 -notcontains 4          |

| 逻辑运算符 | 含义                                        | 示例（返回 True）        |
| ---------- | ------------------------------------------- | ------------------------ |
| -and       | Logical and；如果两侧都为 True，则返回 True | (1 -eq 1) -and (2 -eq 2) |
| -or        | Logical or；如果某一侧为 True，则返回 True  | (1 -eq 1) -or (1 -eq 2)  |
| -not       | Logical not；反转 True 和 False             | -not (1 -eq 2)           |
| !          | Logical not；反转 True 和 False             | !(1 -eq 2)               |

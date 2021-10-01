# F8 运行当前光标所在行的指令
Get-Command -Name '*langua*'

Get-Command -Name '*langua*' -Type "Cmdlet"

Get-Command | gm | awk -F "\t" '{print $2"-"$4}'


Get-WinAcceptLanguageFromLanguageListOptOut
Get-WinCultureFromLanguageListOptOut
Get-WinLanguageBarOption
Get-WinUILanguageOverride
Get-WinUserLanguageList


Get-Command	| gm -MemberType Method
Get-Command	| gm -MemberType Property
Get-Command	| gm -name v* -MemberType Property
Get-Command -Verb p*

Get-Process | Get-Member
Get-Process | Get-Member | Out-Host -Paging # Out-Host -Paging 用于分页显示输出
Get-Process | Get-Member -MemberType Properties # 成员类型 所有属性
属性类型
ScriptProperty      脚本属性
AliasProperty       别名属性
NoteProperty        注释属性
Property            普通属性


Get-WmiObject –Class Win32_Service | Select-Object name

ExitCode  : 1077
Name      : WinRM
ProcessId : 0
StartMode : Manual
State     : Stopped
Status    : OK

# 过滤运行中的驱动
Get-CimInstance -Class Win32_SystemDriver |  Where-Object { $_.State -eq 'Running' }

# 过滤当前运行中并属于自动启动的驱动
Get-CimInstance -Class Win32_SystemDriver | Where-Object { $_.State -eq "Running" } | Where-Object { $_.StartMode -eq "Auto" }
Get-CimInstance -Class Win32_SystemDriver | Where-Object { $_.State -eq "Running" } | Where-Object { $_.StartMode -eq "Auto" } | Format-Table *
# 使用 and 逻辑 一次性过滤多个条件
Get-CimInstance -Class Win32_SystemDriver |
Where-Object { ($_.State -eq 'Running') -and ($_.StartMode -eq 'Manual') } |
Format-Table -Property Name, DisplayName

Get-CimInstance -Class Win32_SystemDriver  | Where-Object { $_.StartMode -eq "Auto" } | Format-Table Name, DisplayName #显示特定属性
Get-CimInstance -Class Win32_SystemDriver  | Where-Object { $_.StartMode -eq "Auto" } | gm

Get-CimInstance -Class Win32_SystemDriver |
Where-Object { $_.State -eq "Running" } |
Where-Object { $_.StartMode -eq "Manual" } |
Format-Table -Property Name, DisplayName


# cpu占用大于2 根据cpu占用度倒叙排序 只显示前三个
Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3


Get-ChildItem |  Sort-Object -Property LastWriteTime, Name
# 排列 格式化输出感兴趣的属性
Get-ChildItem |  Sort-Object -Property LastWriteTime, Name |  Format-Table -Property LastWriteTime, Name

# 返回示例帮助
Get-Help Get-FileHash -Examples
help Get-FileHash -Examples


Get-Command -Noun *Search*

# 锁定任务栏
# 1 不锁定
# 0 锁定
HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Search\SearchboxTaskbarMode

path contains Taskbar   路径包含任务栏关键字
result is success       成功执行的

PrintSetting

TypeName:Microsoft.WindowsSearch.Commands.PrintSetting

Get-WindowsSearchSetting | gm

Set-WindowsSearchSetting -Setting

Get-Command -ParameterType Microsoft

Get-Command -ParameterName WindowsSearch



Get-CimInstance -Class Win32_LogicalDisk | Select-Object -Property Name, FreeSpace

Get-CimInstance -Class Win32_LogicalDisk | Select-Object -Property Name, @{
    label      = '容量' # 显示列的名称
    expression = { $_.FreeSpace }
}

# 格式化输出新对象
Get-CimInstance -Class Win32_LogicalDisk |
Select-Object -Property Name, @{
    label      = 'FreeSpace'
    expression = { ($_.FreeSpace / 1GB).ToString('F2') }
}



# 获取指定位置项目的内容
# 从文件中获得内容

"a\nb\nc" | Get-Content 

help Get-Content -Online
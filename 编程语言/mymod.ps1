function Get-Prop {
    # 寻找对象属性

    # 属性类型
    # ScriptProperty      脚本属性
    # AliasProperty       别名属性
    # NoteProperty        注释属性
    # Property            普通属性
    # MemberType 的允许值有
    # AliasProperty、CodeProperty、Property、NoteProperty、ScriptProperty、Properties、PropertySet、
    # Method、CodeMethod、ScriptMethod、Methods、
    # ParameterizedProperty、MemberSet 以及 All。

    Param(
        [string]$prop = "Get-Process",
        [int16]$mode = 1
    )

    $proptype = "Properties"

    switch ($mode) {
        1 {
            $proptype = "Property"
        }
        2 {
            $proptype = "ScriptProperty"
        }
        3 {
            $proptype = "AliasProperty"
        }
        4 {
            $proptype = "NoteProperty"
        }
    }

    & $prop | Get-Member -MemberType $proptype # 成员类型 所有属性
}

# Get-Prop -mode 2


# Get-Service

# 运行对象方法
$com = "w32time"
$abc = @{
    Name = "w32time"
}


# (Get-Service -Name $com).Stop()
# 经过选择的对象返回的类型不再是原来的
Get-Service | gm | grep TypeName
Get-Service | Select-Object name | gm | grep TypeName
# 经过过滤的对象还是原来的类型
Get-Service | Where-Object { $_.name -eq "gupdate" } | gm | grep TypeName

ls | gm | grep TypeName
ls | Select-Object name | gm | grep TypeName

# com对象调用
$WshShell = New-Object -ComObject WScript.Shell
$WshShell | gm
# 利用com对象创建快捷方式
$lnk = $WshShell.CreateShortcut("$Home\Desktop\PSHome.lnk")
$lnk.TargetPath = $PSHome
$lnk.Save()
$lnk
$lnk | gm

# 删除引用
$ie = $null
# 完全删除变量
Remove-Variable ie


$xl = New-Object -ComObject Excel.Application -Strict


# gm的两种用法
$a = 1, 2, "three"; Get-Member -InputObject $a # 输出对象数组
1, 2, "three" | Get-Member # 每个对象单独输出
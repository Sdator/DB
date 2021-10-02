class 工作表类 {
    $表格
    工作表类($表格) {
        $this.表格 = $表格
    }
    [void]获取工作表信息() {
        $this.表格 | Select-Object  @{l = '名字'; e = "Name" }, @{l = '是否隐藏'; e = "Visible"
        }
    }
}


class 单元格类 {
    $工作表
    单元格类($工作表) {
        $this.工作表 = $工作表
    }
    [void]写单元格($位置, $内容) {
        $this.工作表.cells.item($位置) = $内容
    }
    [string]读单元格($位置) {
        return $this.工作表.cells.item($位置)
    }
    [void]获取表格单元信息() {
        $this.工作表 | Select-Object Text, NumberFormat
    }
}


class 表格类 {
    [object]$表格
    [object]$工作表
    [object]$单元格
    [object]$表格对象
    $显示窗口


    表格类([string]$文件路径) {
        $路径是否存在 = Test-Path -Path $文件路径
        if ($路径是否存在) {
            $this.表格 = $this.获取表格($文件路径)
            # 选择工作表 也可以用方法 WorkSheets.item(1)
            $this.工作表 = $this.表格.WorkSheets(1)
            $this.单元格 = $this.工作表.Range("A1")
        }
    }


    [object]选取单元格([string]$选择范围) {
        $this.单元格 = $this.工作表.Range($选择范围)
        return $this.单元格
    }


    [object]获取表格($文件路径) {
        # 创建一个excel应用的COM对象
        $this.表格对象 = New-Object -ComObject Excel.Application
        # 显示窗口
        $this.表格对象.Visible = $true
        return $this.表格对象.Workbooks.Open($文件路径)
    }


    [object]获取表格对象信息() {
        $a = $this.表格对象 | Select-Object  @{l = '名字'; e = "Name" }, @{l = '是否隐藏'; e = "Visible" } | Format-Table
        return $a
    }


    [object]获取表格信息() {
        $a = $this.表格对象 | Select-Object  @{l = '路径'; e = "Name" }
        return $a
    }


    [object]遍历表格() {
        $parttern = "http[A-z0-9/.:-]*"
        $url = @()
        $i = 0
        foreach ($item in $this.单元格) {
            $i++
            # 获取单元格的文本
            $tmp = $item.Text
            if ($tmp -ne "") {
                # 正则匹配
                $tmp -match $parttern | Out-Null
                # 添加数组到数组中 前面的逗号别忘了
                $url += , ($item.Row , $matches[0])
            }
        }
        return $url
    }

    [object]遍历表格Obj() {
        $parttern = "http[A-z0-9/.:-]*"
        $url = @{}
        $i = 0
        foreach ($item in $this.单元格) {
            $i++
            # 获取单元格的文本
            $tmp = $item.Text
            if ($tmp -ne "") {
                # 正则匹配
                $tmp -match $parttern | Out-Null
                $url += @{$item.Row = $matches[0] }
            }
        }
        return $url
    }
}

# Workbook
# WorkSheets
# Sheets


$表格 = [表格类]::new("$Home\Desktop\新建 Microsoft Excel Worksheet.xlsx")
# $表格.获取工作表信息()
# $表格.获取表格信息()

$单元 = $表格.选取单元格("A1")

# "Int32", "Boolean",
$单元 = $表格.选取单元格("b1")
$单元.text
$单元.text

好爽可以自己格式化输出

类型过滤 $单元 "string"
类型过滤 $单元 @("Double", "Int32", "string")


$单元.Column.GetType()
$单元.row.GetType()

$单元 | gm -name Column, row
$b = $单元 | gm -MemberType Property
$a = $单元 | gm -MemberType Properties
$单元 | gm

$单元 | Select-Object * | gm
$单元 | Select-Object row

"Int32" -contains $单元.row.GetType().Name

我同学居然也喊我玩了，我可能会去玩玩

$b.Length

$b.row

特意写了一个函数用来枚举对象


$a.GetType()


# 列
Column
# 行
row


# | Where-Object {
#     $type = 获取属性类型($单元.($_.name))
#     "Int32", "Boolean", "Double" -contains $type
# } | $单元 | Select-Object


function 字符串寻找 {
    param (
        [string]$待检测字符串,
        [object[]]$数组
    )
    foreach ($item in $数组) {
        if ($待检测字符串 -like $item) {
            return $true
        }
    }
    return $false
}


function 类型过滤 {
    param (
        [object]$对象,
        [object[]]$类型 = $("Int32", "Boolean", "Double")
    )
    $感兴趣的属性 = @()
    # $过滤属性 = $对象 | gm -MemberType Properties
    $过滤属性 = $对象 | gm
    foreach ($item in $过滤属性) {
        $name = $item.name
        $返回值 = $item.Definition
        # 过滤属性 属性可以直接获取值 特殊处理      MemberType 是枚举类型
        $t = [Management.Automation.PSMemberTypes]
        # 属性类型
        # ScriptProperty      脚本属性
        # AliasProperty       别名属性
        # NoteProperty        注释属性
        # Property            普通属性
        # MemberType 的允许值有
        # AliasProperty、CodeProperty、Property、NoteProperty、ScriptProperty、Properties、PropertySet、
        # Method、CodeMethod、ScriptMethod、Methods、
        # ParameterizedProperty、MemberSet 以及 All。
        $tem = @($t::Properties, $t::Property)
        # if ($item.MemberType -eq [Management.Automation.PSMemberTypes]::Properties) {
        if ( $tem -contains $item.MemberType ) {
            $value = $对象.($name)
            $type = 获取属性类型($value)
            if ( $类型 -contains $type  ) {
                # 组装对象并加入数组中
                $感兴趣的属性 += @{ "属性" = $name; "值" = $value; "类型" = $type }
            }
        }
        # 处理 方法和其他类型
        elseif (字符串寻找 $返回值 "Range *", "int *") {
            $感兴趣的属性 += @{ "属性" = $name; "值" = $item.MemberType; "类型" = $返回值 }
        }
    }
    # 自定义输出格式
    $感兴趣的属性 |  Select-Object 属性, 值, 类型 | Sort-Object @{ e = '类型'; d = $true } | Sort-Object @{ e = '值'; a = $true }
}



类型过滤 $单元 "string"

$单元 | gm -MemberType Properties

$aa = $单元 | gm
foreach ($item in $aa) {
    if ( [Management.Automation.PSMemberTypes]::Properties, [Management.Automation.PSMemberTypes]::Property -contains $item.MemberType ) {
        Out-Host "55555"
    }
    else {
        "111"
    }
}

System.Enum
$item.MemberType[0].gettype() -eq [Management.Automation.PSMemberTypes]::Properties
$item.MemberType[0] | gm
$item.MemberType[0] -eq [Management.Automation.PSMemberTypes]::Property
$t = [Management.Automation.PSMemberTypes]
$t::Properties, $t::Property -contains $item.MemberType[0]


enum FunTypes{
    Properties = [Management.Automation.PSMemberTypes]::Properties
    Property = [Management.Automation.PSMemberTypes]::Property
}
[FunTypes] -contains $item.MemberType[0]



$item.MemberType[0] | Select-Object
$item.MemberType[0].gettype()
$item.MemberType[0]

[Management.Automation.PSMemberTypes]::Properties

$item.MemberType[0] -eq [Management.Automation.PSMemberTypes]::Properties

[Management.Automation.PSMemberTypes].GetEnumNames()
[Management.Automation.PSMemberTypes].GetEnumValues()

[Management.Automation.PSMemberTypes].Properties.gettype()

[Management.Automation.PSMemberTypes].GetEnumNames() | Select-Object


if ($item.MemberType -eq "Properties") {


    $感兴趣的属性对象 = @{"名字" = 555 ; "属性" = 666 }
    $感兴趣的属性对象.Add("名字", 777)
    $感兴趣的属性对象.名字 = , (4, 5, 6, 8)
    # 测试没问题
    $感兴趣的属性对象, $感兴趣的属性对象 | Select-Object *
    # 那我们就可以这样保存起来
    $a = $感兴趣的属性对象, $感兴趣的属性对象
    # 原来是数组
    $a.GetType()
    $a | Select-Object *




    获取属性类型($单元.UseStandardHeight)


    $name = $单元 | gm -MemberType Properties

    foreach ($item in $name) {
        "$($item.name) $($单元.($item.name))"
    }


    # "$($name[0].Name) $($单元.($name[0].Name))"


    function 获取属性类型($属性) {
        # echo $属性.GetType()
        if ($属性) {
            return ($属性).GetType().Name
        }
    }

    获取属性类型($单元.RowHeight)


    Int32
    Top
    Text
    ReadingOrder
    Row
    RowHeight




    $a = $单元 | gm -MemberType Properties
    # gm函数、数组对象 包含属性TypeName Name    MemberType Definition
    $a | Select-Object *
    $a.GetType()





    $单元 |  Where-Object {
        $_.GetType().Name -eq "Double"
    } | Select-Object *


    foreach ($item in $单元) {
        Out-Host $item
    }


    $单元 | gm
    $单元 | Select-Object Creator, CountLarge


    $单元 | gm -MemberType Properties | Select-Object Name
    $单元.GetType()

    $a = @{bb = "Value2" }
    $单元.($a.bb).GetType().Name


    $_.Name -eq "SoundNote"

    $单元 | gm -MemberType Properties | Select-Object Name | gm
    $单元 | gm -MemberType Properties | Select-Object Name | $_.Name



    $单元[$_]

    $单元 | Select-Object

    Where-Object { $_.Text -ne "" } | Select-Object Text




    # 结束所有表格进程
    Get-Process EXCEL | Stop-Process
    return


    $表格.获取工作表信息()

    $表格 = 获取表格 "$Home\Desktop\网购单机破解版合集~需要自己拿！.xlsx"


    # $匹配地址 = 遍历表格 $单元格
    $匹配地址 = 遍历表格Obj $单元格


    $匹配地址.Length
    $匹配地址.count


    function 网络访问 {
        param (
            [object]$地址
        )
        $响应信息 = Invoke-WebRequest –Uri $地址
        if ($响应信息.StatusCode -eq 200) {
            return $响应信息.Content
        }
        return $null
    }



    # $存活的链接 = @()
    # foreach ($item in $匹配地址[0..5]) {
    #     $源码 = 网络访问 $item[1]
    #     if ($源码 -like "*分享的文件已经被删除了*") {
    #         echo "草泥马"
    #         $存活的链接 += , ($item[0], 0)
    #     }
    #     else {
    #         $存活的链接 += , ($item[0], 1)
    #     }
    # }


    # 检测地址有效性
    $存活的链接 = @{}
    foreach ($key in $匹配地址.Keys) {
        $源码 = 网络访问 $匹配地址[$key]
        if ($源码 -like "*分享的文件已经被删除了*") {
            echo "草泥马"
            $存活的链接 += @{ $key = 0 }
        }
        else {
            $存活的链接 += @{ $key = 1 }
        }
    }

    # 表格上色
    foreach ($key in $存活的链接.Keys) {
        $item = $单元格.cells.item( $key, $单元格.Column - 2)
        # 背景色
        if ($存活的链接[$key] -eq 1) {
            # $单元格.cells.item($单元格.Column, $key).Font.Color = "RGB(0, 255, 0)"
            $item.Interior.ColorIndex = 44
        }
        else {
            $item.Interior.ColorIndex = 3
        }
    }




    .Font.Color = "RGB(0, 255, 0)"
    $单元格 | Select-Object  @{l = '列Column'; e = "Column" }, @{l = '行Row'; e = "Row" }, @{l = '内容'; e = "Text" }


    # $源码 = 网络访问 "https://api.cloudflare.com/client/v4/ips"
    # # 分割字符串
    # $地址分割 = $item.Split('/')
    # $ip集 += $地址分割
    # $has.Add($i++, $地址分割)



    写出表格
    # Get-Process| SELECT Name, Path | Export-Csv -Path C:\scripts\processes.csv
    $工作表.Range("c1:c18") | Select-Object Column, Row, Text
    $工作表.Range("c1:c18")  | Select-Object  @{l = '列Column'; e = "Column" }, @{l = '行Row'; e = "Row" }, @{l = '内容'; e = "Text" }

    $单元格[2] | Select-Object *
    $单元格 | gm -MemberType Properties






    # 默认新建的excel视图不显示，即没有打开
    $excel.Visible = $true
    # 创建工作表
    # 工作表 增删改查
    $w工作表 = $excel.Workbooks.Add()
    # 删除
    $w工作表.workSheets.item(2).delete()
    # 改名
    $w工作表.WorkSheets.item(1).Name = "Processes"
    # 获取当前活动的工作表
    $d当前活动表 = $w工作表.ActiveSheet;
    # 选择第一个电子表格 返回的电子表格对象存储
    $sheet = $w工作表.worksheets.Item(1)



    # 单元格操作
    $sheet.cells.item(1, 1) = "1锁定2211111112wo32132"
    $sheet.cells.item(1, 1)

    获取表格单元信息($sheet.cells.item(1, 1))


    # 创建枚举类型 别名
    $lineStyle = "microsoft.office.interop.excel.xlLineStyle" -as [type] # 绘制线条的类型
    $colorIndex = "microsoft.office.interop.excel.xlColorIndex" -as [type]
    $borderWeight = "microsoft.office.interop.excel.xlBorderWeight" -as [type]
    $chartType = "microsoft.office.interop.excel.xlChartType" -as [type]

    # 格式化单元格
    $sheet.cells.item(1, 1).font.bold = $true # 粗体
    $sheet.cells.item(1, 1).borders.LineStyle = $lineStyle::xlDashDot # 线条
    $sheet.cells.item(1, 1).borders.ColorIndex = $colorIndex::xlColorIndexAutomatic # 允许自动指定颜色
    $sheet.cells.item(1, 1).borders.weight = $borderWeight::xlMedium #边框宽度设为中等粗细

    # 单元格行列范围改为自动
    $range = $sheet.usedRange
    $range.EntireColumn.AutoFit() | out-null
    # $d当前活动表.cells.item(1,1) = "115551"

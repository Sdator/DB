
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
        $t表格对象 = New-Object -ComObject Excel.Application
        $t表格 = $t表格对象.Workbooks.Open($文件路径)
        $t表格对象.Visible = $true

        $this.表格 = $t表格
        $this.表格对象 = $t表格对象
        $this.单元格 = [单元格类]::new($t表格.WorkSheets.item(1))
        # $this.工作表 = [工作表类]::new($t表格.WorkSheets.item(1))
    }

    获取工作表信息() {
        $this.表格对象 | Select-Object  @{l = '名字'; e = "Name" }, @{l = '是否隐藏'; e = "Visible" } |  Format-Table
    }
}

$表格 = [表格类]::new("$Home\Desktop\网购单机破解版合集~需要自己拿！.xlsx")



function 遍历表格 {
    param (
        [object]$单元格
    )
    $parttern = "http[A-z0-9/.:-]*"
    $url = @()
    $i = 0
    foreach ($item in $单元格) {
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


function 遍历表格Obj {
    param (
        [object]$单元格
    )
    $parttern = "http[A-z0-9/.:-]*"
    $url = @{}
    $i = 0
    foreach ($item in $单元格) {
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



function 获取表格 {
    param (
        [PSDefaultValue(Help = '表格路径')]
        [string]$路径
    )
    # 创建一个excel应用的COM对象
    $excel = New-Object -ComObject Excel.Application
    # 显示窗口
    $excel.Visible = $true
    return $excel.Workbooks.Open($路径)
}

$表格 = 获取表格 "$Home\Desktop\网购单机破解版合集~需要自己拿！.xlsx"


function 获取工作表信息() {
    param (
        [PSDefaultValue(Help = '工作表对象')]
        [object]$表格
    )
    $表格 | Select-Object  @{l = '名字'; e = "Name" }, @{l = '是否隐藏'; e = "Visible"
    }
}

# 打开表格 返回 Workbook TypeName: System.__ComObject#{000208da-0000-0000-c000-000000000046}
# FileName:="Array.xls", ReadOnly:=True
#  WorkSheets  TypeName: System.__ComObject#{000208d8-0000-0000-c000-000000000046}
# 返回 Sheets
$工作表 = $f.WorkSheets.item(1)
$工作表 -eq $f.WorkSheets(1)


$工作表 = $表格.WorkSheets(1)
获取工作表信息 $工作表

$单元格 = $工作表.Range("c1:c18")

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


function 查询状态 {

    foreach ($item in $匹配地址) {

        # $源码 = 网络访问 "https://api.cloudflare.com/client/v4/ips"
        # # 分割字符串
        # $地址分割 = $item.Split('/')
        # $ip集 += $地址分割
        # $has.Add($i++, $地址分割)
    }
}





写出表格
# Get-Process| SELECT Name, Path | Export-Csv -Path C:\scripts\processes.csv
$工作表.Range("c1:c18") | Select-Object Column, Row, Text
$工作表.Range("c1:c18")  | Select-Object  @{l = '列Column'; e = "Column" }, @{l = '行Row'; e = "Row" }, @{l = '内容'; e = "Text" }

$单元格[2] | Select-Object *
$单元格 | gm -MemberType Properties


# $地址 = $f.WorkSheets(1).Range("c1:c544")
# "https://pan.baidu.com/s/1Urbv6UXxESCbl3P5jSMIBw 提取码fhtb" -match $parttern

Row




Where-Object { $_.Text -ne "" } | Select-Object Text





$sheet.cells.item(1, 1)

获取工作表信息 $工作表


获取表格单元信息 $f

Workbook
.Range("A1").Value


$excel | gm
$excel | Select-Object Windows
$excel | gm -Name w*
$file = $excel.Windows
gm -InputObject $excel.Windows



# ("$Home\Desktop\aaa1.xlsx").Activate


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

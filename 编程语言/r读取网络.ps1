# 读取文件 UTF8-NOBOM
function Read-File($path) {
    return (Get-Content -Raw -Encoding "UTF8NoBOM" -Path "$path" )
}

# 写文件 UTF8-NOBOM
function Write-File($path, $content) {
    Set-Content -Encoding "UTF8NoBOM" -Path "$path" -Value $content
}



# 读取json文件并转换为对象
function Read-JsonFile($path) {
    $content = Read-File $path
    return ConvertFrom-Json -InputObject $content
}


# 写入json对象为文件
function Write-JsonFile($path, $obj) {
    $content = ConvertTo-Json  -Depth 10 $obj
    Write-File  $path $content
}

# Microsoft.PowerShell.Commands.BasicHtmlWebResponseObject
# 访问地址
$ip列表 = Invoke-WebRequest –Uri "https://api.cloudflare.com/client/v4/ips"
$ip列表
$ip列表 | gm

# System.Management.Automation.PSCustomObject
# 转为json
$json = ConvertFrom-Json -InputObject $ip列表.Content

$json | gm
$json | Select-Object *

$ip集 = @()
$has = @{}
if ($ip列表.StatusCode -eq 200) {
    foreach ($item in $json.result.ipv4_cidrs) {
        # 分割字符串
        $地址分割 = $item.Split('/')
        $ip集 += $地址分割
        # $has.Add($i++, $地址分割)
    }
}
$ip集


1..2 | foreach {
    1..2 | foreach {
        echo $_
    }
}


ping $($has[0][0])


$i = 0
pip list | foreach {
    echo "$_ $i++"
}

$str = pip list

$str -like "op*"

我最近倒是有几个灵感
只是不太像用魔兽来实现

$str
$str | Where-Object { $_ -eq "attrs" }
$str | echo "$_"


叔最近把powershell学了 对于运维有很大帮助

$str | Select-Object *
$str[0..4]
$str[0..-2]
$str[1]
$str[2]
$str | gm

Get-Item

new-lines:
new-line-character
new-lines new-line-character



$ip集
$ip集 | gm

$a = $json.result.ipv4_cidrs[0].Split('/')
$has.Add(3, @($a))
$has.Add(1, $a)



echo $has
$has | gm
$has | Select-Object Keys, Item

"column1`tcolumn2`nsecond line, `"Hello`", ```Q`5`!"
# 输出
# column1 column2
# second line, "Hello", `Q5!

# 如果是集合对象 需要使用 $() 子表达式扩展来读取
$a = "red", "blue"
"`$a[0] is $a[0], `$a[0] is $($a[0])"
# 输出： $a[0] is red blue[0], $a[0] is red


$i = 5; $j = 10; $k = 15
"`$i, `$j, and `$k have the values $i $j $k"            # 直接变量
"`$i, `$j, and `$k have the values $( $i; $j; $k )"     # 子表达式表示多个
"`$i, `$j, and `$k have the values $(($i = 5); ($j = 10); ($k = 15))" # 设定并赋值
# 输出： $i, $j, and $k have the values 5 10 15

# 从 1 开始大于10结束 -le 小于等于
"First 10 squares: $(for ($i = 1; $i -le 10; ++$i) { "$i $($i*$i) " })"
# 输出： First 10 squares: 1 1  2 4  3 9  4 16  5 25  6 36  7 49  8 64  9 81  10 100

$a = 10
$s1 = "`$a = $($a; ++$a)"
"`$s1 = >$s1<"      # $s1 = >$a = 10<
$s2 = "`$a = $($a; ++$a)"
"`$s2 = >$s2<"      # $s2 = >$a = 11<
$s2 = $s1           # 拷贝副本 结果是第一次赋值的
"`$s2 = >$s2<"      # $s2 = >$a = 10<





$json.result.ipv4_cidrs | gm
$json.result.ipv4_cidrs[0].Split('/')[0]

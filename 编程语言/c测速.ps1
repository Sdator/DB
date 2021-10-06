$fping = "D:\Git\批处理工具\better-cloudflare-ip-win32\fping.exe"

# https://www.cloudflare.com/zh-cn/ips/
$地址 = curl "https://www.cloudflare.com/ips-v4"

$有效的地址 = @{}
# 源码会按行形成数组
# 遍历返回文本的每一行
$地址.ForEach{
    # 取得所有100毫秒之内响应的ip
    $有效的地址 += @{$_ = (& $fping -t 100 -a -g $_) }
}

# 写出txt文件
# $有效的地址
# foreach ($k in $有效的地址.Keys) {
#     Add-Content -Path .\有效地址.txt $有效的地址[$k]
# }

# 写出json文件
$有效的地址 | ConvertTo-json | Out-File ".\有效地址.json"


$ip | & $fping -p 100 -c 10

$ip = $json["104.24.0.0/14"][0..10]

$ip | & $fping -a -c 2 -s

$ip | & $fping -p 100 -c 10
$ip | & $fping -t 100 -c 10 -c 1

$ip | & $fping -t 100 -c 10
$ip | & $fping -p 100 -c 10



& $fping -c 30 --interval=0 -t 80 -a -g -s "104.24.0.0/30"
& $fping -c 10 --interval=0  -a -g "104.24.0.0/31" -s


$tmp = @()
$有效的地址.keys.ForEach{
    $tmp += @{$_ = $json.$_ }
}




$tmp | ForEach-Object {
    $_.keys
    $_.Values
    break
}

$tmp[2..3].Values


$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(11, 22, 33, 44) }
$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(1, 2, 3, 4, 5) }, @{"b" = @(11, 22, 33, 44) }

$tab.keys

$tab | Convertto-Json

$tab[0].Values

types $tab
types $tab[0].Values


$tmp."188.114.96.0/20"[0..6]

types $tmp

types $有效的地址["188.114.96.0/20"]



function 丢包率测试($地址) {
    $有效的地址 = @{}
    $地址.keys | ForEach {
        # 取得所有100毫秒之内响应的ip
        # $有效的地址[$_] = (& $fping -t 100 -a -g $_)
        $有效的地址.$_ = $地址.$_[0]
        break
    }
    return $有效的地址
}

$a = (丢包率测试 $json)



$有效的地址 = @{}
$json.keys | ForEach {
    # 取得所有100毫秒之内响应的ip
    # $有效的地址.$_ = (& $fping -p 100 -c 1 -a $json.$_)
    (& $fping -p 100 -c 1 -a $json.$_)  | foreach {
        # if ($_[1] -ne "100%") {
        #     "$_"
        # }
        $地址, $丢包率 = $_ -split ","
        $丢包率
        break
    }
    break
}


$有效的地址.$_ = $json."188.114.96.0/20" | & $fping -p 100 -a

$json."188.114.96.0/20" | & $fping -p 200 -c 1 -a -s
$json."188.114.96.0/20" | & $fping -p 100 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 100 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 50 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 100 -c 1 -a # 获取存活 但-p不起作用 需要配合-c



$json."188.114.96.0/20" | & $fping -c 1 -a -s



echo $有效的地址







$json["103.22.200.0/22"][0]


# -p 默认值为 1000，最小值为 10。
# 在循环或计数模式（-l、-c或-C）中，此参数设置fping 在到达单个目标的连续数据包之间等待的时间（以毫秒为单位）。
& $fping -p 170 -c 10 1.1.1.1
& $fping -t 170 -c 10 1.1.1.1




# 读入json
$jsonA = Get-Content -Raw -Encoding "UTF8NoBOM" -Path ".\有效地址.json" | ConvertFrom-Json
$json = Get-Content -Path ".\有效地址.json" | ConvertFrom-Json -AsHashtable

Get-Command -name remo*
Remove-Variable test


# 在线帮助
function helpol([string]$com) {
    help $com -Online
}
# 读取对象类型
function types($obj) {
    $obj.gettype()
}

# 排列
$过滤器 = @(
    @{ l = "地址"; e = { $_ } },
    @{ l = "地址数量"; e = { (0x7fffffff -shr ($_ -split "/")[1]) * 2 } },
    @{ l = "有效数量"; e = { $有效的地址[$_].Count } },
    @{ l = "有效地址占比"; e = {
            $有效数量 = $有效的地址[$_].Count
            $地址数量 = (0x7fffffff -shr ($_ -split "/")[1]) * 2
            $百分比 = [math]::round($有效数量 / $地址数量 * 100, 2)
            # 直接返回 如果加引号会导致类型变为文本而无法排序
            $百分比
        }
        Sort-Object @{e = "有效地址占比" ; d = $true } |
    }
)

# 查看用
$json.keys |
Select-Object $过滤器  |
Select-Object 地址, 地址数量, 有效数量, @{ l = "有效地址占比"; e = { "$($_.有效地址占比)%" } }


# echo & ($_ -split " / ")[1]
# Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
# --     ----            -------------   -----         -----------     --------             -------
# 1      Job1            BackgroundJob   Running       True            localhost            Microsoft.PowerShell.Man…



return




# 哈希对象
$临时地址 = @{}
$临时地址 += @{"a" = 132 }
$临时地址["b"] = 465
$临时地址.c = 789
$临时地址."d" = 111
# 哈希对象可通过这几种方式来读取
$临时地址
$临时地址.b
$临时地址."b"
$临时地址["b"]
types $临时地址
$临时地址.keys
$临时地址 | ConvertTo-Json


# 对象数组
$a临时地址 = @()
$a临时地址 += 465
$a临时地址 += "4564"
$a临时地址 += @{"a" = 132 }
$a临时地址 += @{"b" = @(1, 2, 3, 4, 5) }
$a临时地址 += @{"188.114.100.7/20" = 456 }
# 对象数组可通过这几种方式来读取
$a临时地址."a"
$a临时地址.a
$a临时地址.b
$a临时地址[1]
$a临时地址[0..1]
types $a临时地址
$a临时地址."b"
$a临时地址
$a临时地址 | ConvertTo-Json




$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(11, 22, 33, 44) }
$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(1, 2, 3, 4, 5) }, @{"b" = @(11, 22, 33, 44) }
$i = 0
# 遍历值
$tab.Values | ForEach {
    $i++
    types $_
}
# 遍历kes
$tab.Values | ForEach {
    $i++
    $_
}


# 处理没有被正确执行的地址
# "103.31.4.0/22", "197.234.240.0/22", "131.0.72.0/22" | foreach {
#     "$_ 进行中"
#     $有效的地址[$_] = (& $fping -t 100 -a -g $_)
#     "$_ 完成"
# }

# & $fping -t 1000 -a -g "104.24.0.0/29"


$val | ConvertTo-json -Depth -5
ConvertFrom-Json
Sort-Object 有效数量, 实际有效地址占比, 地址数量 -Descending


$有效的地址
, @{ l = "数量"; e = { $_.Count } }
# Get-Variable | Where-Object { $_.name -like "*ed*" }

# 后期测速比较麻烦
# curl --resolve speed.cloudflare.com:443:%a% https://speed.cloudflare.com/__down?bytes=1000000000 -o nul --connect-timeout 5
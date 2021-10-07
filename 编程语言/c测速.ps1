# 基本配置
$fping = "D:\Git\批处理工具\better-cloudflare-ip-win32\fping.exe"


# 在线帮助
function helpol([string]$com) {
    help $com -Online
}


# 读取对象类型
function types($obj) {
    $obj.gettype()
    # Sort-Object @{e = "有效地址占比" ; d = $true } |
    # echo & ($_ -split " / ")[1]  得到奇怪的输出待研究
    # Id     Name            PSJobTypeName   State         HasMoreData     Location             Command
    # --     ----            -------------   -----         -----------     --------             -------
    # 1      Job1            BackgroundJob   Running       True            localhost            Microsoft.PowerShell.Man…

}


function 地址统计($有效的地址) {
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
        }
    )
    # 查看用
    $有效的地址.keys |
    Select-Object $过滤器  | # 按自定义格式重新生成表
    # Sort-Object @{e = "有效地址占比" ; d = $true }|
    Sort-Object 有效地址占比 -Descending | # 按有效率排列
    Select-Object 地址, 地址数量, 有效数量, @{ l = "有效地址占比"; e = { "$($_.有效地址占比)%" } } # 使用百分比显示
}


function 提取地址 {
    # https://www.cloudflare.com/zh-cn/ips/
    # curl 获取的源码会按行形成数组
    $地址 = Invoke-WebRequest "https://www.cloudflare.com/ips-v4"

    if ($地址.StatusCode -ne 200) {
        throw "访问地址失败"
    }
    $有效的地址 = @{}
    # 获取源码正文 分割后 遍历IP段
    (-split $地址.Content)[0] | % {
        # 取得所有100毫秒之内响应的ip
        $有效的地址.$_ = (& $fping -p 300 -c 1 -a -g $_)

    } |  Select-Object *

    ConvertTo-json | Out-File "有效地址1.json"


    # 写出txt文件
    # $有效的地址
    # foreach ($k in $有效的地址.Keys) {
    #     Add-Content -Path .\有效地址.txt $有效的地址[$k]
    # }

    # 转为json格式后写出文件
    $有效的地址 | ConvertTo-json | Out-File "有效地址1.json"
}


提取地址


& $fping -p 200 -c 1 -a -g "173.245.48.0/27"



$ip | & $fping -t 100 -c 10 -c 1

& $fping -c 30 --interval=0 -t 80 -a -g -s "104.24.0.0/30"
& $fping -c 10 --interval=0  -a -g "104.24.0.0/31" -s

# 哈希转数组
$tmp = @()
$有效的地址.keys.ForEach{
    $tmp += @{$_ = $json.$_ }
}

# 数组中读取对象
$tmp | ForEach-Object {
    $_.keys
    $_.Values
    break
}
$tmp[2..3].Values


$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(11, 22, 33, 44) }
$tab = @{"a" = @(1, 2, 3, 4, 5) ; "b" = @(1, 2, 3, 4, 5) }, @{"b" = @(11, 22, 33, 44) }
$tab | Convertto-Json
$tmp."188.114.96.0/20"[0..6]
types $有效的地址["188.114.96.0/20"]




function 丢包率测试($地址) {
    $有效的地址 = @{}
    $地址.GetEnumerator().foreach{
        $key, $地址集 = $_.name, $_.Value
        # 当内容不等于空的时候
        if ($null -ne $地址集) {
            "正在处理 $key 地址段，预计数量 $($地址集.count)" | Out-Host

            # 先测试所有地址 然后过滤掉 100%丢包率的地址
            $有效的地址.$key = $地址集 | & $fping -p 100 -c 2 -a  | Where-Object { "100%" -ne ($_ -split ",")[1] }
            break
        }
    }
    return $有效的地址
}

# 获取文件行数
function Get-LineCount ($FilePath) {
    $nlines = 0;
    # 每次读取1000条内容
    Get-Content $FilePath -ReadCount 1000 | % { $nlines += $_.Length };
    # [string]::Format("{0} has {1} lines", $FilePath, $nlines)
    return $nlines
}


function 丢包率测试($文件路径) {
    $有效的地址 = @{}
    $name = ($文件路径 -split "_")
    $地址数量 = Get-LineCount $文件路径
    $IP段 = [string]::Format("{0}/{1}", $name[2], $name[3].Split(".")[0])
    "正在处理 $IP段 地址段，预计数量 $地址数量" | Out-Host
    # 如果文件过大 一次处理3000条
    $arr = @()
    Get-Content $文件路径 -ReadCount 3000 | % {
        $arr += $_ | & $fping -p 100 -c 2 -a  | ? { "100%" -ne ($_ -split ",")[1] }
    }
    $有效的地址.$IP段 = $arr
    return $有效的地址
}



# $_ | & $fping -p 100 -c 2 -a  | Where-Object { "100%" -eq ($_ -split ",")[1] }

Get-Content "IP_5_188.114.96.0_20.txt" -ReadCount 2 | % {
    "asd"
}





$有效的地址 = @{}
(Get-ChildItem "IP_*.txt") | foreach {
    $返回地址 = 丢包率测试 $_
    if ($返回地址.Values -ne $null) {
        对象差集 $返回地址 $有效的地址
    }
}

$有效的地址 | Convertto-Json | Out-File "速度最快的地址.json"


$a = @{"a" = 1; "b" = 2 }
$b = @{"a" = 111; "c" = 444 }

# 差集 要合并的对象 合并后的对象
function 对象差集($a, $b) {
    $a.Keys | ? { !$b.ContainsKey($_) } | ? { $b.$_ = $a.$_ }
}




function 下载测试($ip, $输出文件, $超时 = 2, $下载时间 = 5) {
    & curl --resolve speed.cloudflare.com:443:$ip https://speed.cloudflare.com/__down?bytes=1000000000 -o $输出文件 -s --connect-timeout $超时 --max-time $下载时间
}


下载测试 "173.245.48.2" "tmp" 1

下载测试 $ip "tmp3" 1 3
下载测试 $ip "tmp51" 1 5
下载测试 $ip "tmp53" 0.2 5

$有效的地址 = 丢包率测试 $json

# 写出文件
$json.GetEnumerator().ForEach{
    $地址数量 = $_.Value.count
    if ($地址数量 -gt 0) {
        $name = "IP_$($地址数量)_$($_.name -replace '/','_' ).txt"
        $_.Value | Out-File -FilePath $name
    }
}


& $fping -p 100 -c 2 -a $json."103.22.200.0/22" | Where-Object { "100%" -ne ($_ -split ",")[1] }


$有效的地址."103.22.200.0/22"
$有效的地址.ContainsKey("103.22.200.0/22")
$有效的地址.GetType()

@(1, 2, 3).GetType()
@{"a" = 1; "b" = "2" }.GetType()
@{"a" = 1; "b" = "2" }.ContainsKey("a")


$有效的地址 = 丢包率测试 $json



$处理结果 = (& $fping -p 100 -c 2 -a -g "104.24.0.6/31")

$a = $处理结果 | Where-Object { "100%" -ne ($_ -split ",")[1] }

$a
$处理结果

# 遍历对象
$a = @{"a" = 1; "b" = 2 }
$a | % GetEnumerator | % {
    $_.key
    $_.value
}


# 遍历 Values 方便取值 但无法得知keys
$json.Values | foreach {
    # 当内容不等于空的时候
    if ($_ -ne $null) {
        $_[0..3]
        break
    }
}
1

# 遍历 Values 方便取值 但无法得知keys
$json.GetEnumerator() | foreach {
    $keys, $value = $_.name, $_.Value
    # # 当内容不等于空的时候
    if ($value -ne $null) {
        $value[0..3]
    }
}



$json.GetEnumerator() | % { $_.name; break }




$json.keys | ForEach-Object {
    # 取得所有100毫秒之内响应的ip
    # $地址 = (& $fping -p 100 -c 3 -a $json.$_)
    # $地址 = (& $fping -p 100 -c 3 -a $json.$_[0..3])
    $json.$_.gettype()
    break
}


# $有效的地址.$_ =
# (& $fping -p 100 -c 3 -a $json.$_)  | foreach {
#     # if ($_[1] -ne "100%") {
#     #     "$_"
#     # }
#     $地址, $丢包率, $null = $_ -split ",", 3
#     $丢包率
#     break
# }
# }


$json."188.114.96.0/20"[0..3]


$有效的地址.$_ = $json."188.114.96.0/20" | & $fping -p 100 -a

$json."188.114.96.0/20" | & $fping -p 200 -c 1 -a -s
$json."188.114.96.0/20" | & $fping -p 100 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 100 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 50 -a -s  # 获取存活 但-p不起作用 需要配合-c
$json."188.114.96.0/20" | & $fping -t 100 -c 1 -a # 获取存活 但-p不起作用 需要配合-c

$json."188.114.96.0/20" | & $fping -t 100 -c 1 -a # 获取存活 但-p不起作用 需要配合-c





$json."188.114.96.0/20" | & $fping -c 1 -a -s

# 103.22.203.5   ,  0%,2,2,65.4ms,64.5ms,66.3ms
# 103.22.203.250 ,  0%,2,2,69.2ms,63.0ms,75.5ms

$json["103.22.200.0/22"][0..5] | & $fping -c 2 --interval=0 -a -s
$json["103.22.200.0/22"][0..5] | & $fping -p 100 -c 1 -a -s
$json["103.22.200.0/22"][0..5] | & $fping -p 100 -c 3 -a | foreach {
    echo (-clike $_)
}
$ip = ($json["103.22.200.0/22"][0] | & $fping -p 100 -c 3 -a) -Split ","

($json["103.22.200.0/22"][0] | & $fping -p 100 -c 3 -a)






help Split -Online

# $json["103.22.200.0/22"][0..5] | & $fping -t 200 -c 5 -a -s



# -p 默认值为 1000，最小值为 10。
# 在循环或计数模式（-l、-c或-C）中，此参数设置fping 在到达单个目标的连续数据包之间等待的时间（以毫秒为单位）。
& $fping -p 170 -c 10 1.1.1.1
& $fping -t 170 -c 10 1.1.1.1




# 读入json
# $jsonA = Get-Content -Raw -Encoding "UTF8NoBOM" -Path ".\有效地址.json" | ConvertFrom-Json
$json = Get-Content -Path ".\有效地址.json" | ConvertFrom-Json -AsHashtable



Get-Command -name remo*
Remove-Variable test



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



# 差集和交集
$a = (1, 2, 3, 4)
$b = (1, 3, 4, 5)
$a + $b | select -uniq    #union
$a | ? { $b -contains $_ }   #intersection

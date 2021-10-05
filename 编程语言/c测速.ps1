$fping = "D:\Git\批处理工具\better-cloudflare-ip-win32\fping.exe"

# https://www.cloudflare.com/zh-cn/ips/
$地址 = curl "https://www.cloudflare.com/ips-v4"

$有效的地址 = @{}
$地址.ForEach{
    $有效的地址 += @{$_ = (& $fping -t 100 -a -g $_) }
}

# 写出json文件
$有效的地址 | ConvertTo-json | Out-File ".\有效地址.json"

# 写出txt文件
# $有效的地址
# foreach ($k in $有效的地址.Keys) {
#     Add-Content -Path .\有效地址.txt $有效的地址[$k]
# }


$过滤器 = @(
    @{ l = "地址"; e = { $_ } },
    @{ l = "地址数量"; e = { (0x7fffffff -shr ($_ -split "/")[1]) * 2 } },
    @{ l = "有效数量"; e = { $有效的地址[$_].Count } },
    @{ l = "实际有效地址占比"; e = {
            $有效数量 = $有效的地址[$_].Count
            $地址数量 = (0x7fffffff -shr ($_ -split " / ")[1]) * 2
            "$($有效数量 / $地址数量)"
        }
    }
)

# 查看用
$有效的地址.keys |
Select-Object $过滤器  |
Sort-Object 有效数量 -Descending


return


# 处理没有被正确执行的地址
# "103.31.4.0/22", "197.234.240.0/22", "131.0.72.0/22" | foreach {
#     "$_ 进行中"
#     $有效的地址[$_] = (& $fping -t 100 -a -g $_)
#     "$_ 完成"
# }

# & $fping -t 1000 -a -g "104.24.0.0/29"


$val | ConvertTo-json -Depth -5
ConvertFrom-Json


Sort-Object 有效数量, 地址数量 -Descending


$有效的地址
, @{ l = "数量"; e = { $_.Count } }
# Get-Variable | Where-Object { $_.name -like "*ed*" }

# 后期测速比较麻烦
# curl --resolve speed.cloudflare.com:443:%a% https://speed.cloudflare.com/__down?bytes=1000000000 -o nul --connect-timeout 5
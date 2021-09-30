# adb shell "ls -al /sdcard/Android/data/com.tencent.mobileqq/Tencent/MobileQQ/chatpic/chatimg"

# busybox
# adb shell which toolbox

# for file in *; do cp "${file}" "/sdcard/DCIM/${file}.jpg"; done

# ll /sdcard/ | sort | tail -n 1

# 提取闪照
getSZ() {
    # ll /sdcard/Android/data/com.tencent.mobileqq/Tencent/MobileQQ/chatpic/chatimg | sort | tail -n 1 | for file in *; do cp "${file}" "/sdcard/DCIM/${file}.jpg"; command 2> /dev/null
    # 获取最新的缓存列表
    newCache=$(ls /sdcard/Android/data/com.tencent.mobileqq/Tencent/MobileQQ/chatpic/chatimg | sort | tail -n 1)
    for file in $newCache; do
        cp "${file}" "/sdcard/DCIM/${file}.jpg"
    done
}

# /system/bin/toolbox

# /system/bin/ls

# cp * /sdcard/DCIM/

# echo * | xargs echo "{}.jpg"

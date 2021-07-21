# 获取系统所有服务
serverlist="$(sc queryex)"

# 接口 获取服务或显示名字
echoName() {
    name="$(echo "$serverlist" | grep "$1" | awk '{print $2}')"
    echo "$name"
}

# 获取所有服务名称
GetAllServiceName() {
    echoName SERVICE_NAME
}

# 获取所有显示名称
GetAllDisplayName() {
    echoName DISPLAY_NAME
}

# 获取服务的执行命令
# 参数1 服务名称
GetServiceExec() {
    exec=$(sc qc "$1" | grep BINARY_PATH_NAME | awk '{print $3}')
    echo "$exec"
}

# 获取所有服务的执行命令
GetAllServiceExec() {
    GetAllServiceName
    for item in $name; do
        echo "${item}"
    done
}

# 获取服务名称
# 参数1 显示名称
GetServiceName() {
    serviceName="$(sc GetKeyName "$1" | tail -1 | awk '{print $3}')"
}
# GetServiceName "Security Center"
# echo "$serviceName"

GetServiceExec WSearch


# SERVICE_NAME: WpnUserService_34c4a
# DISPLAY_NAME: WpnUserService_34c4a
#         TYPE               : f0   ERROR
#         STATE              : 4  RUNNING
#                                 (STOPPABLE, NOT_PAUSABLE, ACCEPTS_PRESHUTDOWN)
#         WIN32_EXIT_CODE    : 0  (0x0)
#         SERVICE_EXIT_CODE  : 0  (0x0)
#         CHECKPOINT         : 0x0
#         WAIT_HINT          : 0x0
#         PID                : 3436
#         FLAGS              :

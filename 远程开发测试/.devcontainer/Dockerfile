#-------------------------------------------------------------------------------------------------------------
# Copyright (c) Microsoft Corporation. All rights reserved.
# Licensed under the MIT License. See https://go.microsoft.com/fwlink/?linkid=2090316 for license information.
#-------------------------------------------------------------------------------------------------------------

FROM scratch

CMD [ "ls" ]


# py基础运行环境
# FROM iron/base
# RUN apk add --no-cache python3

# # 开发者专用
# FROM iron/python:3
# 安装常用开发程序
# curl 网络访问
# git 版本管理
# linux-headers linux核心头文件
# python3 python3-dev PY主体
# RUN apk add --no-cache build-base curl git linux-headers python3 python3-dev
# # 安装pip
# RUN curl -sS https://bootstrap.pypa.io/get-pip.py | python3


# 基础命令
# 更新
# RUN apk update && apk upgrade \
# 请理垃圾
#   && apk add ca-certificates \
#   && rm -rf /var/cache/apk/*
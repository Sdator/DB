## vscode 下 kt 开发环境搭建
1. 搭建 Java JDK 环境 要求 jdk 8 11 14
   + scoop install -g openjdk11（scoop包管理下载）
2. 下载 Kotlin 命令行编译器
   + scoop install -g kotlin （scoop包管理下载）
   + https://github.com/JetBrains/kotlin/releases/tag/v1.3.72 （手动下载、需要手动添加环境变量）
   + cnpm install kotlin-compiler（适用于 nodejs、需要手动添加环境变量）
3. vscode 中安装插件
   + Kotlin Language
   + Code Runner

## npm 安装法
```bash
# 方法一 国内用户先装 cnpm
npm install -g cnpm --registry=https://registry.npm.taobao.org

# 方法二 添加别名启动 使用淘宝镜像
alias cnpm="npm --registry=https://registry.npm.taobao.org \
--cache=$HOME/.npm/.cache/cnpm \
--disturl=https://npm.taobao.org/dist \
--userconfig=$HOME/.cnpmrc"

# 安装kotlin
# 安装后到node_modules目录下找到kotlin目录下的bin目录添加到环境变量
cnpm install kotlin-compiler

```

## 参考
+ https://www.jianshu.com/p/2869c5bb2e52
+ https://developer.aliyun.com/mirror/NPM?from=tnpm
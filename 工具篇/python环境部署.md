# python 环境部署

## 安装

### 方法 1 scoop 包管理

1.如果你电脑没有安装过 scoop 可先安装，如果安装过了可以跳过下面的命令

```powershell
Invoke-Expression (New-Object System.Net.WebClient).DownloadString('https://get.scoop.sh')
```

2.安装 python

```bash
# 全局安装并添加到环境变量中
scoop install -g python
```

### 方法 2 官网安装包

选择你对应的平台和需要的版本，无脑点击下一步安装即可。
下载地址：https://www.python.org/downloads/

## 设置镜像站

设置清华镜像站，当然除了清华提供的还有阿里、豆瓣、xx 大学等等，拿到地址后替换下面的地址即可。

```bash
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple
```

## 虚拟环境

- 虚拟环境主要解决版本冲突的问题
- 为每一个项目都独立使用一个环境可隔绝依赖包冲突的问题
- 使用场景如：
  - 当你需要同时使用 py2 和 py3
  - 我已经安装了一个最新的包，但项目中需要的是一个低版本的包
  - 同理我项目中包很久没更新了，现在想升级一下依赖但又怕升级后项目会出现未知错误，因此我需要一个新的环境来升级依赖并测试和移植工作，好让我的项目依赖保持最新。
  - 方便导出正确的依赖文件并和项目一同发布，但当你在全局环境下会把无关的依赖包也一同导出，因此你的项目看起来很肿瘤

python 3.3 版本提供了一个虚拟环境的命令 venv,下面主要简单说说 venv 的常用指令。
当然也有很多其他的虚拟环境选择，比如 conda、virtualenv

> 想要在特定环境下安装依赖包 需要你先在终端中切换到对应的环境再执行 pip 安装

### 创建环境

python3 -m venv <路径名字>

```bash
# 在当前目录下创建一个环境名字叫 my-env
python3 -m venv my-env
# 在D盘下的demo目录中创建一个环境名字叫 my-env
python3 -m venv "d:\demo\my-env"
```

### 切换环境

- bash 终端下:`. my-env/Scripts/activate`
- powershell 终端下:`.\my-env\Scripts\Activate.ps1`
- cmd 终端下:`my-env\Scripts\activate.bat`

### 删除环境

可手动或执行 rm 或 del 命令来直接删除虚拟环境的目录，如 rm -rf my-env

## 参考

venv 的详细帮助可通过输入命令查看: python -m venv -h
清华镜像站：https://mirrors.tuna.tsinghua.edu.cn/help/pypi/

```

```

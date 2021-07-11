# 插件推荐

以下命令快捷键部分，本人只会把自己常用的列出，详细内容可自行点击链接查看

- [插件推荐](#插件推荐)
  - [shell 相关](#shell-相关)
  - [AHK 相关](#ahk-相关)
  - [Markdown 相关](#markdown-相关)
    - [markdown all in one](#markdown-all-in-one)
    - [markdown preview enhanced](#markdown-preview-enhanced)
    - [Markdown Shortcuts](#markdown-shortcuts)
  - [养眼类](#养眼类)
  - [辅助类](#辅助类)
  - [终端类](#终端类)
    - [formulahendry.code-runner](#formulahendrycode-runner)
    - [formulahendry.terminal ❌](#formulahendryterminal-)
      - [问题](#问题)
      - [功能](#功能)
    - [tyriar.terminal-tabs ❌](#tyriarterminal-tabs-)
      - [包含功能](#包含功能)
    - [tyriar.shell-launcher ❌](#tyriarshell-launcher-)
      - [配置例子](#配置例子)
- [_未完待续_](#未完待续)

## shell 相关

| 插件名称     | 插件 ID                   | 用途     |
| ------------ | ------------------------- | -------- |
| shellman     | remisa.shellman           | 代码片段 |
| ShellCheck   | timonwong.shellcheck      | 语法检查 |
| shell-format | foxundermoon.shell-format | 格式化   |

## AHK 相关

| 插件名称                | 插件 ID                               | 用途  |
| ----------------------- | ------------------------------------- | ----- |
| vscode-autohotkey-debug | zero-plusplus.vscode-autohotkey-debug | debug |

## Markdown 相关

[markdown-all-in-one]: https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one
[markdown-shortcuts]: https://marketplace.visualstudio.com/items?itemName=mdickin.markdown-shortcuts
[markdownlint]: https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint
[markdown-preview-enhanced]: https://marketplace.visualstudio.com/items?itemName=shd101wyy.markdown-preview-enhanced
[markdown-formatter]: https://marketplace.visualstudio.com/items?itemName=mervin.markdown-formatter
[office-viewer]: https://marketplace.visualstudio.com/items?itemName=cweijan.vscode-office

| 插件推荐                    | ID                                  | 简介                                                                        |
| --------------------------- | ----------------------------------- | --------------------------------------------------------------------------- |
| [Markdown-All-in-One]       | yzhang.markdown-all-in-one          | 提供基础功能必装、如智能提示、自动补全、格式化、动态目录                    |
| [Markdown-Shortcuts]        | mdickin.markdown-shortcuts          | 提供各类快捷键功能达到快速编辑                                              |
| [markdown-preview-enhanced] | shd101wyy.markdown-preview-enhanced | 预览、滚动跟随、扩展 MD 功能、如幻灯片、电子书、流程图、导出图片            |
| [markdownlint]              | DavidAnson.vscode-markdownlint      | 语法检查、统一、修正用                                                      |
| [markdown-formatter]        | mervin.markdown-formatter           | 自动格式化、模板功能                                                        |
| [office-viewer]             | cweijan.vscode-office               | 提供基于 vditor 所见即所得的编辑模式、md 导出 pdf，可预览大部分办公类型文件 |

### markdown all in one

| 快捷键   | 功能 |
| -------- | ---- |
| Ctrl + b | 粗体 |
| Ctrl + i | 斜体 |

| 命令                     | -            |
| ------------------------ | ------------ |
| Create Table of Contents | 创建大纲目录 |

| 配置             | 功能         | 参数 |
| ---------------- | ------------ | ---- |
| toc.updateOnSave | 自动更新大纲 | -    |

### markdown preview enhanced

| 快捷键     | -                       |
| ---------- | ----------------------- |
| Ctrl + k v | 打开预览 仅 VSCode 可用 |

### Markdown Shortcuts

| 快捷键     | 功能         |
| ---------- | ------------ |
| Ctrl + b   | 粗体         |
| Ctrl + i   | 斜体         |
| Alt + c    | 选中         |
| Ctrl + m m | 弹出命令菜单 |

## 养眼类

| 插件 ID                            | 简介                                               | 备注     |
| ---------------------------------- | -------------------------------------------------- | -------- |
| coenraads.bracket-pair-colorizer-2 | 级块上色、快速识别代码块关系                       |
| 2gua.rainbow-brackets              | 同上                                               |
| oderwat.indent-rainbow             | 段落上色、快速识别文本段落缩进、对齐（治疗强迫症） |
| vscode-icons-team.vscode-icons     | 美化文件夹图标、快速识别类别                       |
| foxundermoon.shell-format          | 脚本、配置类文件格式化（`sh 、bash、 Dockerfile`） | 格式化用 |

## 辅助类

| 插件 ID         | 简介                                     |
| --------------- | ---------------------------------------- |
| actboy168.tasks | 把 tasks 放到底部状态栏 实现快速点击运行 |

## 终端类

> 作者 2021.7.x 更新 vscode 后終端功能已经完全改版所以大部分终端插件都可以淘汰了

| 插件 ID                   | 简介                           |     |
| ------------------------- | ------------------------------ | --- |
| formulahendry.code-runner | 快速运行各类语言代码片段       |     |
| tyriar.terminal-tabs      | 终端快速切换、`UI`集成         | ❌  |
| formulahendry.terminal    | 用于把 cmd 命令输出到 out 窗口 | ❌  |
| tyriar.shell-launcher     |                                | ❌  |

### formulahendry.code-runner

- 快速运行各类语言代码片段 （`js、py、java、c`...）
- 活动页面右击`run code`执行

### formulahendry.terminal ❌

> **首先 vscode、code run 已经自带了大部分相同功能但是和插件还是有点稍微不同，至于不同的地方使用频率非常少所以也不再推荐了**

- 用于把命令输出到 out 窗口
- 快速从终端中打开活动文件所在路径

#### 问题

- Q：由于快捷键冲突导致 `F1` 命令行无法复制粘贴
- A：删除或修改键绑定

#### 功能

| 基本功能                                   | 快捷键       | 命令                                            |
| ------------------------------------------ | ------------ | ----------------------------------------------- |
| 在当前文件打开控制台并 `cd` 到当前文件目录 | `Ctrl+Alt+O` | `Open in Integrated Terminal` 、`terminal.open` |

**在终端中执行活动文件**
**在终端运行当前选中代码**

| 功能               | 命令                                        | 备注                                     |
| ------------------ | ------------------------------------------- | ---------------------------------------- |
| 在输出页中回显     | `terminal.run`                              |
| 在终端输出         | `workbench.action.terminal.runActiveFile`   | 编辑器自带                               |
| 在终端输出         | `workbench.action.terminal.runSelectedText` | 编辑器自带、无需选中代码、采用运行光标行 |
| 停止所有运行的命令 | `terminal.stop`                             |

### tyriar.terminal-tabs ❌

- 终端快速切换、`UI`集成

#### 包含功能

- 在状态栏创建终端快捷图标
  - `terminalTabs.createTerminal` 创建图标
  - `terminalTabs.createNamedTerminal` 创建标签的图标
- 切换终端 1-10
  - `terminalTabs.showTerminal1`
  - `terminalTabs.showTerminal2`
  - `terminalTabs.showTerminal3`

### tyriar.shell-launcher ❌

> **新版 vscode 自带的已经足够好了 因此不在推荐使用**

- 多终端集成

- 创建、切换不同终端如：`bash、pwsh、cmd、powershell`（前提已经安装只要配置程序相关路径即可）
  - 关联命令 `shellLauncher.launch`

#### 配置例子

```json
"shellLauncher.shells.windows": [
        {
            "shell": "C:\\Windows\\System32\\cmd.exe",
            "label": "cmd"
        },
        {
            "shell": "D:/Program Files/PowerShell/7/pwsh.exe",
            "label": "pwsh7"
        }
]
```

# _未完待续_

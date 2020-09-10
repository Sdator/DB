# 终端类

## `formulahendry.terminal`

- ### 主要使用功能

  - ### 用于把命令输出到out窗口

  - ### 快速从终端中打开活动文件所在路径

- ### 问题

  - Q：由于快捷键冲突导致 `F1` 命令行无法复制粘贴
  - A：删除或修改键绑定

- ### 包含功能

  - 在当前文件打开控制台并 `cd` 到当前文件目录
    + 快捷键 `Ctrl+Alt+O`
    + 命令 `Open in Integrated Terminal` 、`terminal.open`
  - 在终端中执行活动文件 
    + 命令
      + `terminal.run`   
        + 在输出页中回显
      + `workbench.action.terminal.runActiveFile` 
        + 编辑器自带
        + 在终端输出
  - 在终端运行当前选中代码
    - 命令  
      - `terminal.run` 
        - 在输出页中回显
        - 需选中代码
      - `workbench.action.terminal.runSelectedText` 
        - 编辑器自带 
        - 在终端输出
        - 无需选中代码、采用运行光标行
  - 停止所有运行的命令  
    + 命令 `terminal.stop` 

## `tyriar.terminal-tabs`

- ### 主要使用功能

  - ### 终端快速切换、`UI`集成

- ### 包含功能

  - 在状态栏创建终端快捷图标
    - `terminalTabs.createTerminal` 创建图标
    - `terminalTabs.createNamedTerminal` 创建标签的图标
  -  切换终端  1-10 
    - `terminalTabs.showTerminal1`
    - `terminalTabs.showTerminal2`
    - `terminalTabs.showTerminal3`



## `tyriar.shell-launcher`

- ### 主要使用功能

  - ### 多终端集成

- ### 需配置文件

  `shellLauncher.shells.windows`

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

- ### 包含功能

  - 创建、切换不同终端如：`bash、pwsh、cmd、powershell`（前提已经安装只要配置程序相关路径即可）
    - 命令 `shellLauncher.launch`

  
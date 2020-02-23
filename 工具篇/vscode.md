# vscode些变量


## workspace文件夹下的结构如下
/home/Coding/Test
- .vscode
  - tasks.json
  - launch.json
- main.cpp



- `${workspaceFolder}` 表示当前workspace文件夹路径，也即/home/Coding/Test
- `${workspaceRootFolderName}` 表示workspace的文件夹名，也即Test
- `${file}` 文件自身的绝对路径，也即/home/Coding/Test/.vscode/tasks.json
- `${relativeFile}` 文件在workspace中的路径，也即.vscode/tasks.json
- `${fileBasenameNoExtension}` 当前文件的文件名，不带后缀，也即tasks
- `${fileBasename}` 当前文件的文件名，tasks.json
- `${fileDirname}` 文件所在的文件夹路径，也即/home/Coding/Test/.vscode
- `${fileExtname}` 当前文件的后缀，也即.json
- `${lineNumber}` 当前文件光标所在的行号
- `${env:PATH}` 系统中的环境变量


# Git学习

- [Git学习](#git%e5%ad%a6%e4%b9%a0)
- [设置代理](#%e8%ae%be%e7%bd%ae%e4%bb%a3%e7%90%86)
- [查询代理状态](#%e6%9f%a5%e8%af%a2%e4%bb%a3%e7%90%86%e7%8a%b6%e6%80%81)
- [初始化库](#%e5%88%9d%e5%a7%8b%e5%8c%96%e5%ba%93)
- [克隆到本地](#%e5%85%8b%e9%9a%86%e5%88%b0%e6%9c%ac%e5%9c%b0)
- [暂存](#%e6%9a%82%e5%ad%98)
- [提交](#%e6%8f%90%e4%ba%a4)
- [移除](#%e7%a7%bb%e9%99%a4)
- [更名移动](#%e6%9b%b4%e5%90%8d%e7%a7%bb%e5%8a%a8)
- [推送到服务器](#%e6%8e%a8%e9%80%81%e5%88%b0%e6%9c%8d%e5%8a%a1%e5%99%a8)
- [分支](#%e5%88%86%e6%94%af)
	- [撤销](#%e6%92%a4%e9%94%80)
	- [远程仓库管理](#%e8%bf%9c%e7%a8%8b%e4%bb%93%e5%ba%93%e7%ae%a1%e7%90%86)
	- [忽略某些文件 不跟踪](#%e5%bf%bd%e7%95%a5%e6%9f%90%e4%ba%9b%e6%96%87%e4%bb%b6-%e4%b8%8d%e8%b7%9f%e8%b8%aa)
	- [配置](#%e9%85%8d%e7%bd%ae)
	- [日志](#%e6%97%a5%e5%bf%97)



# 设置代理
```bash
# 全局代理
git config --global http.proxy 127.0.0.1:1234
git config --global https.proxy 127.0.0.1:10000
git config --global http.proxy 'socks5://127.0.0.1:10086'
git config --global https.proxy 'socks5://127.0.0.1:10086'
git config --global http.proxy http://localhost:10000/
git config --global https.proxy http://localhost:10000/

# 局部代理 仓库内执行
git config --local http.proxy 127.0.0.1:1087
```



# 查询代理状态
```bash
#查询全局代理
git config --global http.proxy

# 查询局部代理
git config --local http.proxy

# 取消代理
git config --global --unset http.proxy
git config --global --unset https.proxy
git config --local --unset http.proxy
```

# 初始化库
	1、创建库
		git init
	2、跟踪目录下的所有文件、放入暂存区域
		git add	
	
# 克隆到本地
	git clone git@github.com:liusikair/log.git

	从默认分支(master)中直接合并到本地分支
	git pull origin master

		
# 暂存
	1、添加文件到跟踪列表/或暂存
		git add abc.txt
	
	2、状态查询
		检查当前库状态，可以查询那些文件未纳入追踪，或被修改，提交次数等
		git status
		 回显
			On branch master				当前分支是master
			Untracked files					未追踪
			Changes to be committed			已暂存还没提交			绿字提示
			Changes not staged for commit	文件发生变化但未暂存	 红字提示
		
		同上但可列出差异，修改前后的变化
		git diff
		
		查看已经暂存起来的变化
		git diff --staged/git diff --cached	
	
# 提交
		git commit
		git commit -a    				跳过暂存直接提交所有已跟踪的文件
		git commit -m "20170927"    	提交信息
		git commit -a -m "Git学习"
		
	
# 移除
	git rm 文件名		从暂存区和跟踪列表中删除，连带本地文件删除，如果手动删除会遗留在状态缓存中
	git rm -f 文件名	强制从暂存区中删除
	git rm \*~			递归删除目录下的所有波浪线结尾的文件  注意反斜杠是git的专属命令和不同于shell处理
		
# 更名移动
	mv README.txt README	
	
	
	
# 推送到服务器
	上传本地默认分支(master)到远程仓库(origin)中
	git push origin master
	git push origin master -f		强制推送，普通推送失败不妨试试
	git push -u origin master
	
# 分支
	列出分支清单
	git branch
	-v  详细列出最后一次提交信息
	
	查询合并了的分支 分支上游
	git branch --merged
	--no-merged    查询未合并的分支
	
	创建分支 
	git branch 分支名
	git branch air
	
	切换到指定分支工作
	git checkout 分支名
	git checkout air
	
	创建并切换到该分支
	git checkout -b air
	
	分支合并
	git checkout origin		切换回origin分支
	git merge air			和air分支合并
	
	合并冲突可用git status查询
	
	删除分支
	git branch -d 分支名
	-D	强制删除
	
	
	切换分支时绕过分支未保存提示
	 stashing 和 commit amending
	
	
## 撤销
	git reset HEAD <file>		把暂存区的修改撤销掉  适合撤销add操作
				改变HEAD指针 可以理解为撤销上一次的提交操作，返回到上一个版本

	git checkout -- file		撤销修改，前提未暂存
	git commi --amend			当你提交注释写错了可以用以下命令重新更改
	git reset --soft HEAD~2		指针回退实现新的内容覆盖旧的提交
	HEAD 	是当前分支引用的指针，总是指向该分支上的最后一次提交

git remote add web https://gitee.com/sdator/sdator.git

	
## 远程仓库管理

	1、添加远程仓库
		git remote add 仓库名字 仓库连接地址
		git remote add origin git@github.com:liusikair/log.git
	
	2、下载远程仓库中独有的文件到本地  也就是只下载本地仓库中不存在的文件，多人项目时好使
		git fetch 仓库名字
		git fetch origin

	查询当前系统有那些仓库
		git remote			
		git remote	-v			显示对应的仓库地址
	
	查看远程仓库详细信息
		git remote show 仓库名字
		回显
			Remote branch merged	 默认推送的分支 pull时合并到本地
			New remote branches		 新的分支本地没有
			Stale tracking branches	 已同步到本地的分支远程端被删除
		
	修改远程仓库在本地的名称
		git remote rename			   
		git remote rename origin air  把本地的origin仓库名改为air
	
	移除仓库
		git remote rm 仓库名字


	
## 忽略某些文件 不跟踪
	$ cat .gitignore		创建文件.gitignore
	#我是注释				注释	
	*.[oa]					忽略o或a结尾的文件
	*~						忽略波浪线结尾的文件
	/AIR					忽略当前目录下名字为AIR的文件
	AIR/					忽略AIR目录下的所有文件
	AIR/*.txt				忽略AIR目录下当前的所有txt文件 不包含子目录下的txt文件	
	!A.txt					A.txt文件除外 不忽略
		

	
	

## 配置
	添加个人 github 信息
	git config --global user.email "你的邮箱"
	git config --global user.name "你的用户名"
	
	生成密钥 
	ssh-keygen -t rsa -b 4096 -C "邮箱地址"

	后台启动ssh-agent
	eval $(ssh-agent -s)

	添加私钥到ssh中
	ssh-add ~/.ssh/id_rsa

	复制公钥(id_rsa.pub)文件中的内容到git
	clip < ~/.ssh/id_rsa.pub

	把本地密钥安装到服务器
	ssh-copy-id -i ~/.ssh/id_rsa.pub user@server
	ssh-copy-id -i ~/.ssh/git.pub root@34.92.230.171
	ssh-copy-id -i ~/.ssh/id_rsa.pub opc


## 日志
	-S 显示添加或移除了某个关键字的提交、图形表示、一行显示、显示新增、修改、删除的文件清单
	git log -S py  --graph --pretty=oneline  --name-status





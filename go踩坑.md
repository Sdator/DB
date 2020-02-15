CGO_ENABLED=0 GOOS=linux GOARCH=mips go build

CGO_ENABLED=0 GOOS=linux GOARCH=arm go build

查看go支持编译的架构列表
go tool dist list

关闭C语言版本的编译器
CGO_ENABLED=0


bash-5.0$ go tool dist list|grep mips
linux/mips
linux/mips64

el代表小端字节序
linux/mips64le
linux/mipsle


在mac上编译64位linux的命令编译命令
GOOS=linux GOARCH=amd64 go build hello.go



Go 语言中，包基于路径.

- 一个目录下一个包(不允许包含多个)，同一个包可以包含多个文件.
  同一个包下的多个文件之间变量可以相互引用.
- 一个包不允许存在多个目录下

### 包导入


```go

//常规导入
import "fmt"

//别名导入，针对于package 重名的情况
alias_name import "package"

//. 导入，可以直接使用，无需前缀
. import "package"

```

### 程序示例(一)

相同package 下函数可以相互访问.

#### 目录结构

```bash
$ tree -t
.
├── output.go
└── main.go

1 directory, 2 files
```

#### 函数实现

**main.go** 文件.

```go
package main

func main() {
	output()
}
```

**output.go** 文件.

```go
package main

import "fmt"

func output() {
	fmt.Println("nihao")
}
```


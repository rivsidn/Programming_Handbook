## Go函数

### 函数基础

```go
package main

import "fmt"

func main() {
    fmt.Println("hello world")
}
```
`main` 函数不能有返回值.

### 函数返回值

```go
package main

import (
	"fmt"
)

func sum(a int, b int) int {    //声明函数返回值为 int
	return a + b
}

func main() {
	fmt.Println(sum(1, 2))
}
```

函数返回值示例.


### 特殊函数

| 函数名称 | 说明                  |
|----------|-----------------------|
| init     | main 函数执行之前调用 |



## 程序基础

### 安装

```go
sudo apt install golang-go
```

### 注释

支持两种类型注释.

- 单行注释
  ```go
  //这是一行注释
  ```
- 多行注释
  ```go
  /*
   * 这是多
   * 行注释
   */
  ```

### 处理参数

```go
package main

import (
	"fmt"
	"os"
)

func main() {
	for i, arg := range os.Args {
		fmt.Printf("%d: %s\n", i, arg)
	}
}
```

依次输出函数调用参数.




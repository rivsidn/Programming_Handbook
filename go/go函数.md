### 函数基础

```go
package main

import fmt

main() {
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

func sum(a int, b int) int {
	return a + b
}

func main() {
	fmt.Println(sum(1, 2))
}
```

函数返回值示例.




### 函数定义

```bash
function hello() {
    echo "Hello"
}
```

```bash
hello() {
    echo "Hello"
}
```


### 参数传递

```bash
show_args() {
    echo "$1"
    echo "$#"
    echo "$@"
}

show_args "nihao" "demo"
```

特殊参数:

| 参数 | 说明     |
|------|----------|
| $1   | 参数     |
| $#   | 参数个数 |
| $@   | 所有参数 |


### 返回值


只能返回整数状态码.

```bash
function_return() {
    return 0
}
```


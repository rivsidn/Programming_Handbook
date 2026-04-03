

### 模块定义

一个 Python 模块通常就是：

- 一个 .py 文件
- 文件里定义了函数、类、变量
- 可以被别的 Python 代码 import

### 初始化

在 Python 里，模块的“初始化”通常就是：

- 模块顶层代码
- 在模块第一次被 import 时自动执行一次

```python
# app.py
print("导入时执行")

if __name__ == "__main__":
    print("直接运行时执行")
```


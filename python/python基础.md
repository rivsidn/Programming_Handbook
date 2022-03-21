## python运行

### 交互解释器运行

```bash
$ python3
Python 3.8.10 (default, Nov 26 2021, 20:14:08) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> print("Hello, World!")
Hello, World!
>>>
```

结束之后，`quit()`  或者 `ctrl+D` 退出。

### 脚本运行

```python
#!/usr/bin/python

print("Hello, World!\n")
```

运行与`shell`脚本一致。



## python注释

### 单行注释

`python` 与大部分脚本语言一样，使用`#` 符号作为注释，从`#` 符号开始到该行结束都是注释内容。

### 多行注释

```python
'''
使用单引号的多行注释
'''

"""
使用双引号的多行注释
"""
```



### 文档字符串

`python` 还有一种叫做文档字符串的特别注释，加在在模块、类、或这函数的起始位置，文档字符串可以在运行时访问，也可以用来自动生成文档。



## python缩进

`python` 不通过`{}` 来控制代码块，而是通过缩进来控制。








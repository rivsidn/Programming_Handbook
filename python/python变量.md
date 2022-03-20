## 变量类型

### 程序解释分类

| 用途       | 类型       | 举例 | 构造函数     |
| ---------- | ---------- | ---- | ------------ |
| 文本类型   | str        |      | str()        |
| 数值类型   | int        |      | int()        |
|            | float      |      | float()      |
|            | complex    |      | complex()    |
| 序列类型   | list       |      | list()       |
|            | tuple      |      | tuple()      |
|            | range      |      | range()      |
| 映射类型   | dict       |      | dict()       |
| 集合类型   | set        |      | set()        |
|            | frozenset  |      | frozenset()  |
| 布尔类型   | bool       |      | bool         |
| 二进制类型 | bytes      |      | bytes()      |
|            | bytearray  |      | bytearray()  |
|            | memoryview |      | memoryview() |



```python
#!/usr/bin/python3

# 输出变量类型
x = 10
print(type(x))
```

想要指定特定的数据类型，可以使用构造函数。



### 生命周期分类

* 全局变量

  函数外部创建的变量称为全局变量，全局变量可以被函数内部和外部的每个人使用。

* 局部变量

  函数内部创建的变量为局部变量，局部变量只能在函数内部使用。如果局部变量和全局变量重名，在该函数生命周期内，如果想要访问全局变量，需要添加`global` 关键字，否则全局变量会被覆盖。



## 数字

`python` 中有三种数字类型，分别为：

* int

  完整的数字，正数或负数，没有小数。

* float

  包含小数的正数或负数，也可以是带有`e` 的科学数字，表示10 的幂。

* complex

  复数用`j` 作为虚部编写。



###  确认数字类型

```python
#!/usr/bin/python3

x = 10
y = 6.3
z = 2j

print(type(x))
print(type(y))
print(type(z))
```

### 数字类型转换

可以通过`int()`、`float()`、`complex()` 从一个类型转换到另一个类型。

### 生成随机数

```python
import random

print(random.randrange(1, 10))
```



## 字符串

字符串是由数字、字母、下划线组成的一串字符，字符串可以用单引号或双引号进行声明；可以使用三个(单)引号将多行字符串赋值给变脸。

python 没有字符数据类型，但个字符就是长度为1 的字符串。

### 多行字符串

```python
str = """
this is a multiline text
this is a multiline text
this is a multiline text
this is a multiline text
"""

print(str)
```

### 字符串长度

```python
str = "hello world"

print(len(a))
```

### 字符串截取

| a    | b    | c    | d    | e    | f    |
| ---- | ---- | ---- | ---- | ---- | ---- |
| 0    | 1    | 2    | 3    | 4    | 5    |
| -6   | -5   | -4   | -3   | -2   | -1   |

```python
#!/usr/bin/python3

str="abcdef"

print(str[0])
print(str[0:2])
print(str[2:-1])

"""
$ ./string.py 
a
ab
cde
"""
```

### 字符串合并

```python
#!/usr/bin/python3

x = "Python is "
y = "awesome"
z = x + y
print(z)
```

### 字符串方法

```python
str = " Hello, World! "

# 删除开头或结尾空白字符
print(str.strip())
# 返回小写字符串
print(str.lower())
# 返回大写字符串
print(str.upper())
# 替换字符串
print(str.replace("World", "Kitty"))
# 切割字符串
print(a.split(","))
```




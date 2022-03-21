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

### 字符串级联

```python
#!/usr/bin/python3

x = "Python is "
y = "awesome"
z = x + y
print(z)
```

### 字符串包含

用`in`  `not in` 判断字符串是否包含。

```python
txt = "China is a great country"
# 输出bool类型
x = "ina" in txt
print(x)
```

### 字符串方法

| 方法 | 描述 |
| ---- | ---- |
|      |      |

**示例**

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

**格式化字符串**

```python
age = 63
txt = "My name is Bill, I am {}"

print(txt.format(age))
```





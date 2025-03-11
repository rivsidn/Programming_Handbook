`lambda` 函数是一种小的匿名函数。

`lambda` 函数可以接受任意数量的参数，但只能有一种表达式。

## 语法

```python
lambda arguments:expression
```



## 示例

```python
x = lambda a : a+10

print(x(5))
```



## 匿名函数

`lambda` 作为匿名函数时的用法，通过设置 n 的值，返回一个可以使用的函数。

```python
def myfunc(n):
    return lambda a : a*n

mydoubler = myfunc(2)
mytripler = myfunc(3)

print(mydoubler(11))
print(mytripler(11))
```


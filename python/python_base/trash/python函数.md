## 基本用法

```python
# 函数创建
def my_function():
    print("Hello from a function")

# 函数调用
my_function()
```



## 函数参数

```python
def my_functon(fname):
    print(fname+ " Gates")

my_function("Bill")
```



### 默认参数

```python
def my_function(country="China"):
    print("I am from " + country)

my_function("Sweden")
my_function()
```



### 关键字参数

传递参数的时候，指定参数名，使得参数的传递与顺序无关。

### 任意参数

如果参数数目未知，可以在参数名称前边加 `*`。

```python
def my_function(*kids):
    print("The youngest child is " + kids[2])

my_function("Phoebe", "Jennifer", "Rory")
```



## 返回值

```python
def my_function(x):
    return 5*x

print(my_function(3))
print(my_function(4))
print(my_function(5))
```






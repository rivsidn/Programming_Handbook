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



## 类定义

### 简单示例

```python
class Dog:
    def __init__(self, name):
        self.name = name

    def bark(self):
        print(self.name, "wang")
```

使用时:

```python
d = Dog("Buddy")
d.bark()
```

## 属性

### 类属性

```python
class Dog:
    species = "Canis familiaris"

    def __init__(self, name):
        self.name = name
```

### 实例属性

实例属性属于“对象实例”，通常在 __init__ 里通过 self.xxx 定义。

```python
class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age
```

### 私有属性

Python 没有真正严格的 private，但常见有两种写法：

- \_name：表示“内部使用，不建议外部直接访问”
- \_\_name：会触发名称重整（name mangling）

```python
class Dog:
    def __init__(self, name):
        self._name = name
        self.__secret = "hidden"
```

## 方法

### 类方法

```python
class Dog:
    count = 0

    def __init__(self, name):
        self.name = name
        Dog.count += 1

    @classmethod
    def get_count(cls):
        return cls.count
```

- 用 @classmethod 装饰
- 第一个参数通常是 cls
- 绑定的是“类”，不是实例
- 常用于操作类属性，或写工厂方法

### 实例方法

```python
# 定义
class Dog:
    def __init__(self, name):
        self.name = name

    def bark(self):
        print(self.name, "wang")

# 调用
d = Dog("Buddy")
d.bark()
```

- 第一个参数通常是 self
- 通过对象实例调用
- 可以访问对象属性，也可以访问类属性

#### 特殊方法

Python 里一类特殊命名的方法，比如：

  - __init__
  - __str__
  - __repr__
  - __len__

它们本质上通常也是实例方法，只是会被 Python 在特定场景自动调用。

### 静态方法

```python
class MathTool:
    @staticmethod
    def add(a, b):
        return a + b

# 调用
print(MathTool.add(1, 2))
```

- 用 @staticmethod 装饰
- 不需要 self
- 也不需要 cls
- 只是逻辑上放在类里面，和类有一定关系




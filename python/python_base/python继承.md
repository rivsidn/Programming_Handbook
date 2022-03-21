`python` 继承允许我们定义一个类，继承另一个类的所有方法和属性。

**父类** 是被继承的类，也成为基类。

**子类** 是从另一个类继承的类，也成为派生类。



## 创建父类

任何类都可以是父类，因此语法与创建任何其他类相同。

```python
class Person:
    def __init__(self, fname, lname):
        self.firstname = fname
        self.lastname = lname
        
	def printname(self):
        print(self.firstname, self.lastname)
```



## 创建子类

```python
class Student(Person):
    pass

x = Student("Elin", "Musk")
x.printname()
```

子类没有实现任何的属性或方法，此时，子类拥有和父类相同的属性和方法。

### 创建`__init__` 函数

```python
class Student(Person):
    def __init__(self, fname, lname):
        pass
```

人上所是，如果定义了`__init__()` 函数之后，就不可以访问父类的属性和方法了。

### 继承父类-父类名字

```python
class Student(Person):
    def __init__(self, fname, lname):
        Person.__init__(self, fname, lname)
```

### 继承父类-supper()函数

```python
class Student(Person):
    def __init__(self, fname, lname)
		super().__init__(fname, lname)
```




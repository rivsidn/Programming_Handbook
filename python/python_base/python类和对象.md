`python` 是一种面向对象的编程语言，几乎所有的东西都是对象，拥有属性和方法。



```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    def myfunc(self):
        print("my name is " + self.name)

        
p1 = Person("Bill", 63)
p1.myfunc()
```



**Tips: self 参数是类对当前实例的引用，用于访问属于该类的变量。他不必命名为self，但它必须是类中任意函数的首个参数。**


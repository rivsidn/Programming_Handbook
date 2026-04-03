
› 类继承 简单实例


• 可以，给你一个最简单的 Python 类继承例子。

  class Animal:
      def speak(self):
          print("animal sound")


  class Dog(Animal):
      def bark(self):
          print("wang wang")

  这里：

  - Animal 是父类
  - Dog 是子类
  - Dog(Animal) 表示 Dog 继承 Animal

  使用：

  d = Dog()

  d.speak()   # 继承自 Animal
  d.bark()    # Dog 自己的方法

  输出：

  animal sound
  wang wang

  这说明：

  - 子类可以直接使用父类的方法
  - 子类也可以定义自己的方法

  再看一个带初始化的例子

  class Animal:
      def __init__(self, name):
          self.name = name

      def speak(self):
          print(self.name, "makes a sound")


  class Dog(Animal):
      def bark(self):
          print(self.name, "wang wang")

  使用：

  d = Dog("Buddy")
  d.speak()
  d.bark()

  输出：

  Buddy makes a sound
  Buddy wang wang

  这里虽然 Dog 没有写 __init__，但它继承了父类的 __init__。

  子类重写父类方法

  子类也可以覆盖父类的方法：

  class Animal:
      def speak(self):
          print("animal sound")


  class Dog(Animal):
      def speak(self):
          print("dog wang wang")

  使用：

  d = Dog()
  d.speak()

  输出：

  dog wang wang

  这叫方法重写。

  子类调用父类初始化

  如果子类要增加自己的属性，通常会用 super()：

  class Animal:
      def __init__(self, name):
          self.name = name


  class Dog(Animal):
      def __init__(self, name, age):
          super().__init__(name)
          self.age = age

  使用：

  d = Dog("Buddy", 3)
  print(d.name)
  print(d.age)

  这里：

  - super().__init__(name) 调用父类初始化
  - self.age = age 初始化子类自己的属性

  一句话理解继承

  继承就是：

  - 先复用父类已有的属性和方法
  - 再在子类里扩展或修改行为

  如果你愿意，我可以继续给你讲：

  1. 父类、子类、super() 的关系图
  2. __name 在继承里的区别示例
  3. pytest 里测试类是否适合继承




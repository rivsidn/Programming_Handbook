
## 附录

### AI

#### 多重继承

› super(OpenWRT_vm, self).__init__(username, password, disk_image=disk_image, ram=128)

  这个写法如何解释？


• 这行代码的意思是：在 OpenWRT_vm 这个类里，调用“父类/下一个类”的 __init__ 初始化方法。

  原句：

  super(OpenWRT_vm, self).__init__(
      username,
      password,
      disk_image=disk_image,
      ram=128
  )

  可以拆开理解：

  - super(OpenWRT_vm, self)
      - 表示：从 self 这个对象出发，按照 OpenWRT_vm 的继承顺序（MRO）去找“下一个类”
      - 它不是简单地写死“父类名”，而是按 Python 的继承链规则去找
  - .__init__(...)
      - 调用找到的那个类的构造函数
  - username, password
      - 这是位置参数
  - disk_image=disk_image, ram=128
      - 这是关键字参数
      - disk_image=disk_image 表示把当前作用域里的变量 disk_image 传给参数名 disk_image
      - ram=128 表示固定传入 128

  等价地说，这行代码是在做：

  “创建 OpenWRT_vm 对象时，顺便调用父类的初始化逻辑，并传入用户名、密码、磁盘镜像和内存大小。”

  比如：

  class VM(object):
      def __init__(self, username, password, disk_image=None, ram=256):
          self.username = username
          self.password = password
          self.disk_image = disk_image
          self.ram = ram

  class OpenWRT_vm(VM):
      def __init__(self, username, password, disk_image):
          super(OpenWRT_vm, self).__init__(
              username,
              password,
              disk_image=disk_image,
              ram=128
          )

  这里的效果就是：

  - OpenWRT_vm 继承自 VM
  - 创建 OpenWRT_vm 时，实际会调用 VM.__init__
  - 并且把 ram 固定设成 128

  补充两点：

  - 这是较老的写法，常见于 Python 2 或兼容写法
  - 在 Python 3 里通常直接写成：

  super().__init__(username, password, disk_image=disk_image, ram=128)

  再补一个容易误解的点：

  - super(...) 不一定只表示“直接父类”
  - 在多继承里，它表示“按 MRO 顺序的下一个类”

  如果你愿意，我还可以继续给你讲：

  1. 为什么这里不用直接写 VM.__init__(self, ...)
  2. super(OpenWRT_vm, self) 里的两个参数各自是什么意思
  3. 多继承时 super() 到底怎么找下一个类


› - super(...) 不一定只表示“直接父类”
  怎么理解


• 可以这样理解：

  super(...) 的本质不是“去找我写代码这个类的直接父类”，而是：

  - 先看当前对象所属类的继承顺序（MRO）
  - 在这个顺序里找到“当前类”
  - 然后去调用它后面的那个类的方法

  所以它更准确的意思是：

  “按继承解析顺序，调用下一个类的方法”

  不是“强行调用直接父类”。

  先看单继承

  class A:
      def f(self):
          print("A")

  class B(A):
      def f(self):
          print("B")
          super().f()

  这里 B 的 MRO 是：

  [B, A, object]

  所以 super() 确实会找到 A，看起来就像“调用直接父类”。

  这也是为什么很多人会把 super() 误解成“父类调用器”。

  但多继承时就不一样了

  看这个例子：

  class A:
      def f(self):
          print("A")
          super().f()

  class B:
      def f(self):
          print("B")

  class C(A, B):
      pass

  C 的 MRO 是：

  [C, A, B, object]

  如果执行：

  c = C()
  c.f()

  过程是：

  1. 先找到 A.f
  2. A.f 里面调用 super().f()
  3. 这时不是去找 A 的“直接父类”
  4. 而是看 C 的 MRO，在 A 后面是谁
  5. A 后面是 B
  6. 所以调用的是 B.f

  输出是：

  A
  B

  注意这里最关键的一点：

  - A 并没有显式继承 B
  - 但 A 里的 super() 仍然可能调用到 B

  这就说明：

  super() 看的不是“A 写代码时它爹是谁”，而是“当前实例所属类 C 的整体继承顺序”。

  一句话版

  super() 调用的是 MRO 里的下一个类，不一定是源码里看到的直接父类。

  为什么要这样设计

  因为 Python 要支持“协作式多继承”。

  比如多个类都想参与初始化：

  class Base:
      def __init__(self):
          print("Base")

  class LogMixin:
      def __init__(self):
          print("LogMixin")
          super().__init__()

  class AuthMixin:
      def __init__(self):
          print("AuthMixin")
          super().__init__()

  class App(LogMixin, AuthMixin, Base):
      def __init__(self):
          print("App")
          super().__init__()

  App 的 MRO 是：

  [App, LogMixin, AuthMixin, Base, object]

  执行 App() 时会按顺序走：

  App -> LogMixin -> AuthMixin -> Base

  这就是 super() 最重要的用途：
  让每个类都只负责“调用下一个”，从而把整条继承链串起来。

  回到你原来的代码

  super(OpenWRT_vm, self).__init__(...)

  它的准确含义不是：

  - “调用 OpenWRT_vm 的直接父类 __init__”

  而是：

  - “对 self 这个对象，按照它所属类的 MRO，在 OpenWRT_vm 后面找下一个类，并调用那个类的 __init__”

  如果 OpenWRT_vm 是普通单继承，那这个“下一个类”通常就正好是它父类；
  但在多继承场景里，未必如此。

  你可以记这个公式

  super(CurrentClass, self).method(...)

  约等于：

  - 取 self.__class__.__mro__
  - 找到 CurrentClass
  - 调用它后面那个类的 method(...)

  如果你愿意，我可以继续用一张“继承链 + MRO 顺序图”把 super() 的查找过程画出来，会更直观。


› C 的 MRO 是：

    [C, A, B, object]

  多重继承的时候，如何调用B 的f() 呢？


• 可以分成两种“调用 B.f()”的意思来看：

  1. 你想“按 MRO 流程，自然走到 B.f()”
  2. 你想“点名直接调用 B.f()”

  这两种写法不一样。

  1. 按 MRO 自然走到 B.f()：用 super() 串起来

  class A:
      def f(self):
          print("A")
          super().f()

  class B:
      def f(self):
          print("B")

  class C(A, B):
      pass

  c = C()
  c.f()

  C 的 MRO 是：

  [C, A, B, object]

  执行过程：

  - c.f() 先找到 A.f
  - A.f 里面执行 super().f()
  - 对于 C 的 MRO 来说，A 后面就是 B
  - 所以会调用 B.f

  输出：

  A
  B

  也就是说，B.f() 是被 A 里的 super().f() 接力调用到的。

  如果 C 自己也定义了 f：

  class C(A, B):
      def f(self):
          print("C")
          super().f()

  那么输出就是：

  C
  A
  B

  这才是多继承里最推荐的写法：每一层都 super()，让调用链按 MRO 往后传。

  ———

  2. 点名直接调用 B.f()：写 B.f(self)

  如果你就是想“不要绕，直接执行 B 的实现”，可以这样：

  class C(A, B):
      def g(self):
          B.f(self)

  调用：

  c = C()
  c.g()

  这会直接执行 B.f(c)。

  这相当于手动指定：

  - 不管当前 MRO 怎么走
  - 我就调用 B 这个类里的 f

  ———

  这两种方式的区别

  super() 方式：

  - 走 MRO
  - 适合协作式多继承
  - 更不容易重复调用、漏调用

  B.f(self) 方式：

  - 直接点名调用 B
  - 不走 MRO 链
  - 在菱形继承、多层 mixin 里容易把调用链打乱

  所以一般建议：

  - 如果你是在设计“多继承可协作”的类体系，用 super()
  - 如果你明确就想调用某个父类的具体实现，才用 B.f(self)

  ———

  还有一种写法：super(A, self).f()

  在你的这个 MRO 里：

  [C, A, B, object]

  如果写：

  super(A, self).f()

  它的意思是：

  - 在 self 的 MRO 中找到 A
  - 从 A 后面开始找 f
  - 所以会找到 B.f

  例如：

  class C(A, B):
      def g(self):
          super(A, self).f()

  这也会调用 B.f()。

  但这类写法通常不如前两种直观，所以实际代码里不算常见。

  ———

  一句话总结

  调用 B.f() 有三种理解：

  - 正常多继承链路里让它被调用：super()
  - 强制直接调用它：B.f(self)
  - 从 MRO 中“跳到 A 后面那个类”：super(A, self).f()





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




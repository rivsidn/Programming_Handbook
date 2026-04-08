
## 整数

## 浮点数

## 字符

## 字符串



## 符号

### 检查是否是符号变量

```lisp
(setq b 'a)
(symbolp b)     ; => t
```

### 输出符号变量的值

```lisp
(setq a 100)
(setq b 'a)

(message "b value %s", b)
(message "b value %d", (symbol-value b))
```

## 附录

### AI

#### elisp 中值的类型


• 我接着上一个问题，直接从“值有类型，变量没有固定类型”展开，把 Elisp 里最常见的值类型列出来，并给最小例子。

• 在 Elisp 里，值有类型，变量没有固定类型。

  也就是说：

  (setq x 10)        ;; x 现在绑定整数
  (setq x "hello")   ;; x 现在绑定字符串
  (setq x '(1 2 3))  ;; x 现在绑定列表

  这里变的是 x 绑定的值类型，不是 x 这个变量本身的类型。

  ## 常见的值类型

  ### 1. 整数 integer

  42
  -7
  0

  判断：

  (integerp 42)   ;; => t

  ———

  ### 2. 浮点数 float

  3.14
  -0.5

  判断：

  (floatp 3.14)   ;; => t

  ———

  ### 3. 字符 character

  在 Elisp 里，字符本质上是整数，但通常当作字符看待：

  ?a
  ?A
  ?你

  例如：

  (characterp ?a)   ;; => t

  ———

  ### 4. 字符串 string

  "hello"
  "你好"
  "abc123"

  判断：

  (stringp "hello")   ;; => t

  ———

  ### 5. 符号 symbol

  符号是 Lisp 里非常核心的一类值：

  foo
  bar
  my-var

  判断：

  (symbolp 'foo)   ;; => t

  注意这里常写成：

  'foo

  表示这个符号本身，而不是取变量 foo 的值。

  ———

  ### 6. 列表 list

  列表是 Elisp 最核心的数据结构之一：

  '(1 2 3)
  '(a b c)
  '("Tom" 18 t)

  判断：

  (listp '(1 2 3))   ;; => t

  ———

  ### 7. cons cell

  这是列表的底层构造单位。
  一个列表本质上是由很多 cons cell 串起来的。

  (cons 1 2)         ;; => (1 . 2)
  (cons 1 '(2 3))    ;; => (1 2 3)

  判断：

  (consp '(1 2 3))   ;; => t


  ———

  ### 8. 向量 vector

  向量和列表有点像，但写法不同：

  [1 2 3]
  ["a" "b" "c"]

  判断：

  (vectorp [1 2 3])   ;; => t

  向量是数组，列表是链表。
  ———

  ### 9. 布尔意义上的值：nil 和 t

  Elisp 没有单独的布尔类型那种强限制用法，最常见的是：

  - nil 表示假
  - t 表示真

  nil
  t

  例如：

  (if t "yes" "no")     ;; => "yes"
  (if nil "yes" "no")   ;; => "no"

  特别要注意：

  nil 同时也是空列表。

  (listp nil)   ;; => t

  这点是 Lisp 很有特点的地方。

  ———

  ## 其他也常见，但你现在不一定马上用到

  - buffer
  - window
  - frame
  - marker
  - hash-table
  - function
  - record
  - bool-vector

  例如：

  (current-buffer)

  返回的就是一个 buffer 对象。

  ———

  ## 怎么查看一个值的类型

  可以用 type-of：

  (type-of 10)         ;; => integer
  (type-of 3.14)       ;; => float
  (type-of "hello")    ;; => string
  (type-of 'foo)       ;; => symbol
  (type-of [1 2 3])    ;; => vector

  也常用各种 ...p 判断函数：

  - numberp
  - integerp
  - floatp
  - stringp
  - symbolp
  - listp
  - consp
  - vectorp
  - functionp

  例如：

  (numberp 10)         ;; => t
  (stringp "abc")      ;; => t
  (symbolp 'hello)     ;; => t

  ## 你现在最该先记住的几类

  如果你刚学 Elisp，先重点掌握这几种就够了：

  - 数字：10、3.14
  - 字符串："hello"
  - 符号：'foo
  - 列表：'(1 2 3)
  - nil 和 t

  可以把它们记成一句话：

  Elisp 最核心的值类型，就是数字、字符串、符号、列表，以及表示真假用的 nil/t。

› elisp 变量类新，变量如何赋值

• 我按入门最常用的几种情况来讲：Elisp 里的变量有没有“类型”，以及最常见的赋值写法分别是什么。

• 如果你是想问 “Elisp 变量有没有类型，变量怎么赋值”，可以这样理解。

  Elisp 是动态类型语言。更准确地说：

  值有类型，变量本身没有固定类型。

  也就是说，同一个变量先放数字、后放字符串，都是可以的：

  (setq x 10)
  (setq x "hello")
  (setq x '(1 2 3))

  这里 x 先后绑定到了不同类型的值。

  ## 最常见的赋值：setq

  这是最常用的写法：

  (setq x 10)
  (setq name "Tom")
  (setq nums '(1 2 3))

  也可以一次给多个变量赋值：

  (setq x 10
        y 20
        name "Alice")

  ## 局部变量：let

  如果你只想在一小段代码里临时使用变量，用 let：

  (let ((x 10)
        (y 20))
    (+ x y))

  这里 x 和 y 只在 let 的代码块里有效。

  也可以先声明再赋值：

  (let (x y)
    (setq x 10)
    (setq y 20)
    (+ x y))

  ## 定义全局变量：defvar

  如果你想定义一个全局变量，通常用 defvar：

  (defvar my-name "Tom"
    "我的名字。")

  它常用于“定义一个默认值”。

  注意：如果这个变量已经有值了，defvar 通常不会覆盖原来的值。

  > 如果这个变量还没有值，就给它一个初始值；
  > 如果已经有值了，就保留原值。

  ## 定义常量：defconst

  如果这个值不希望被随便改动，用 defconst：

  (defconst pi 3.14159
    "圆周率。")

  ## 另一种赋值：set

  set 也能赋值，但它接收的是“变量名这个符号”：

  (set 'x 100)

  这和下面基本类似：

  (setq x 100)

  初学阶段你优先记住 setq 就够了。

  ## 读取变量值

  直接写变量名即可：

  (setq x 10)
  (message "%S" x)

  这里会显示 10。

  ## 你先记住这三条就够了

  - Elisp 里通常是“值有类型，变量无固定类型”
  - 平时赋值最常用 setq
  - 临时局部变量最常用 let

  比如这个小例子：

  (setq name "Tom")

  (let ((age 18))
    (message "%s is %d years old" name age))

› set setq 的区别？

• 文档确认了核心区别：setq 把变量名当字面量处理，set 则接收“一个求值后得到符号的表达式”。我直接用对比例子说明。

• 最核心的区别就一句话：

  - setq：变量名不求值
  - set：第一个参数会先求值，求值结果必须是一个符号

  ## 最直观的对比

  ### setq

  (setq x 10)

  这里的 x 直接被当作变量名，不会先去求 x 的值。

  ### set

  (set 'x 10)

  这里必须写成 'x，因为 set 需要的第一个参数是“符号 x”。

  ———

  ## 为什么会这样？

  因为：

  - setq 是专门给变量赋值的语法形式
  - set 是普通函数风格的赋值方式

  所以这两句效果类似：

  (setq x 10)
  (set 'x 10)

  执行后，x 都会变成 10。

  ———

  ## set 更灵活的地方

  set 的优势是：变量名可以动态计算出来。

  例如：

  (setq name 'x)
  (set name 100)

  这里：

  - name 的值是符号 x
  - (set name 100) 等价于给 x 赋值

  结果就是：

  x   ;; => 100

  而你不能写：

  (setq name 100)

  这只会把 name 自己设为 100，不会去改 x。

  所以：

  - setq 适合直接写死变量名
  - set 适合“变量名本身也是算出来的”

  ———

  ## 再看一个对比例子

  (setq a 'x)
  (setq x 1)

  现在：

  a   ;; => x
  x   ;; => 1

  如果写：

  (set a 99)

  因为 a 的值是符号 x，所以相当于：

  (set 'x 99)

  最后：

  x   ;; => 99

  ———

  ## 返回值

  两者都会返回赋进去的值。

  (setq x 10)   ;; => 10
  (set 'x 20)   ;; => 20

  ———

  ## 你现在可以这样记

  最实用的记法：

  - 平时写代码，优先用 setq
  - 只有在“变量名需要动态决定”时，用 set

  比如：

  (setq x 10)        ;; 常规写法
  (set 'x 10)        ;; 也可以，但没必要
  (set some-symbol 10) ;; some-symbol 的值如果是 'x，就给 x 赋值

  如果你愿意，我下一步可以继续讲：

  - setq-local 和 set/setq 的区别
  - 为什么 setq 能一次写多个变量，而 set 不行



• 这里的 ' 可以理解成：“不要把后面的东西当作代码去求值，而是把它本身当数据。”

  所以：

  'x

  其实是下面这个写法的简写：

  (quote x)

  它的意思是：

  > 我要的是“符号 x 本身”，不是变量 x 的值。



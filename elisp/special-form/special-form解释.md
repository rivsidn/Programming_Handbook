
› 为什么说setq 是special-form 呢？


• 我先按 Emacs Lisp 的语境解释，重点会放在 special form 和普通函数/宏的求值规则区别上。

• 在 Emacs Lisp 里，setq 被称为 special form，核心原因是：它的参数不是按普通函数那样统一先求值。

  普通函数调用时，参数会先被求值：

  (f x y)

  会先算出 x 和 y 的值，再把结果传给 f。

  但 setq 不一样：

  (setq x (+ 1 2))

  这里它会：

  1. 不求值 x，把它当成“变量名”
  2. 求值 (+ 1 2)
  3. 把结果赋给变量 x

  如果 setq 是普通函数，那么 x 会先被求值，传进去的就不是“变量 x”，而是 x 当前的值，这样就没法写出这种赋值语法了。

  再看一个例子：

  (setq a 1
        b (+ a 2))

  这里是顺序执行的：先把 a 设为 1，再计算 b，所以 b 会得到 3。这也不是普通函数“所有参数先算完再调用”的行为。

  所以，setq 属于 special form，本质上就是因为它有特殊的求值规则。
  在 Lisp 里，凡是“参数不能按普通规则求值”的构造，通常就属于这类，比如 if、quote、let、setq。

  顺便对比一下：

  (set 'x 10)   ; set 是函数
  (setq x 10)   ; setq 是 special form

  set 需要你显式传入符号 x，而 setq 直接把 x 写出来即可，因为它自己就知道“这里不要先求值”。

  如果你愿意，我也可以继续讲一下 set、setq、setf 这几个名字在 Lisp 里的区别。


› form 是什么意思


• 在 Lisp/Emacs Lisp 里，form 可以理解成：

  一段可以拿给 Lisp 处理的表达式。

  最常见地，你可以把它先简单理解成“代码单位”或“表达式”。

  比如下面这些都是 form：

  42
  "hello"
  x
  (+ 1 2)
  (setq x 10)
  (if x 1 2)

  它们都可以作为一个完整单位，被解释器读取、求值。

  更准确一点说：

  - 原子也可以是 form，比如 42、"hello"、x
  - 列表也可以是 form，比如 (+ 1 2)、(setq x 10)

  所以 form 不是特指“函数调用”，而是更大的概念。

  结合你前面问的 special form：

  - form：表达式
  - special form：一种有特殊求值规则的表达式

  例如：

  (setq x 10)

  这是一个 form，同时它还是一个 special form，因为它不会像普通函数那样先把所有参数都求值。

  如果你愿意，我可以继续把 form、s-expression、expression 这几个词之间的关系也顺手讲清楚。


› form 和 函数什么区别


• 可以这样区分：

  form 是“代码的写法/表达式”，
  function 是“可调用的对象”。

  更直白一点：

  - form：你写出来、交给 Lisp 去求值的东西
  - function：求值过程中被“调用”的东西

  例如：

  (+ 1 2)

  这是一个 form。
  而这里面的 + 是一个 function。
  整个 form 的意思是：调用函数 +，参数是 1 和 2。

  所以：

  - (+ 1 2)：是 form
  - +：是 function

  再看几个例子：

  42
  "x"
  foo
  (setq x 10)
  (if x 1 2)

  这些全都是 form，但它们都不是“函数”。

  特别是：

  - 42 是字面量 form
  - foo 是符号 form
  - (setq x 10) 是 special form
  - (if x 1 2) 也是 special form

  所以关键区别是：

  1. form 是一个更大的概念
     凡是 Lisp 可以读取并求值的表达式，都叫 form
  2. function 只是其中相关的一类对象
     它专门负责“被调用”
  3. “函数调用”只是 form 的一种
     比如：

     (+ 1 2)

     这是一个 form，并且它恰好是“函数调用 form”

  一句话总结：

  form 是语法单位，function 是运行时可调用对象。
  或者更口语一点：

  form 是你写的代码，function 是代码里被调用的东西。


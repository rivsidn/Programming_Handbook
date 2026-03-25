


- (interactive)：让函数变成可交互调用的命令
- (interactive "...")：除了变成命令，还告诉 Emacs 怎么读取用户输入

### 1

```lisp
  (defun hello-a ()
    (message "你好 A"))

  (defun hello-b ()
    (interactive)
    (message "你好 B"))
```
函数 `hello-b()`可以通过 M-x 调用.

### 2

```lisp
  (defun hello-demo (name)
    "向用户问好。"
    (interactive "s请输入名字: ")
    (message "你好，%s！" name))
```

  这时：

  1. M-x hello-demo
  2. Emacs 会在 minibuffer 提示：请输入名字:
  3. 你输入 Tom
  4. 显示：你好，Tom！

› 函数参数 与 interactive 之间的关系


• 我直接把这两个概念拆开讲：函数参数负责“函数需要什么值”，interactive 负责“用户用命令方式调用时，这些值从哪里来”。

• 它们的关系可以概括成一句话：

  函数参数定义“要传什么”，interactive 定义“交互调用时怎么拿到这些参数”。

  看这个例子最清楚：

  (defun hello-demo (name)
    "向用户问好。"
    (interactive "s请输入名字: ")
    (message "你好，%s！" name))

  这里有两层意思：

  - (name)：说明这个函数需要一个参数 name
  - (interactive "s请输入名字: ")：说明如果用户用 M-x hello-demo 调用，Emacs 应该先提示用户输入一个字符串，并把这个字符串作为 name

  ## 两种调用方式

  ### 1. Lisp 代码调用

  你自己传参数：

  (hello-demo "Tom")

  这时 interactive 不起作用。

  ### 2. 交互方式调用

  比如：

  M-x hello-demo

  这时 Emacs 会执行 interactive，先向用户要输入，再把输入结果传给 name。

  ## 关键点

  ### 1. interactive 不会替代参数列表

  参数还是要写在 defun 里：

  (defun add (a b)
    ...)

  interactive 只是补充说明：如果用户交互调用，a 和 b 怎么获得。

  ### 2. interactive 产生的参数个数和顺序，要和函数参数对应

  例如：

  (defun add (a b)
    (interactive "n请输入 a: \nn请输入 b: ")
    (message "结果是: %s" (+ a b)))

  这里：

  - 第一个读到的值传给 a
  - 第二个读到的值传给 b

  ### 3. 没有 interactive，函数就不能直接当命令用

  例如：

  (defun add (a b)
    (+ a b))

  这个函数可以这样调用：

  (add 1 2)

  但不能直接 M-x add，因为 Emacs 不知道该怎么向用户获取 a 和 b。

  ## 一个更完整的对比

  (defun foo (x)
    (message "x = %s" x))

  - 可以 (foo 10)
  - 不能 M-x foo

  (defun bar (x)
    (interactive "n请输入数字: ")
    (message "x = %s" x))

  - 可以 (bar 10)
  - 也可以 M-x bar
  - M-x bar 时，Emacs 会先读一个数字，再传给 x

  ## 你可以这样理解

  - defun 参数：函数接口
  - interactive：命令行/用户界面的参数适配器

  或者更直白一点：

  > 普通函数调用时，参数由你写在代码里传入。
  > 交互调用时，参数由 interactive 帮你从用户那里取来。


• 可以。interactive 最常见的写法是：

  (interactive "参数代码提示语")

  如果有多个参数，就按顺序写多个“参数代码 + 提示语”，中间用换行 \n 分隔：

  (interactive "s名字: \nn年龄: ")

  这表示：

  - 第 1 个参数：读一个字符串，传给函数第 1 个形参
  - 第 2 个参数：读一个数字，传给函数第 2 个形参

  比如：

  (defun hello (name age)
    (interactive "s名字: \nn年龄: ")
    (message "你好，%s，你今年 %d 岁" name age))

  执行 M-x hello 时，Emacs 会依次询问名字和年龄。

  最常见的参数代码

  - s
    读取字符串。

  (interactive "s请输入名字: ")

  - n
    读取数字。

  (interactive "n请输入年龄: ")

  - p
    读取前缀参数，并转成数字。
    这个很常用，通常配合 C-u。

  (defun repeat-demo (n)
    (interactive "p")
    (message "前缀参数是 %d" n))

  如果直接 M-x repeat-demo，通常 n 是 1。
  如果 C-u 5 M-x repeat-demo，那么 n 就是 5。

  - P
    读取“原始前缀参数”，不自动转数字。
    比 p 更底层一些。

  (defun raw-prefix-demo (arg)
    (interactive "P")
    (message "原始前缀参数: %S" arg))

  - r
    读取当前选区，会传两个参数：region-beginning 和 region-end。

  (defun region-demo (beg end)
    (interactive "r")
    (message "选区起点=%d, 终点=%d" beg end))

  注意：r 不是传 1 个值，而是传 2 个值，所以函数必须写两个参数。

  - f
    读取一个已存在的文件名。

  (interactive "f请选择文件: ")

  - F
    读取文件名，文件可以不存在。

  (interactive "F输出到文件: ")

  - D
    读取目录名。

  (interactive "D请选择目录: ")

  - b
    读取一个已存在的 buffer 名。

  (interactive "bBuffer 名: ")

  - B
    读取 buffer 名，可以是不存在的。

  (interactive "B新 buffer 名: ")

  - c
    读取一个字符。

  (interactive "c请输入一个字符: ")

  - x
    读取一个 Lisp 表达式，但不求值。

  (interactive "x请输入表达式: ")

  如果输入 (+ 1 2)，拿到的是列表本身，不是 3。

  - X
    读取一个 Lisp 表达式，并立即求值。

  (interactive "X请输入并求值: ")

  如果输入 (+ 1 2)，拿到的是 3。

  - a
    读取函数名。

  (interactive "a函数名: ")

  - C
    读取命令名，也就是“可交互调用的函数”。

  (interactive "C命令名: ")

  - v
    读取变量名。

  (interactive "v变量名: ")

  两个很实用的例子

  例 1：字符串 + 数字

  (defun person-demo (name age)
    (interactive "s名字: \nn年龄: ")
    (message "name=%s age=%d" name age))

  例 2：选区操作

  (defun count-region-chars (beg end)
    (interactive "r")
    (message "选区长度: %d" (- end beg)))

  先选中一段文本，再执行 M-x count-region-chars。

## TODO

  补充一句
  interactive 字符串开头有时还会出现这些前缀：

  - *：如果当前 buffer 只读，就报错
  - @：涉及鼠标事件时，先选中对应窗口
  - ^：配合 shift-selection

  比如：

  (interactive "*p")

  这里真正的参数代码还是 p，前面的 * 只是附加控制，不是参数类型。




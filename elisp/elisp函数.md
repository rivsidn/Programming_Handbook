
› elisp 函数定用，如何传递参数，如何设置返回值


• 我直接用几个最小例子说明 defun、参数列表和返回值规则，重点放在你现在立刻会用到的部分。

• 可以先把 Emacs Lisp 函数理解成这一个基本模板：

```lisp
  (defun 函数名 (参数1 参数2 ...)
    "文档字符串。"
    表达式1
    表达式2
    ...)
```

  ## 1. 如何定义函数

  最简单的函数：

  (defun hello ()
    (message "你好"))

  调用它：

  (hello)

  ## 2. 如何传递参数

  最常见的是按位置传参：

  (defun add (a b)
    (+ a b))

  调用：

  (add 3 5)

  返回结果是：

  8

  这里：

  - a 接收 3
  - b 接收 5

  再看一个字符串例子：

  (defun greet (name)
    (concat "你好，" name))

  调用：

  (greet "Tom")

  结果：

  "你好，Tom"

  ## 3. 如何设置返回值

  Emacs Lisp 一般不用专门写 return。
  函数体里最后一个表达式的值，就是返回值。

  例如：

  (defun square (x)
    (* x x))

  这里最后一个表达式是：

  (* x x)

  所以它的结果会被返回。

  再看一个多表达式例子：

  (defun demo (x)
    (message "开始计算")
    (* x x))

  调用：

  (demo 4)

  执行过程：

  1. 先显示 "开始计算"
  2. 再计算 (* x x)
  3. 返回 16

  也就是说，message 不是最终返回值，最后那一行才是。

  ## 4. 可选参数

  如果参数可以不传，用 &optional：

  (defun greet2 (name &optional title)
    (if title
        (concat title " " name)
      (concat "你好，" name)))

  调用：

  (greet2 "Tom")
  (greet2 "Tom" "Mr.")

  ## 5. 不定数量参数

  如果参数个数不固定，用 &rest(意思是剩余参数)：

```lisp
  (defun show-args (&rest args)
    args)
```

  调用：

  (show-args 1 2 3)

  返回：

  (1 2 3)

  这里 args 会收到一个列表。

  ## 6. 你现在最该记住的三点

  - 用 defun 定义函数
  - 参数写在函数名后面的括号里
  - 最后一个表达式的值就是返回值

  比如这个例子最完整也最实用：

  (defun multiply (a b)
    "返回 a 和 b 的乘积。"
    (* a b))

  调用：

  (multiply 6 7)

  返回：

  42





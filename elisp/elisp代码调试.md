
› elisp 常用的代码调试手段

• 我按“最常用、最值得先学”的顺序整理一下 Elisp 调试手段，重点说清楚各自适合什么场景。

• Elisp 常用的调试手段，按实用性排序，我建议你先掌握这几个。

  ## 1. message

  最简单、最常用，类似“打印调试”。

  (defun demo (x)
    (message "x = %S" x)
    (+ x 1))

  适合：

  - 看变量值
  - 看代码有没有执行到某一行
  - 快速排查流程

  输出会出现在 echo area 和 *Messages* buffer。

  ———

  ## 2. debug-on-error

  出错时自动进入调试器，这个非常有用。

  开启：

  (setq debug-on-error t)

  或者直接：

  M-x toggle-debug-on-error

  效果：

  - 代码一报错，Emacs 会弹出 backtrace
  - 你能看到调用栈、错误位置、函数链路

  适合：

  - 程序直接报错
  - 想知道“是谁调用到了这里”

  ———

  ## 3. debug 断点

  你可以在代码里手动放一个断点：

  (defun demo (x)
    (debug)
    (+ x 1))

  执行到这里时会进入调试器。

  适合：

  - 你想在某个具体位置停下来
  - 观察当时的上下文

  ———

  ## 4. edebug

  这是 Elisp 很强的单步调试工具。

  先把函数“插桩”：

  - 把光标放在 defun 上
  - 执行 M-x edebug-defun

  然后调用这个函数，就会进入逐步调试。

  你可以：

  - 单步执行
  - 进入子表达式
  - 查看表达式求值过程

  适合：

  - 想精细看每一步怎么跑
  - 复杂函数逻辑不容易靠 message 看清

  这是 Elisp 里最像传统 IDE 调试器的东西。

  ———

  ## 5. trace-function

  用来跟踪函数调用。

  (trace-function 'my-func)

  之后每次调用 my-func，都会记录调用信息。
  取消跟踪：

  (untrace-function 'my-func)

  适合：

  - 想知道某个函数有没有被调用
  - 想看它被调用了几次
  - 想看参数和返回值

  ———

  ## 6. eval-last-sexp / eval-expression

  这类适合“局部试验”。

  - C-x C-e
    计算光标前一个表达式
  - M-:
    执行任意 Elisp 表达式

  例如：

  (+ 1 2)

  把光标放在右括号后面按 C-x C-e，就能立刻看到结果。

  适合：

  - 小范围验证表达式
  - 试探变量值、函数结果

  ———

  ## 7. 看 backtrace

  如果已经进入 debugger，最重要的是看 backtrace。

  它能回答：

  - 哪个函数报错了
  - 是谁调用它的
  - 错误是沿着什么调用链传上来的

  初学时不用试图一次全看懂，但至少先看：

  - 最上面的报错信息
  - 你自己写的函数名
  - 调用路径里最接近你代码的位置

  ———

  ## 8. 宏相关：macroexpand-1

  如果你在调宏，这个非常重要。

  (macroexpand-1
   '(when t
      (message "A")))

  它能让你先看“宏展开后到底变成了什么代码”。

  适合：

  - 调试宏
  - 看 when、cond、自定义宏的展开结果

  ———

  ## 9. pp / pp-eval-expression

  当结果比较复杂时，用 pretty print 更容易看。

  例如：

  (pp some-large-list)

  或者：

  M-x pp-eval-expression

  适合：

  - 看复杂列表、alist、plist、嵌套结构
  - 比 message 更清晰

  ———

  ## 10. debug-on-quit

  这个对死循环很有用。

  开启：

  (setq debug-on-quit t)

  如果程序卡住，你按 C-g，Emacs 会尝试进入调试器。

  适合：

  - 怀疑死循环
  - 代码卡住不动
  - 想知道卡在哪个函数里

  ———

  ## 我最建议你先学会的 4 个

  如果你现在是入门阶段，先掌握这四个就够了：

  - message
  - M-x toggle-debug-on-error
  - C-x C-e / M-:
  - M-x edebug-defun

  这四个已经能解决大部分学习期问题。

  ## 一个很实用的调试流程

  你以后可以按这个顺序排查：

  1. 先加 message 看变量和流程
  2. 如果直接报错，打开 debug-on-error
  3. 如果逻辑复杂，改用 edebug
  4. 如果怀疑某个函数被偷偷调用，用 trace-function

  如果你愿意，我下一步可以给你一个“带 bug 的小 Elisp 函数”，演示这几种调试手段分别怎么用。









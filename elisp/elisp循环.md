› elisp 循环语句


• 我按最常用的几种写法介绍：先讲 while、dolist、dotimes，这三种基本覆盖入门阶段的大部分循环需求。

• Elisp 里常见的循环写法主要有这几种：

  - while
  - dolist
  - dotimes

  如果你是入门，先掌握这三个就够了。

  ## 1. while

  这是最基础的循环。

  (while 条件
    循环体...)

  例子：

  (setq i 0)

  (while (< i 5)
    (message "i = %d" i)
    (setq i (1+ i)))

  执行过程是：

  - 先判断 (< i 5)
  - 条件为真就执行循环体
  - 每次把 i 加 1
  - 直到条件为假结束

  这里的 1+ 表示“加 1”。

  ———

  ## 2. dolist

  用于遍历列表，非常常用。

  (dolist (变量 列表)
    循环体...)

  例子：

  (dolist (x '(10 20 30))
    (message "x = %d" x))

  这里会依次让：

  - x = 10
  - x = 20
  - x = 30

  如果你要处理列表，通常 dolist 比手写 while 更方便。

  ———

  ## 3. dotimes

  用于按次数循环。

  (dotimes (变量 次数)
    循环体...)

  例子：

  (dotimes (i 5)
    (message "i = %d" i))

  这里 i 会依次是：

  - 0
  - 1
  - 2
  - 3
  - 4

  也就是说，循环 5 次，但从 0 开始。

  ———

  ## 4. 带返回值的形式

  ### dolist

  它还可以写返回值：

  (dolist (x '(1 2 3) "done")
    (message "%d" x))

  循环结束后返回 "done"。

  ### dotimes

  也一样：

  (dotimes (i 3 "finished")
    (message "%d" i))

  结束后返回 "finished"。

  ———

  ## 5. 一个稍微完整点的例子

  求列表元素之和：

  (setq sum 0)

  (dolist (x '(1 2 3 4))
    (setq sum (+ sum x)))

  sum
  ;; => 10

  ———

  ## 6. cl-loop

  Elisp 还有一个更强大的循环工具 cl-loop，但初学阶段可以先不学。

  例如：

  (require 'cl-lib)

  (cl-loop for x in '(1 2 3)
           do (message "%d" x))

  它很强，但语法相对多一些。先把 while、dolist、dotimes 学会更重要。

  ———

  ## 7. 你现在先记住怎么选

  - 条件循环：while
  - 遍历列表：dolist
  - 固定次数：dotimes

  比如：

  (defun print-numbers ()
    (dotimes (i 5)
      (message "数字: %d" i)))

  如果你愿意，我下一步可以继续讲：

  - 如何在循环里提前结束
  - 如何跳过本次循环
  - 如何一边循环一边收集结果



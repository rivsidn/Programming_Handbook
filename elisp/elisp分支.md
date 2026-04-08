
## if

### 原型

```lisp
(if COND THEN ELSE...)
```

`THEN` 只能有一条表达式，`ELSE` 可以有 0 条或者多条表达式。

### 示例

```lisp
(if t
    (progn
      (message "第一条输出")
      (message "第二条输出")
      (message "第三条输出")))
```

由于`THEN` 只能有多条表达式，所以这里如果需要执行多条表达式，需要通过`progn` 连起来。



## 附录

### AI

#### elisp 分支语句

• 我按入门最常用的几种分支形式来讲，先讲 if、when、unless、cond，这些基本够你写大多数 Elisp 代码了。

• Elisp 里最常见的分支语句是这几个：

  - if
  - when
  - unless
  - cond

  先记一个总规则：

  在 Elisp 里，只有 nil 表示假，其他值都表示真。

  ## if

  最基本的条件分支。

  (if 条件
      条件为真时的表达式
    条件为假时的表达式)

  例子：

  (if (> 3 2)
      (message "yes")
    (message "no"))

  如果只写真分支，也可以：

  (if (> 3 2)
      (message "yes"))

  注意：if 的每个分支默认只放一个表达式。
  如果某个分支要执行多条语句，要用 progn：

  (if (> 3 2)
      (progn
        (message "A")
        (message "B"))
    (message "no"))

  ———

  ## when

  表示“当条件为真时执行”，相当于简化版 if。
  仅仅一个分支，两条语句。

  (when 条件
    表达式1
    表达式2
    ...)

  例子：

  (when (> 3 2)
    (message "A")
    (message "B"))

  它大致相当于：

  (if (> 3 2)
      (progn
        (message "A")
        (message "B")))

  ———

  ## unless

  表示“除非条件为真，否则执行”，也就是“条件为假时执行”。

  (unless 条件
    表达式1
    表达式2
    ...)

  例子：

  (unless (= 1 2)
    (message "不相等"))

  它大致相当于：

  (if (= 1 2)
      nil
    (progn
      (message "不相等")))

  ———

  ## cond

  用于多分支判断，类似“if / else if / else”。

  (cond
   ((条件1) 表达式1 表达式2 ...)
   ((条件2) 表达式1 表达式2 ...)
   (t 默认分支表达式1 表达式2 ...))

  例子：

  (setq score 85)

  (cond
   ((>= score 90) (message "优秀"))
   ((>= score 80) (message "良好"))
   ((>= score 60) (message "及格"))
   (t (message "不及格")))

  这里 t 相当于默认分支。

  ———

  ## 返回值

  这些分支表达式本身都有返回值，通常是“最后一个表达式的值”。

  例如：

  (setq x
        (if (> 3 2)
            100
          200))

  这里 x 会得到 100。

  ———

  ## 你现在最该先掌握的用法

  - 两选一：用 if
  - 只有“满足条件才执行”：用 when
  - 只有“条件不满足才执行”：用 unless
  - 多个条件分支：用 cond

  比如这个小例子：

  (defun grade-level (score)
    (cond
     ((>= score 90) "A")
     ((>= score 80) "B")
     ((>= score 60) "C")
     (t "D")))

  如果你愿意，我下一步可以继续讲：

  - if、when、cond 的返回值区别
  - and / or 这种也带“短路分支”效果的表达式







› elisp 如何定义链表，如何向链表中添加变量

• 在 Elisp 里，通常说的“链表”就是 Lisp 的 list，本质上是由 cons cell 串起来的单链表。

  定义链表

  最常见的方式：

  (setq my-list '(1 2 3))

  或者：

  (setq my-list (list 1 2 3))

  这两个效果基本一样，my-list 的值都是一个链表。

  你也可以直接用 cons 一步步构造：

  (setq my-list (cons 1 (cons 2 (cons 3 nil))))

  这里的 nil 表示链表尾部。

  向链表添加元素

  最常用的是加到表头：

  (push 4 my-list)

  执行后，my-list 变成：

  (4 1 2 3)

  这相当于：

  (setq my-list (cons 4 my-list))

  如果你想加到表尾，可以写：

  (setq my-list (append my-list (list 4)))

  执行后得到：

  (1 2 3 4)

  不过要注意，append 通常会复制前面的链表部分，所以频繁尾插不如头插自然高效。

  如果是“添加变量的值”

  比如：

  (setq x 42)
  (push x my-list)

  那么是把变量 x 当前的值 42 放进列表，不是把“变量名 x”本身放进去。

  结果类似：

  (42 1 2 3)

  如果是“添加变量名这个符号”

  那要 quote：

  (push 'x my-list)

  这样加进去的是符号 x，不是变量 x 的值。

  **符号可以理解成指针，并不是单纯的数值，这样。**

  空链表怎么开始

  (setq my-list nil)
  (push 1 my-list)
  (push 2 my-list)

  最后：

  (2 1)

  补充
  如果你想“只有不存在时才添加”，可以用：

  (add-to-list 'my-list 1)

  但它更适合配置变量；一般构造普通列表时，更常用 push 或 cons。

  如果你愿意，我可以继续画一下 cons cell 的结构图，解释为什么说 Elisp 的 list 本质上是单链表。


  1. 删除某个元素，通常用 delete

  (setq my-list '(1 2 3 2 4))
  (setq my-list (delete 2 my-list))

  结果：

  (1 3 4)

  delete 会把所有等于 2 的元素删掉。

  注意一般要写回变量：

  (setq my-list (delete 2 my-list))

  2. 非破坏式地删除，可用 remove

  (setq my-list '(1 2 3 2 4))
  (setq new-list (remove 2 my-list))

  结果：

  new-list => (1 3 4)
  my-list   => 仍然可能保持原值

  区别是：

  - delete 可能直接修改原链表结构
  - remove 会返回一个新列表

  删除表头

  如果只是删除第一个元素，可以直接取 cdr：

  (setq my-list '(1 2 3))
  (setq my-list (cdr my-list))

  结果：

  (2 3)

  删除整个链表

  如果你是想“清空这个链表变量”，直接：

  (setq my-list nil)

  这表示变量不再指向原来的列表。

  如果是 association list / plist，不同函数会更合适
  比如 alist 可以用 assq-delete-all、assoc-delete-all 等。

  一句话总结

  - 删除某个元素：常用 (setq my-list (delete x my-list))
  - 非破坏式删除：常用 (setq my-list (remove x my-list))
  - 删除第一个元素：(setq my-list (cdr my-list))
  - 清空整个链表：(setq my-list nil)




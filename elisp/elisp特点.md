
1. 代码就是列表
   Elisp 的代码本身就是 Lisp 列表，写法是前缀形式：

(+ 1 2)
(message "hello")

这和很多语言的 1 + 2 不一样。
你会经常看到一堆括号，但它的规则其实很统一：(函数 参数1 参数2 ...)

2. 语法很少，靠数据结构表达程序
   Elisp 的核心数据结构很简单，最常见的是：

- 数字
- 字符串
- 符号
- 列表

比如：

(setq name "Tom")
(setq nums '(1 2 3))

这使得语言本身“语法负担小”，很多能力是通过列表和函数组合出来的。

3. 可以一边写一边执行
   这是 Elisp 很有特色的一点。你不用总是“写完再整体运行”，而是可以随时在 Emacs 里执行一小段代码：

- M-:
  执行一条表达式
- C-x C-e
  执行光标前的表达式
- M-x eval-buffer
  执行整个 buffer

这让它特别适合边学边试。

4. 和 Emacs 本体结合得非常紧
   Elisp 不只是“能写程序”，它主要是用来控制和扩展 Emacs 的。
   你可以直接操作：

- buffer
- window
- point（光标位置）
- mode
- hook
- keybinding

比如：

(message "当前 buffer 是: %s" (buffer-name))

这也是为什么学 Elisp 时，会感觉它既像编程语言，又像 Emacs 的控制接口。

5. 函数和命令关系很近
   普通函数可以很容易变成可交互命令：

(defun hello-demo ()
  (interactive)
  (message "hello"))

加了 (interactive) 之后，就可以用 M-x hello-demo 运行。
这点非常适合给自己写小工具。

6. 宏很强大
   Elisp 支持宏，也就是“生成代码的代码”。
   你现在不用马上深入，但以后会发现很多看起来像语法的东西，其实是宏。

比如常见的：

(when t
  (message "ok"))

when 就是宏，不是普通函数。

7. 作用域有历史包袱
   这是 Elisp 一个需要特别注意的特点：它同时涉及动态作用域和词法作用域。
   现代 Elisp 一般推荐用词法作用域，也就是在文件头加：

;;; -*- lexical-binding: t; -*-

初学时你可以先记住一句话：
新代码尽量用 lexical binding。

8. 自带很强的自省和帮助系统
   Elisp 的文档体验很好，你可以直接在 Emacs 里查：

- C-h f 查函数
- C-h v 查变量
- C-h k 查按键
- C-h o 查 symbol

学习时这比单纯看网页教程更高效。

如果只总结成一句话：Elisp 是一门语法很小、交互性很强、专门用来扩展 Emacs 的 Lisp。

如果你愿意，我下一步可以继续给你讲这几个里最关键的三项：

1. 列表和符号
2. setq、let、defun
3. interactive 和 message

这三个学会之后，就能开始自己写简单 Elisp 了。

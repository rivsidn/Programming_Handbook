
› 一个 elisp 文件如何调用另一个文件的函数呢？


• 我直接用最常见的两种方式说明：临时加载用 load-file，正式组织多个文件通常用 provide / require。

• 可以，最常见有两种方式。

  ## 1. 最直接：load-file

  假设有两个文件。

  a.el：

  (defun hello-demo ()
    (message "你好，来自 a.el"))

  b.el：

  (load-file "/绝对路径/a.el")

  (hello-demo)

  执行 b.el 时，先加载 a.el，然后就可以调用 a.el 里的函数了。

  这种方式适合初学时测试，但平时写项目不太优雅，因为路径常常写死。

  ———

  ## 2. 更常用：provide / require

  这是更标准的模块化写法。

  a.el：

  (defun hello-demo ()
    (message "你好，来自 a.el"))

  (provide 'a)

  b.el：

  (require 'a)

  (hello-demo)

  这里的意思是：

  - a.el 结尾用 (provide 'a) 表示“我提供模块 a”
  - b.el 用 (require 'a) 表示“我要加载模块 a”

  ———

  ## 3. require 为什么有时找不到文件

  因为 require 不是直接按文件路径找，它会去 load-path 里查找 a.el 或编译后的 a.elc。

  你可以把文件所在目录加入 load-path：

  (add-to-list 'load-path "/你的目录/")
  (require 'a)

  例如：

  (add-to-list 'load-path "/home/yuchao/test-elisp/")
  (require 'a)
  (hello-demo)

  ———

  ## 4. 文件名和模块名的关系

  通常约定：

  - 文件名：a.el
  - provide 名：a
  - require 名：a

  例如：

  (provide 'my-utils)
  (require 'my-utils)

  对应文件一般叫 my-utils.el。

  ———

  ## 5. 你现在最实用的记法

  如果只是练习，先用：

  (load-file "/path/to/a.el")

  如果想正式一点，使用：

  ;; a.el
  (provide 'a)

  ;; b.el
  (require 'a)

  再确保 a.el 所在目录在 load-path 中。

  ———

  ## 6. 一个完整可运行的小例子

  a.el：

  (defun add-demo (a b)
    (+ a b))

  (provide 'a)

  b.el：

  (add-to-list 'load-path "/home/yuchao/test-elisp/")
  (require 'a)

  (message "结果: %d" (add-demo 3 4))

  执行 b.el 后，会输出：

  结果: 7

  如果你愿意，我下一步可以继续讲：

  1. load-file、load、require 三者区别
  2. 如何在同一个目录下更方便地加载另一个 .el 文件




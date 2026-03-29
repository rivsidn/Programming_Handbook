
- 普通解释执行的 Lisp 函数
- byte-code-function：字节码函数
- native-comp-function：经过 native-comp 的本地编译函数
- subr：C 实现的内建函数



- 直接 eval-buffer、load-file 一个 .el 文件：通常得到的是普通 Lisp 函数
- load 一个 .elc 文件：通常得到的是 byte-code-function
- load 一个 native 编译产物（对应 .eln）：通常得到的是 native-comp-function

也就是说，加载了什么产物，基本就决定了函数最终是什么形式。



› 如何将.el 文件编译成 .elc .eln 呢？是否所有的.el 文件都可以编译成.elc .eln


• 可以。

  编译成 .elc

  这是 byte-compile，最常见。

  在 Emacs 里：

  (byte-compile-file "/path/to/foo.el")

  会生成：

  /path/to/foo.elc

  命令行也可以：

  emacs -Q --batch -f batch-byte-compile /path/to/foo.el

  编译成 .eln

  这是 native compilation。前提是你的 Emacs 编译时启用了 native-comp。

  在 Emacs 里可以用：

  (native-compile "/path/to/foo.el")

  或者对已经生成的 .elc 做 native 编译：

  (native-compile "/path/to/foo.elc")

  命令行示例：

  emacs -Q --batch --eval '(native-compile "/path/to/foo.el")'

  .eln 通常不会直接放在原目录，而是放到 Emacs 的 native comp cache 目录里，不一定和 .el 挨着。

  是不是所有 .el 都能编译成 .elc？

  不是绝对“所有”，但绝大多数正常的 Elisp 文件都可以 byte-compile 成 .elc。

  不能顺利编译的常见原因：

  - 文件里有语法错误
  - 宏或依赖在编译时不可用
  - 编译期就会执行的代码出错
  - 有些代码动态性太强，会产生警告，少数情况下会导致编译失败

  所以更准确地说：

  - 不是所有 .el 都一定能成功编译
  - 但大部分合法、依赖齐全的 .el 都可以编译成 .elc

  是不是所有 .el 都能编译成 .eln？

  也不是。

  .eln 比 .elc 要求更多，因为它依赖：

  - Emacs 支持 native-comp
  - 系统有对应工具链
  - 代码本身能先被正常处理/编译

  通常流程上可以理解为：

  - 先能 byte-compile
  - 然后 native-comp 再把它进一步编译成本地代码

  有些 .el 能生成 .elc，但 native 编译阶段可能失败或被跳过。

  实际建议

  如果你只是想“编译 Elisp 包”：

  1. 先做 byte-compile，确保能生成 .elc
  2. 如果你的 Emacs 支持 native-comp，再看是否自动或手动生成 .eln

  补充一点

  很多时候你不需要手动生成 .eln：

  - 安装包后，Emacs 可能会后台自动 native compile
  - 所以你只看到源文件和 .elc，但函数帮助里已经显示 native-comp-function

  如果你愿意，我可以继续给你讲一下：

  1. .elc 和 .eln 分别通常放在哪
  2. 怎么检查当前 Emacs 是否支持 native-comp
  3. 怎么批量编译一个目录下的 .el 文件





  一句话结论
  不是都要手动，也不是都会自动：

  - .elc 通常要手动编译或由安装流程编译
  - .eln 在支持 native-comp 时经常会自动后台生成



  一句话
  编译成 .elc 之后，Elisp 代码里的 require 用法完全一样，不需要改。




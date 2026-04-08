

代码规范.

https://github.com/bbatsov/emacs-lisp-style-guide



## 附录

### AI

#### 代码规范

• 有，但没有一个像 PEP8 那样单页、唯一的 Elisp 官方规范。
  对 Emacs Lisp 来说，最接近“标准”的是 GNU 官方文档的几章组合。

  你可以按这个顺序学：

  - 官方总入口：GNU Emacs Manual: Coding Standards (https://www.gnu.org/software/emacs/manual/html_node/emacs/Coding-Standards.html)
    这里直接说了：贡献给 Emacs 的代码要遵循 GNU Coding Standards，并额外参考 Elisp 手册里的 Tips and Conventions。
  - 最核心的 Elisp 规范：Emacs Lisp Reference: Coding Conventions (https://www.gnu.org/software/emacs/manual/html_node/elisp/Coding-Conventions.html)
    这里讲命名前缀、lexical-binding、provide/require、默认缩进、UTF-8、谓词函数以 p 结尾等。这个最值得先读。
  - 包/库文件头规范：Conventional Headers for Emacs Libraries (https://www.gnu.org/software/emacs/manual/html_node/elisp/Library-Headers.html)
    学 ;;; foo.el --- ... -*- lexical-binding: t; -*-、Package-Requires、;;; Commentary:、;;; Code: 这些。
  - 如果你要写 mode：
    Major Mode Conventions (https://www.gnu.org/software/emacs/manual/html_node/elisp/Major-Mode-Conventions.html)
    Minor Mode Conventions (https://www.gnu.org/software/emacs/manual/html_node/elisp/Minor-Mode-Conventions.html)
  - 文档字符串写法：Documentation Tips (https://www.gnu.org/software/emacs/manual/html_node/elisp/Documentation-Tips.html)

  社区里最常被引用的补充资料是：

  - bbatsov/emacs-lisp-style-guide (https://github.com/bbatsov/emacs-lisp-style-guide)
    这是社区风格指南，很实用，但它不是 GNU 官方标准。

  平时配合工具一起学效果最好：

  - 内置 M-x checkdoc
  - 发包前用 package-lint (https://elpa.nongnu.org/nongnu/package-lint.html)




• 按 Emacs 30.1 的常规启动流程，和你自己写配置最相关的加载顺序大致是：

  1. 先加载 Emacs 预加载的内建 Lisp
  2. 加载 early-init.el
  3. 自动激活已安装包
     前提是 package-enable-at-startup 不为 nil
  4. 运行 before-init-hook
  5. 加载站点级启动文件 site-start.el
     有些发行版还会插入自己的启动片段
  6. 加载用户初始化文件
     一般是 ~/.emacs、~/.emacs.d/init.el，或 ~/.config/emacs/init.el
  7. 加载 default.el
     如果存在且没有被禁止
  8. 读取 abbrev 文件
     如果你配置了并且文件存在
  9. 运行 after-init-hook
  10. 处理剩余命令行参数
     比如 --eval、-l file、打开文件
  11. 运行 emacs-startup-hook
  12. 运行 window-setup-hook

  最容易记混的几点是：

  - early-init.el 比 init.el 更早，而且在包自动激活之前
  - site-start.el 在用户 init.el 之前
  - after-init-hook 在 init.el、default.el、abbrev 文件之后
  - emacs-startup-hook 比 after-init-hook 更晚，因为它是在命令行参数处理之后
  - window-setup-hook 又比 emacs-startup-hook 更晚一点，适合依赖窗口参数已经稳定的代码

  如果你是想知道“代码该放哪”：

  - 想在包初始化前执行：放 early-init.el
  - 普通配置：放 init.el
  - 想在初始化全部结束后执行：放 after-init-hook
  - 想等窗口布局和 frame 参数稳定后再执行：放 window-setup-hook

  还有一个很容易踩坑的点：

  - custom-file 不是一个固定自动加载阶段
  - 默认情况下，Customize 直接把内容写到你的 init.el
  - 如果你把 custom-file 设成单独文件，需要你自己在 init.el 里手动 load，它的加载时机就取决于你把这行 load 写在什么位置

  如果你愿意，我可以下一步给你画一个更直观的“Emacs 启动加载时序图”。


› 有没有办法查看加载了哪些source file 啊

• 有，而且 最实用的是 load-history。

  你如果想看“当前这个 Emacs 会话已经加载了哪些文件”，直接执行：

  (mapcar #'car load-history)

  因为 load-history 里通常是“最近加载的在前面”，如果你想按启动先后顺序看：

  (reverse (delq nil (mapcar #'car load-history)))

  也可以直接：

  M-x describe-variable RET load-history RET

  load-history 不只是记录文件名，还记录这个文件定义了哪些函数、变量、provide 了哪些 feature。

  补充一点：这里看到的通常是实际加载的文件，所以很多时候会是 .elc 或 .eln，不一定是 .el 源文件。

  如果你想看“某个函数是从哪个文件来的”，用这个更直接：

  (symbol-file 'find-file 'defun)

  比如查你自己的函数：

  (symbol-file 'hello-demo 'defun)

  如果你想看“启动时按顺序到底加载了什么”，可以在 early-init.el 里临时加一段追踪：

  (defvar my-startup-load-log nil)

  (defun my-trace-load (orig file &rest args)
    (let ((before load-history)
          ret)
      (setq ret (apply orig file args))
      (unless (eq before load-history)
        (push (caar load-history) my-startup-load-log)
        (message "Loaded: %s" (caar load-history)))
      ret))

  (advice-add 'load :around #'my-trace-load)

  这样启动时 *Messages* 里就会看到加载记录。启动完成后再看：

  (reverse my-startup-load-log)

  另外，C-h e 打开 *Messages*，有时也能直接看到很多 Loading ... 日志，不过它没有 load-history 那么结构化。

  如果你愿意，我可以继续给你一个“专门查看 Emacs 启动加载顺序”的完整小工具脚本。



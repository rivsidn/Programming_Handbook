
  (define-key global-map (kbd "C-c a") #'beginning-of-line)

  意思是：在全局按键表 global-map 中，把 C-c a 绑定到 beginning-of-line 这个命令。

  This is a legacy function; see ‘keymap-set’ for the recommended function to use instead.
  意思是：define-key 还可以用，但它属于旧写法。
  现在 Emacs 更推荐你用 keymap-set。

  对应的新写法通常像这样：

  (keymap-set global-map "C-c a" #'beginning-of-line)



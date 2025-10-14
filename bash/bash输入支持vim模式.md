
`bashrc` 中设置.

```bash
# 开启vim 模式
set -o vi

# 显示vim mode 提示
bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\033[01;32m[I]\033[01;00m"'
bind 'set vi-cmd-mode-string "\033[01;32m[N]\033[01;00m"'

# jk 映射成ESC
bind -m vi-insert '"jk": vi-movement-mode'

```

**Tips: normal 模式下输入 v 可以开启vim 编辑，然后执行编辑后的命令.**


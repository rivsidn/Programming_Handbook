
## 选项设置

| 命令行               | 说明                       |
|----------------------|----------------------------|
| set -o               | 查看当前选项               |
| set +o               | 显示当前所有选项设置的命令 |
| set -o <option-name> | 选项设置                   |
| set +o <option-name> | 取消选项设置               |


## 选项配置

设置具体选项之后，可以修改选项默认配置.

### emacs

执行`Ctrl+x`+`Ctrl+e` 可以进入命令行编辑界面.

```bash
export EDITOR=nvim
```
编辑器设置为 nvim.

### vi

由于vi 模式先总是导致命令行乱码，所以不再使用该模式.

```bash
set -o vi

bind 'set show-mode-in-prompt on'
bind 'set vi-ins-mode-string "\033[01;32m[I]\033[01;00m"'
bind 'set vi-cmd-mode-string "\033[01;32m[N]\033[01;00m"'
bind -m vi-insert '"jk": vi-movement-mode'
```

启动并配置vi 模式.


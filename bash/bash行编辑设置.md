`Bash` 行编辑功能，详细信息可以参见`Bash Reference Manual` 第八章 行编辑。

`Bash` 支持两种行编辑模式，`Vim` `Emacs` ，其中默认为`Emacs` 模式，我们可以通过设置，修改成`Vim` 模式。



### 配置

修改配置文件`/etc/inputrc`

```bash
# 设置编辑模式为vi
set editing-mode vi

$if mode=emacs

# emcas 默认设置

$else

# 映射control-j 为ESC
# version 4.4.20(1)-release 中出现情况是输入control-j后模式字符串并不立即改变，设置为"\e "后正常
# version 5.0.17(1)-release 中正常
"\C-j": "\e"

# 显示输入模式提示信息
set show-mode-in-prompt on
# vim insert模式提示字符串，确保和当前PS1中颜色一致
set vi-ins-mode-string \1\033[01;32m\2I_
# vim command模式提示字符串
set vi-cmd-mode-string \1\033[01;32m\2C_

$endif
```



### 使用

配置之后重新开启终端即可以使设置生效，可以在终端中使用`vim` 编辑命令。



**Tips:**

* `cmd` 模式下输入 v 会进入`vim` 中，保存退出执行`vim` 中输入的命令。



### 参考资料

* Bash Reference Manual Chapter 8 Command Line Editing




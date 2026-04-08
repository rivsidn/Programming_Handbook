
## 示例程序

示例程序 [demo.el](samples/demo.el).

这个示例做了什么

- defun：定义函数
- message：把结果显示在 Emacs 底部回显区

## 函数执行

### Emacs 内部执行

打开

```
M-x eval-buffer
```

### 内部执行单条语句

| 快捷键  | 说明         |
|---------|--------------|
| C-x C-e | 执行单条语句 |

### Terminal 执行

```bash
emacs --script demo.el
```


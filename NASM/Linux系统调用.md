
## Linux系统调用

主要介绍Linux 下 `x86_64` 系统调用.

### 参数传递规则

| 寄存器 | 说明                    |
|--------|-------------------------|
| rax    | 系统调用号              |
| rdi    | 参数0                   |
| rsi    | 参数1                   |
| rdx    | 参数2                   |
| r10    | 参数3(调用c时设置为rcx) |
| r8     | 参数4                   |
| r9     | 参数5                   |

### 系统调用号

```bash
$ sudo apt install auditd
$ ausyscall --dump
Using x86_64 syscall table:
0	read
1	write
2	open
3	close
4	stat
5	fstat
6	lstat
7	poll
8	lseek
9	mmap
10	mprotect
...

```

### 系统调用参数

系统调用参数可以查看具体的man 2 手册，如查询`exit` 参数，可以执行:

```bash
man 2 exit
```

## 附录

### 参考资料

* syscall(2) man 手册


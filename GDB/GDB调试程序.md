# GDB调试程序

## 功能整理

### 添加断点

### GDB布局

| 命令         | 说明                     |
|--------------|--------------------------|
| layout src   | 显示源代码窗口           |
| layout asm   | 显示汇编代码窗口         |
| layout split | 显示源代码、汇编代码窗口 |
| C-x o        | 切换活跃窗口             |
| C-x a        | 恢复默认布局             |



## 调试示例

### 设置源码路径

由于编译环境变化(代码路径修改)，导致`gdb` 调试时找不到对应的源码文件，需要在
`gdb`中重新设置。

```gdb
# 进入源代码函数之后，查看编译路径
(gdb) info source
Current source file is ../../../glib/gmain.c
Compilation directory is /usr/src/glib2.0-2.82.1-0ubuntu1/debian/build/deb
Source language is c.
Producer is GNU GIMPLE 14.2.0 -mno-omit-leaf-frame-pointer -mtune=generic -march=x86-64 -g -g -O2 -O2 -fno-openmp -fno-openacc -fcf-protection=full -fasynchronous-unwind-tables -fPIC -fno-omit-frame-pointer -ffat-lto-objects -fstack-protector-strong -fstack-clash-protection -fcf-protection=full -foffload-options=-l_GCC_m -fltrans.
Compiled with DWARF 5 debugging format.
Does not include preprocessor macro info.

# 路径替换
# 如上所示，编译路径为/usr/src/glib2.0-2.82.1-0ubuntu1/debian/build/deb，
# 但实际上该路径在本地并不存在，需要依照本地实际路径重新设置
(gdb) set substitute-path /usr/src/glib2.0-2.82.1-0ubuntu1/debian/build/deb /home/yuchao/source_code/glib/glib-2.82.1/_build/deb/gdb_source_mark

# 确认修改成功
(gdb) show substitute-path
List of all source path substitution rules:
  `/usr/src/glib2.0-2.82.1-0ubuntu1/debian/build/deb' -> `/home/yuchao/source_code/glib/glib-2.82.1/_build/deb/gdb_source_mark'.
```

### 调试汇编指令

通过gdb调试汇编指令.

| 指令          | 说明                                                      |
|---------------|-----------------------------------------------------------|
| layout asm    | 打开汇编视图                                              |
| si            | 单步执行一条汇编指令(stepi), 遇到函数会跳转到函数内部执行 |
| ni            | 单步执行一条汇编指令(nexti)，遇到函数不进入函数内部       |
| break *0xFFFF | 在某条具体的汇编指令处下断点                              |

### 查看数据结构定义

```gdb
# 查看数据类型
(gdb) ptype *current
# 查看结构体定义
(gdb) ptype struct task_struct
```




# TODO-待整理

### break, brea, bre, br, b

添加断点。

### 添加条件断点

* 方法一 - 直接添加条件

  类似：

  ```gdb
  (gdb) break <function_name> if $i == 1
  ```

* 方法二 - 使用`condition` 添加条件

  * 添加断点

    ```gdb
    (gdb) break <function_name>
    ```

  * 添加条件

    ```gdb
    (gdb) condition <breakpoint_number> $i == 1
    ```

### 添加命令

```gdb
(gdb) commands <breakpoint_number>
> ...
> end
```



## tbreak

添加断点，断点执行一次后就删除。



## info

| 命令                      | 说明               |
| ------------------------- | ------------------ |
| info functions \<REGEXP\> | 输出匹配的函数     |
| info line                 | 查看当前执行所在行 |





## show

| 命令          | 说明               |
| ------------- | ------------------ |
| show commands | 显示最近执行的命令 |







## 调试命令

| 调试命令 | 说明                   |
| -------- | ---------------------- |
|          |                        |
| list     | 显示C 代码             |
|          |                        |
|          |                        |
|          |                        |
| watch    | 监控内存区域是否被修改 |
|          |                        |



## 查看命令

| 查看命令  | 说明                     |
| --------- | ------------------------ |
| info args | 查看函数参数             |
|           |                          |
| info line | 查看当前执行的文件、行号 |
|           |                          |

















## 附录

### TODO

* 如何调试程序的动态链接过程？




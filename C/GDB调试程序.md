# GDB调试程序

## break, brea, bre, br, b

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




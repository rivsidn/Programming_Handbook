* 简单命令
* 符合命令
  * 管道
  * 循环
  * 条件结构

关键字用于，开始或者结束复合命令。



## 简单命令

由控制操作符结束。



## 管道

```bash
[time [-p]] [!] command1 [ | or |& command2 ] ...
```



> 1. This connection is performed before any redirections specified by the command.
> 2. This implicit redirection of the standard error to the standard output is performed after any redirections specified by the command.



## 命令列表

由于下边符号分割：

* ; 
* 换行
* &
* &&
* ||

由下边符号结束：

* ;
* 换行
* &



```bash
#! /bin/bash

# 下边命令发现，实际上两个echo命令是一个命令列表

echo "nihao" ||

echo "test"
```


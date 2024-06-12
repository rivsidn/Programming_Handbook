# 环境搭建

## 安装

```bash
# 安装tcl命令
sudo apt-get intall tcl
# 安装tcl man手册
sudo apt-get install tcl-doc
```

## 手册查询

```bash
# man手册查询，查询while命令
man 3tcl while
```

## 脚本运行

脚本运行有两种方式。

* 终端交互方式运行，执行`exit`退出

  ```tcl
  $ tclsh
  % puts "tcl running in interactive mode"
  tcl running in interactive mode
  % exit
  $
  ```

* 脚本方式运行

  ```tcl
  #! /usr/bin/tclsh
  
  puts "tcl running as a script"
  ```

  

# 语言基础

## 注释

* 行首注释

  ```tcl
  # 这是一行注释
  ```

* 行中注释

  ```tcl
  puts "comment example" ;# 这也是一行注释
  ```

  注释不在行首需要紧跟着分号。

## 变量设置

```tcl
#! /usr/bin/tclsh

# 变量设置
set fruit {Apple}
# 变量获取
puts ${fruit}
```



## 数据类型

### 链表

* 初始化

  ```tcl
  set lst {item1 item2 item3}
  
  set lst [list "item1" "item2" "item3"]
  
  set lst [split "item1.item2.item3"]
  
  ```

  

* 相关命令

  | 命令                                         | 说明                             |
  | -------------------------------------------- | -------------------------------- |
  | foreach varname list body                    | 遍历链表成员                     |
  |                                              |                                  |
  | lindex list index                            | 获取成员的值                     |
  | linsert listName index ?arg1 arg2?           | 插入到链表中，获取到一个新的链表 |
  |                                              |                                  |
  | list ?arg1? ?arg2?                           | 制造链表                         |
  | llength list                                 | 获取链表长度                     |
  | lreplace listName first last ?arg1 ... argn? | 替换链表中内容                   |
  | lset Varname index newValue                  | //TODO                           |
  | split string ?splitChars?                    | 将字符串分割成链表               |
  |                                              |                                  |

  





### 关联数组





# 附录

## TODO

* `tcl`中的展开






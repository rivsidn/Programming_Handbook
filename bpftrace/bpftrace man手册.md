## 语法

```bash
bpftrace [OPTIONS] FILENAME
bpftrace [OPTIONS] -e 'program code'
```



## 描述

`bpftrace`  是`Linux` 系统中基于BPF 的高级的跟踪语言，支持用户态、内核态跟踪，同时支持静态、动态跟踪功能。



## 示例

**显示所有名字中带有"sleep" 的追踪点**

```bash
# bpftrace -l "*sleep*"
```

<u>测试发现此时能够显示内核态`tracepoint` 和 `kprobe`</u>

**追踪调用了sleep 函数的进程**

```bash
# bpftrace -e 'kprobe:do_nanosleep { printf("%d sleeping\n", pid); }'
```

**执行子进程`sleep 5`的时候追踪调用了sleep 函数的进程**

```bash
# bpftrace -e 'kprobe:do_nanosleep { printf("%d sleeping\n", pid); }' -c 'sleep 5'
```

<u>现象是追踪5秒钟之后，结束追踪。</u>



## 支持架构

x86_64，arm64 and s390x



## 选项

### 输出选项

| 选项         | 解释                                                         |
| ------------ | ------------------------------------------------------------ |
| -B MODE      | 设置输出缓冲模式：<br />none 无缓冲<br />line 行缓冲<br />full 全缓冲 |
| -f FORMAT    | 设置输出格式，可用的格式为：<br />json<br />text             |
| -o FILENAME  | 追踪内容输出到文件中，该选项不包括子进程(-c 选项)的输出。<br />错误仍然被输出到标准错误。 |
| --no-warning | bpftrace告警抑制                                             |

### 追踪选项

| 选项               | 解释                                                         |
| ------------------ | ------------------------------------------------------------ |
| -e PROGRAM         | 执行程序而不是从文件中读取                                   |
| -I DIR             | 添加搜索头文件路径，该选项可以使用多次                       |
| --include FILENAME | 添加头文件到与处理中，可以使用多次                           |
| -l [SEARCH]        | 列出所有匹配 SEARCH 的观测点                                 |
| --unsafe           | 某些调用是不安全的，程序中默认不使能。<br />该选项可以允许我们使用这些调用。 |
| -k                 | 程序默认忽略bpf_helper(7)的错误，此处可能导致异常问题。<br />该选项使能这些异常的检测。 |
| -kk                | 使能`bpf_read_*` 的错误检测                                  |

### 进程管理

| 选项                   | 解释                                                       |
| ---------------------- | ---------------------------------------------------------- |
| -p PID                 | 绑定进程，进程结束时，bpftrace也会结束。                   |
| -c COMMAND             | 运行`COMMAND` 作为子进程，子进程结束时，bpftrace自动结束。 |
| --usdt-file-activation | 基于文件路径激活usdt 信号                                  |

### 其他

| 选项          | 解释                         |
| ------------- | ---------------------------- |
| --info        | 输出内核和bpftrace支持的特性 |
| -h, --help    | 输出帮助缩略信息             |
| -V, --version | 输出版本信息                 |
| -v            | 输出详细信息                 |
| -d            | 调试模式                     |
| -dd           | 详细调试模式                 |



## 环境变量

某些选项只能通过环境变量控制，该节列出这些选项。

| 选项                        | 默认值 | 解释                                                         |
| --------------------------- | ------ | ------------------------------------------------------------ |
| BPFTRACE_STRLEN             | 64     | str()返回的BPF栈中字符串的长度。<br />如果想要通过str() 获取更长的字符串的话，将这个数值设大。<br />注意BPF栈很小(512字节) |
| BPFTRACE_NO_CPP_DEMANGLE    | 0      | 追踪用户态栈的时候默认使能C++符号表解构。<br />该选项设置成1 时可以关闭该功能。 |
| BPFTRACE_MAP_KEYS_MAX       | 4096   | BPF map中可以存取key值的最大个数。<br />将该数值改大会消耗更多内存，启动时间变长。 |
| BPFTRACE_MAX_PROBES         | 512    | 可以追踪的探测点的最大值                                     |
| BPFTRACE_CACHE_USER_SYMBOLS | 0/1    | _参见文档_                                                   |
| BPFTRACE_VMLINUX            | none   | 指定vmlinux路径用于内核符号表解析，绑定kprobe到特定偏移量    |
| BPFTRACE_BTF                | none   | 指定BTF文件                                                  |
| BPFTRACE_PERF_RB_PAGES      | 64     | CPU的环形缓冲区大小，必须是2的指数大小                       |
| BPFTRACE_MAX_BPF_PROGS      | 512    | bpftrace可以生成的最大函数数量，防止bpftrace占用太多资源挂起 |



## bpftrace语言

### 概述

`bpftrace` 语言受到了 D 语言的启发用了相同的语法结构，每个脚本包含一个前言和一个或多个动作块。

```c
preamble

actionblock1
actionblock2
```

预处理和类型定义在前言中：

```c
#include <linux/socket.h>
#define RED "\033[31m]"

struct S{
    int x;
}
```

每个动作块由三部分组成：

```c
probe[,probe]
/predicate/ {
    action
}
```



| 语法      | 解释                                                         |
| --------- | ------------------------------------------------------------ |
| probe     | 一个probe指定了要绑定的事件和事件类型                        |
| predicate | 只有predicate满足的时候action 才会被执行                     |
| action    | action是事件触发时候执行的动作，动作由中括号在内的一系列语句组成 |



```c
BEGIN
{
    printf("Tracing open syscalls... Hit Ctrl-C to end.\n");
}

tracepoint:syscalls:sys_enter_open,
tracepoint:syscalls:sys_enter_openat
{
    printf("%-6d %-16s %s\n", pid, comm, str(args->filename));
}
```

上边的例子有有两个动作块和总共3 个探测点组成。

第一个动作块是BEGIN，该动作在bpftrace 刚开始的时候执行，用于打印一个表头信息。

第二个动作块有两个探测点，一个是`open` 另一个是`openat`，定义了一个输出进程号、进程名、文件名的动作。

### 标识符

标识符必须满足这个正则标识式：`[_a-zA-Z][_a-zA-Z0-9]*`

### 注释

同时支持单行和多行注释。

```c
//单行注释

/*
 * 多行注释
 */
```

### 数据类型

| 类型   | 描述           |
| ------ | -------------- |
| uint8  | 无符号8位整形  |
| int8   | 有符号8位整形  |
| uint16 | 无符号16位整形 |
| int16  | 有符号16位整形 |
| uint32 | 无符号32位整形 |
| int32  | 有符号32位整形 |
| uint64 | 无符号64位整形 |
| int64  | 有符号64位整形 |

#### 浮点型

不支持。

### 常量

* 十进制
* 八进制
* 十六进制
* 科学计数法(10进制)

### 字符

字符可以通过定义在单引号里的字符表示。

### 字符串

字符串可以通过定义在双引号里的字符串表示。

| 转移序列 | 解释          |
| -------- | ------------- |
| \n       | 环行          |
| \t       | Tab           |
| \0nn     | 八进制数 nn   |
| \xnn     | 十六进制数 nn |

### 类型转换

```c
$y = (uint32)$z;
```

### 运算符和表达式

| 运算符 | 解释       |
| ------ | ---------- |
| +      | 加         |
| -      | 减         |
| *      | 乘         |
| /      | 除         |
| %      | 取余       |
| &&     | 逻辑与     |
| \|\|   | 逻辑或     |
| !      | 逻辑非     |
| &      | 位与       |
| \|     | 位或       |
| ^      | 位非       |
| <<     | 位左移操作 |
| \>\>   | 位右移操作 |
| <      | 小于       |
| <=     | 小于等于   |
| >      | 大于       |
| >=     | 大于等于   |
| ==     | 等于       |
| !=     | 不等于     |

**字符串比较**

| 符号 | 解释   |
| ---- | ------ |
| ==   | 等于   |
| !=   | 不等于 |

**赋值运算符**

| 符号  | 解释 |
| ----- | ---- |
| =     | 略   |
| <<=   | 略   |
| \>\>= | 略   |
| +=    | 略   |
| -=    | 略   |
| *=    | 略   |
| /=    | 略   |
| %=    | 略   |
| &=    | 略   |
| \|=   | 略   |
| ^=    | 略   |

**递增递减运算符**

| 运算符号 | 解释    |
| -------- | ------- |
| ++       | 同C语言 |
| --       | 同C语言 |



### 变量和映射

`bpftrace` 支持两种数据类型，`scratch` 和`map`。

`scratch` 在BPF 栈中，仅仅在action 块执行的时候才可以访问，不能被程序外访问，`scratch` 变量由`$` 开始，例如`$myvar`。

`map` 变量使用BPF `map`，在程序运行期间程序内的所有action 块都可以访问，用户态程序也可以访问。`Map`名称以`@` 开头，例如`@mymap`。

数据类型在第一次定义的时候自动决定，之后不能被更改。

#### 关联数组

关联数组类似与C++ 中的`map` 和 Python 中的`dict` ，是`map` 数据类型。

```c
@name[key] = expression
```

一旦定义之后，`key` 和 `value` 的数值都将不能再改变。



### 变量作用域

### 指针

与`C` 语言中类似。

### 元组

元组是不可变的，每个元组元素可以有不同数据类型，可以通过 `.` 符号访问。

### 数组

不支持从零开始创建数组，仅支持从指针中获取变量。

### 结构体

不支持从零开始创建，仅仅支持从指针中读取变量。

### 条件语句

支持 `if/else` 和三元运算符。

```c
//三元运算符
condition ? ifTrue : ifFalse

//条件语句
if (condition) {
    ifblock
} else if (condition) {
    if2block
} else {
    elseblock
}
```

### 循环

```c
//while 循环
while (condition) {
    block;
}

//unroll 语句
//计算 n 并展开，等同于执行 n 次 block;
unroll(n) {
    block;
}
```



##  同步异步

在内核中是同步的，对于用户态来说是异步的。



## 地址空间

内核、用户指针在不同的地址空间，依赖于CPU架构，可能会重叠。

地址空间可以通过`kptr()` 和 `uptr()` 函数改变。



## 内建变量

内建变量是在语言中设置的特殊变量，不需要`$` 和`@` 前缀，除了位置参数。

| 变量                 | 类型   | 内核       | BPF 帮助函数                   | 描述                                                         |
| -------------------- | ------ | ---------- | ------------------------------ | ------------------------------------------------------------ |
| $1,$2,...$n          | int64  | n/a        | n/a                            | 传递给bpftrace的第n个参数，如果少于n个，为0，字符串参数可以通过str() 返回 |
| $#                   | int64  | n/a        | n/a                            | 参数传递个数                                                 |
| arg0, arg1,...argn   | int64  | n/a        | n/a                            | 被追踪函数的第n 个参数，是从CPU寄存器中提取出来的变量，通过寄存器传递的参数格式由CPU架构决定 |
| cgroup               | uint64 | 4.18       | get_current_cgroup_id          | 当前进程的cgroup号，只支持cgroupv2                           |
| comm                 | uint64 | 4.2        | get_current_com                | 当前进程名                                                   |
| cpid                 | uint32 | n/a        | n/a                            | 子进程的PID号                                                |
| cpu                  | uint32 | 4.1        | raw_smp_processor_id           | 执行BPF程序的处理器号                                        |
| curtask              | uint64 | 4.8        | get_current_task               | 指向当前进程的`struct task_struct` 结构体                    |
| elapsed              | uint64 | (see nsec) | ktime_get_ns/ktime_get_boot_ns | bpftrace初始化后经过的纳秒数，基于`nsecs`                    |
| func                 | string | n/a        | n/a                            | 当前追踪的函数名                                             |
| gid                  | uint64 | 4.2        | get_current_uid_gid            | 当前进程的GID                                                |
| kstack               | kstack |            | get_taskid                     | 内核调用栈                                                   |
| nsecs                | uint64 | 4.1/5.7    | ktime_get_ns/ktime_get_boot_ns | 内核启动之后经过的纳秒数                                     |
| pid                  | uint64 | 4.2        | get_current_pid_tgid           | 当前进程的进程号                                             |
| probe                | string | n/a        | n/a                            | 当前的probe名称                                              |
| rand                 | uint32 | 4.1        | get_prandom_u32                | 获取随机数                                                   |
| retval               | int64  | n/a        | n/a                            | 被追踪函数的返回值                                           |
| sarg0,sarg1,...sargn | int64  | n/a        | n/a                            | 被追踪函数的第n 个栈的值                                     |
| tid                  | uint64 | 4.2        | get_current_pid_tgid           | 当前进程的线程id                                             |
| uid                  | uint64 | 4.2        | get_current_uid_gid            | 当前进程的UID                                                |
| ustack               | ustack | 4.6        | get_stackid                    | 用户态调用栈                                                 |



## Map函数

map函数是一类特殊的内建函数，返回值只能赋值给map变量。



## 函数



## 输出格式



## 探测点



## 显示探测点




















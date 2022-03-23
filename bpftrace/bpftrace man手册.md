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

每个动作块可以有多个探测点，探测点之间由逗号',' 链接。 



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

| 函数名 | 函数原型                                         | 是否异步 | 解释                                        |
| ------ | ------------------------------------------------ | -------- | ------------------------------------------- |
| avg    | avg(int64 n)                                     |          | 计算多次调用的平均值                        |
| clear  | clear(map m)                                     | 是       | 清空map中所有的keys/values值                |
| count  | count()                                          |          | 统计函数调用的此时，内部通过PER_CPU变量实现 |
| delete | delete(mapkey k)                                 |          | 从map中删除一个key值                        |
| hist   | hist(int64 n)                                    |          | 创建一个log2 的直方图                       |
| lhist  | lhist(int64 n, int64 min, int64 max, int64 step) |          | 创建一个线性直方图                          |
| max    | max(int64 n)                                     |          | 如果n 大于当前map值则更新                   |
| min    | min(int64 n)                                     |          | 如果n 小于当前map值则更新                   |
| stats  | stats(int64 n)                                   |          | 集合count, avg, sum调用于一个               |
| sum    | sum(int64 n)                                     |          | 计算所有n 的和                              |
| zero   | zero(map m)                                      | 是       | 设置map中所有的值为 0                       |



## 函数

| 函数名      | 函数原型                                                     | 异步/安全/编译时 | 解释                                 |
| ----------- | ------------------------------------------------------------ | ---------------- | ------------------------------------ |
| buf         | buf_t buf(void *data, [int64 length])                        |                  | 从data中获取length长度               |
| cat         | void cat(string namefmt, [...args])                          | 异步             | dump文件中的内容到标准输出           |
| cgroup_path | cgroup_path cgroup_path(int cgroupid, string filter)         |                  | 将cgroup id转换成对应的路径          |
| cgroupid    | uint64 cgroupid(const string path)                           | 编译时           | 转换路径为id 号                      |
| exit        | void exit()                                                  | 异步             | 结束追踪                             |
| join        | void join(char *arr[], [char *sep = ' '])                    | 异步             | 拼接字符串中的值                     |
| kaddr       | uint64 kaddr(const string name)                              | 编译时           | 获取内核符号地址                     |
| kptr        | T * kptr(T * ptr)                                            |                  | 标记ptr 为内核指针                   |
| ksym        | ksym_t ksym(uint64 addr)                                     | 异步             | 返回名称对应的地址                   |
| macaddr     | macaddr_t macaddr(char [6] mac)                              |                  | 返回表示mac地址的字符串              |
| ntop        | inet_t ntop([int64 af,] int addr)<br />inet_t ntop([int64 af,] int addr[4])<br />inet_t ntop([int64 af,] char addr[16]) |                  | 返回IP地址的字符串表示               |
| override    | override(uint 64)                                            | 不安全           | 并不执行函数，直接返回返回值         |
| reg         | reg(const string name)                                       |                  | 获取当前寄存器的内容                 |
| signal      | signal(const string sig)<br />signal(uint32 signum)          | 不安全           | 给追踪的进程发送信号                 |
| sizeof      | sizeof(TYPE)<br />sizeof(EXPRESSION)                         | 编译时           | 返回参数的字节数                     |
| str         | str(char *data[, uint32 length])                             |                  | 读取字符串                           |
| strftime    | strftime_t strftime(const string fmt, int64 timestamp_ns)    | 异步             | 格式化输出系统启动时间               |
| strncmp     | int64 strncmp(char *s1, char *s2, int64 n)                   |                  | 建议直接调用 `==` 和 `!=`            |
| system      | void system(string namefmt [, ...args])                      | 不安全/异步      | 执行命令                             |
| time        | void time(const string fmt)                                  | 异步             | 格式化当前墙上时间，输出到标注你输出 |
| uaddr       | T * uaddr(const string sym)                                  |                  | 返回用户态符号表地址                 |
| uptr        | T * uptr(T * ptr)                                            |                  | 标记该指针为用户态指针               |
| usym        | usym_t usym(uint64 * addr)                                   | 异步             | 返回用户态符号表地址                 |
| path        | char *path(struct path * path)                               |                  | 返回path 的完整路径名                |
| unwatch     | void unwatch(void *addr)                                     | 异步             | 移除一个观测点                       |



## 格式化输出

### print 函数

* **异步**
* 支持`top` 和 `div` 参数

### printf 函数

* **异步**
* 支持转移序列
* 支持颜色



## 探测点

探测点由提供者和冒号分割的选项组成，探测点支持通配符，提供者可以由缩写表示。

### 开始结束

两个内建的特殊事件，`BEGIN` 在所有探测点绑定之前触发，`END` 在所有探测点解引用之后触发。

为了防止打印出所有用到的`map` 可以在`END` 时将`map` 清空。

### 硬件事件

> hardware:event
>
> hardware:event_name:count

缩写：h

`count` 指定时间触发前事件发生的次数。

硬件探测点绑定内核预定义的硬件事件，通过performance monitoring counters(PMCS)实现，PMCs为CPU上的硬件资源，可以通过perf_event_open(2) man 手册查看。

**事件名称：**

* cpu-cycles 或 cycles
* instructions
* cache-references
* cache-misses
* branch-instructions 或 branches
* branch-misses
* bus-cycles
* frontend-stalls
* backend-stalls
* ref-cycles

### 时间间隔

> interval : us : count
>
> interval : ms : count
>
> interval : s : count
>
> interval : hz : rate

缩写：i

### 迭代器

> iter : task
>
> iter : task : pin
>
> iter : task_file
>
> iter : task_file : pin

缩写：it

迭代器探测点，允许遍历内核数据结构。

迭代器不能与其他探测点混用，即使是其他迭代器。

### kfunc 和 kretfunc

> kfunc : fn
>
> kretfunc : fn

缩写：

* f (kfunc)
* fr (kretfunc)

要求：

* 内核特性：BTF
* 探测点类型：kfunc



### kprobe 和 kretprobe

> kprobe : fn
>
> kprobe : fn + offset
>
> kretprobe : fn

缩写：

* k
* kr

函数的参数可以通过`ragX` 和 `sargX` 内建函数获取，用于寄存器参数和栈参数，参数传递方式与架构相关。

`bpftrace` 并不检测函数签名，所以并不知道函数的参数类型，需要用户自己进行类型转换。

`kretprobe` 只能获取函数的返回值，获取不到函数参数。

### profile

> profile : us : count
>
> profile : ms : count 
>
> profile : s : count
>
> profile : hz : rate

缩写：

* p

特定时间间隔触发

### software

> software : event :
>
> software : event : count

缩写：

* s

在特定的软件事件时触发，事件细节可以查看 `perf_event_open(2)` man 手册。

事件名称为：

* cpu-clock 或 cpu
* task-clock
* page-faults 或 faults
* context-switches 或 cs
* cpu-migrations
* minor-faults
* major-faults
* alignment-faults
* emulation-faults
* dummy
* bpf-output

### tracepoint

> tracepoint: subsys: event

缩写：

* t

### uprobe和uretprobe

> uprobe : binary : func
>
> uprobe : binary : func+offset
>
> uretprobe : binary : func

缩写：

* u
* ur

### usdt

> usdt : binary : name

缩写：

* U

### watchpoint 和 asyncwatchpoint

> watchpoint : absolute_address : length : mode
>
> watchpoint : function + argN : length : mode

缩写：

* w
* aw



## 显示探测点

显示当前系统支持的探测点，支持的语法跟正常的绑定相同。

`-v` 选项可以用于显示支持的参数列表。 



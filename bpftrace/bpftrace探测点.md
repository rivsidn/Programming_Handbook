探测点由提供者和冒号分割的选项组成，探测点支持通配符，提供者可以由缩写表示。

## 开始结束

两个内建的特殊事件，`BEGIN` 在所有探测点绑定之前触发，`END` 在所有探测点解引用之后触发。

为了防止打印出所有用到的`map` 可以在`END` 时将`map` 清空。

## 硬件事件

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

## 时间间隔

> interval : us : count
>
> interval : ms : count
>
> interval : s : count
>
> interval : hz : rate

缩写：i

## 迭代器

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

## kfunc 和 kretfunc

> kfunc : fn
>
> kretfunc : fn

缩写：

* f (kfunc)
* fr (kretfunc)

要求：

* 内核特性：BTF
* 探测点类型：kfunc



## kprobe 和 kretprobe

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

## profile

> profile : us : count
>
> profile : ms : count 
>
> profile : s : count
>
> profile : hz : rate

缩写：

* p

间隔一定时间在每个CPU上触发一次。

## software

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

## tracepoint

> tracepoint: subsys: event

缩写：

* t

## uprobe和uretprobe

> uprobe : binary : func
>
> uprobe : binary : func+offset
>
> uretprobe : binary : func

缩写：

* u
* ur

## usdt

> usdt : binary : name

缩写：

* U

## watchpoint 和 asyncwatchpoint

> watchpoint : absolute_address : length : mode
>
> watchpoint : function + argN : length : mode

缩写：

* w
* aw


# C语言中的可变参数

## 起因

内核调试过程中，通过`print` 命令查看`va_list{}` 类型数据为:

```gdb
(gdb) ptype ap
type = struct __va_list_tag {
    unsigned int gp_offset;
    unsigned int fp_offset;
    void *overflow_arg_area;
    void *reg_save_area;
} [1]
```

第一次看到该数据结构，之前并没有详细了解该数据结构的作用，此处详细了解了一下.

## 详细解释

参数传递过程中，首先是通过寄存器传递，`x86_64` 架构下，用于参数传递的寄存器有 6 个，分别为:

| 寄存器 | 参数  |
|--------|-------|
| rdi    | 参数1 |
| rsi    | 参数2 |
| rdx    | 参数3 |
| rcx    | 参数4 |
| r8     | 参数5 |
| r9     | 参数6 |

通过寄存器传递参数之后，如果还有更多的参数，需要通过栈来传递。

| 结构体成员        | 说明                                                     |
|-------------------|----------------------------------------------------------|
| gp_offset         | 非浮点型参数在reg_save_area 中的偏移量                   |
| fp_offset         | 浮点型参数在reg_save_ares 中的偏移量                     |
| overflow_arg_area | 通过栈传递的参数，所在的地址                             |
| reg_save_area     | 通过寄存器传递的参数，所在的地址(寄存器的参数存在了栈上) |

看到这些解释可能会比较晦涩，可以通过具体实例来理解。

### 具体实例

```c
void func(const char *fmt, ...)
{
	va_list ap;

	va_start(ap,fmt);
	vprintf(fmt,ap);
	va_end(ap);

	return;
}

int main()
{
	func("%d,%d,%d,%d,%d,%d,%d,%d,%d,%d,%d\n",1,2,3,4,5,6,7,8,9,10,11);

	return 0;
}
```

如上所示，上边代码执行过程中，调用`func()`函数的时候，这里传递了12 个参数，前 6 个参数通过寄存器传递.

| 寄存器 | 参数           |
|--------|----------------|
| rdi    | fmt 字符串地址 |
| rsi    | 1              |
| rdx    | 2              |
| rcx    | 3              |
| r8     | 4              |
| r9     | 5              |

后边的参数会放到栈上。

在`func()`中调用`vprintf()`的时候，构造了`va_list{}`结构体传递给`vprintf()`。

`func()`参数传递时使用的寄存器，再调用`vprintf()`的时候相同的寄存器不能够复用(每次函数调用能使用的寄存器是相同的)，
需要首先将寄存器中的数值存储到栈上，此时`reg_save_area` 指向的就是这栈上的地址；
该地址需要配合`gp_offset`、`fp_offset` 一起使用，`gp_offset`指的是非浮点型参数在`reg_save_area`中的偏移量，
`fp_offset` 指的是浮点型参数在`reg_save_area` 中的偏移量，默认为 48(6个通用寄存器 6 * 8 = 48)。

`overflow_arg_area` 指向的是原本就在栈上的参数地址。

所以通过`gdb`查看调用`vprintf()` 时的数值为:

```gdb
(gdb) print ap
$1 = {{gp_offset = 8, fp_offset = 48, overflow_arg_area = 0x7fffffffdd20, reg_save_area = 0x7fffffffdc60}}
```

第一个参数`fmt`会在调用`vprintf()`时候被使用，后续的参数在`reg_save_area`偏移量 8 处。

`fp_offset` 为 48，是默认值，表示没有浮点型参数。

紧跟着的是两个地址，如上所述。


## 调试过程

分析该代码的时候，用到了两种新的方式，整理如下。

### GDB调试汇编代码

参见[GDB调试程序](GDB调试程序.md#调试汇编指令)。


### EXCEL画栈图

EXCEL的结构很容易与栈联系起来，通过EXCEL作栈图很方便.

```basic
Sub FillHexStackAddress
    Dim startAddr As Long
    Dim sheet As Object
    Dim i As Integer
    Dim offset As Integer
    
    ' 设置起始地址（0xFFFFDD50的10进制形式）
    startAddr = &HFFFFDD50  ' 或使用CLng("&HFFFFDD50")
    
    ' 获取当前活动的工作表
    sheet = ThisComponent.CurrentController.ActiveSheet
    
    ' 填充10行地址（每次递减8字节，按x86-64典型栈步长）
    For i = 0 To 500
        offset = i * 8  ' 假设每个栈单元占8字节
        ' 地址递减：起始地址 - 偏移量
        sheet.getCellByPosition(0, i).String = "0x" & Hex(startAddr - offset)
    Next i
End Sub
```

`libreOffice`中`Tools`->`Marco`->`Edit Marco` 复制上述代码到编辑窗口，执行，即可以生成包含栈地址的表格。

## 附录



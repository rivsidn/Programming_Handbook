

## 栈相关预处理指令

### stacksize 指令

| 参数   | 栈基地址 | 栈顶内容     |
|--------|----------|--------------|
| flat   | ebp      | eip          |
| flat64 | rbp      | rip          |
| large  | bp       | ip + cs      |
| small  | bp       | bp + ip + cs | 


## line指令

```asm

%line   nnn[+mmm]   [filename]

```


## 内存模型

| 内存模型 | 代码段    | 数据段    | 说明                            |
|----------|-----------|-----------|---------------------------------|
| tiny     | 1         | 1         | 代码段、数据段在同一个段里      |
| small    | 1         | 1         | 代码段、数据段分别在一个段里    |
| medium   | n (n > 1) | 1         | 多个代码段、一个数据            |
| compact  | 1         | n (n > 1) | 一个代码段、多个数据段          |
| large    | n (n > 1) | n (n > 1) | 多个代码段、多个数据段          |
| huge     | n (n > 1) | n (n > 1) | 同large，支持超过64KB的单个对象 |


## 寄存器

这个例子想说的是，一直以为指令格式中的`ModR/M` 指定了目的操作数、源操作数.


汇编指令.
```asm
	mov	ax, [bp-4]
	mov	[bp-4], ax
```

反汇编.
```
00000000: 8b46 fc89 46fc                           .F..F.
```

| asm            | insruction code | Opcode | ModR/M | Displacement |
|----------------|-----------------|--------|--------|--------------|
| mov ax, [bp-4] | 8b46fc          | 8b     | 46     | fc           |
| mov [bp-4], ax | 8946fc          | 89     | 46     | fc           |

如上所示，这里的`ModR/M`是相同的，但是`Opcode` 不同，也就是说，`ModR/M` 指定了目
的、源操作数的组合，不同的指令可以在不同组合之间进行反转(目的、源操作数互换).


## TODO

* gcc 中的 `-no-pie` 是什么意思？


## 附录

### 参考资料

* [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
* [NASM doc](https://www.nasm.us/xdoc/2.16.03/nasmdoc.pdf)
* [Intel® 64 and IA-32 Architectures Software Developer Manuals](https://www.intel.com/content/www/us/en/developer/articles/technical/intel-sdm.html)


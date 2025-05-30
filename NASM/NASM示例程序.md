
## NASM示例程序

### 独立汇编程序

**示例代码**

```asm
	global	_start

	section	.text
_start:
	mov	rax, 1
	mov	rdi, 1
	mov	rsi, message
	mov	rdx, 13
	syscall

	mov	rax, 60
	xor	rdi, rdi
	syscall

	section	.data
message:
	db	"Hello, World", 10, 0
```

**编译**

```bash
nasm -felf64 test.asm; ld test.o
```

编译后生成 `a.out` 文件.

### 引用C库

#### pie模式

**示例代码**

```asm
	global	main
	extern	printf

	section	.text
main:
	lea	rdi, [rel format]
	mov	rsi, 12
	xor	rax, rax
	sub	rsp, 8
	call	printf wrt ..plt
	add	rsp, 8

	ret

	section	.data
format:
	db	"output %d", 10, 0

	section	.note.GNU-stack
```

不同之处:
* 访问`format` 地址
* 调用`printf` 函数

**编译**

```bash
nasm -felf64 test.asm; gcc test.o
```

#### no-pie模式

**示例代码**

```asm
	global	main
	extern	puts

	section	.text
main:
	mov	rdi, message
	call	puts
	ret

	section	.data
message:
	db	"Hello World", 0

	section	.note.GNU-stack
```

**编译**

```bash
nasm -felf64 test.asm && gcc -no-pie test.o
```

### C语言交互

#### 示例程序

**maxofthree.asm**
```asm
	global	maxofthree
	section	.text

	global	maxofthree
	section	.text
maxofthree:
	mov	rax, rdi
	cmp	rax, rsi
	cmovl	rax, rsi
	cmp	rax, rdx
	cmovl	rax, rdx
	ret

	section	.note.GNU-stack
```

**callmaxofthree.c**

```c
#include <stdio.h>
#include <inttypes.h>


int64_t maxofthree(int64_t, int64_t, int64_t);

int main()
{
	printf("%ld\n", maxofthree(1, 2 ,3));
	printf("%ld\n", maxofthree(10, 2111 ,3));

	return 0;
}
```

#### 编译

```bash
nasm -felf64 maxofthree.asm
gcc -no-pie callmaxofthree.c maxofthree.o
```


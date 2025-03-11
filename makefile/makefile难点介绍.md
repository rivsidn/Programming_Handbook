## 概述

命令行中执行`make`命令，`makefile`会当前文件下按照如下顺序查找对应的文件执行。

* `GNUmakefile`
* `makefile`
* `Makefile`

执行过程中会将规则中遇到的第一个`target`或者命令行中提供的`target`作为最终目标来执行命令。

`makefile`执行过程中，会**先依次读完所有的`makefile`文件，然后再执行命令，生成最终的目标文件**。



## 基础语法

```makefile
TARGETS : PREREQUISITES
	COMMAND
	…
```



## 变量展开

### 两种类型的展开

`makefile`中变量类似于C 中的宏，在调用的位置展开，有两种不同类型的展开：

* 直接展开

  ```makefile
  value = 10
  x := $(value)
  value = 20
  
  all:
  	echo $(x)
  ```

  输出 10.

* 延迟展开

  ```makefile
  value = 10
  x = $(value)
  value = 20
  
  all:
  	echo $(x)
  ```

  输出 20.

  延迟展开可以这样理解，先将$(x)替换成，然后将 $(value) 展开成`value` 的值。



### 不同语法中的展开时机

```

 IMMEDIATE = DEFERRED
 
 IMMEDIATE ?= DEFERRED
 
 IMMEDIATE := IMMMDIATE
 
 # 根据之前是立即展开还是延迟展开决定
 IMMEDIATE += DEFERRED or IMMEDIATE
 
 IMMEDIATE : IMMEDIATE
 	DEFERRED
 
```



**示例**

```makefile
obj = p1

all: $(obj)
	@echo "output prerequisites " $^
	@echo "output \$$(obj) "$(obj)

obj += p2

.PHONY: p1 p2
p1 p2: ;

```

输出：

> output prerequisites  p1
> output $(obj) p1 p2

由于`all`中命令是延迟展开，且会在最后`makefile`完全扫面完之后才执行，所以最终$(obj) 中输出为p1 p2.



## 递归调用

```makefile
 # 每一行都是一个独立的shell，所以$(MAKE)命令必须要跟cd subdir 在同一行
 subsystem:
 	cd subdir && $(MAKE)
 
 # 与上边命令表达的意思一致
 subsystem:
 	$(MAKE) -C subdir
 
```

变量出处(可以通过origin命令查看)：

* 环境变量
* 命令行变量
* 隐含变量
* 文件定义变量
* 自动化变量

```makefile
 # 执行
 # env_val=x make cmd_val=x
 # 查看输出结果
 
 file_val=
 
 all:
 	@echo "env_val is" $(origin env_val)
 	@echo "cmd_val is" $(origin cmd_val)
 	@echo "file_val is" $(origin file_val)
 	@echo "CC is" $(origin CC)
 	@echo "@ is" $(origin @)
```



**递归调用中可以传递的变量：**

* 环境变量
* 命令行传入的变量
* `export` 命令导出的变量



## 隐含规则

### 模式规则

```makefile
%.o: %.c
	COMMAND
	...
```

上边模式规则意思为，类似`%.o` 文件依赖与`%.c` 文件生成，生成命令为`COMMAND`.

### 隐含规则

隐含规则也就是一系列模式规则的集合，当没有对应`target`的命令时候，`makefile`会查找隐含规则，竭尽全力生成最终目标。

可以手动写模式规则，替换掉隐含规则。



## 调试命令

### 输出信息

```makefile
# 可以将这行添加到行首，查看到makefile文件被读取的时间.
# 并输出进程PID号、文件名、行号信息
$(warning $(shell echo -n "PID:$$$$=> " >&2)":Reading makefile..." )


# 输出错误信息，Makefile停止执行
$(error text...)
# 输出告警信息，包含文件、行号
$(warning text...)
# 输出提示信息，不包含文件、行号
$(info text...)

```

### make --trace

```makefile

main: main.o
	gcc $< -o $@

clean:
	rm main.o main
```



> $ make --trace
>
> <builtin>: update target 'main.o' due to: main.c
> cc    -c -o main.o main.c
> Makefile:3: update target 'main' due to: main.o
> gcc main.o -o main

上边输出信息能够发现，main.c --> main.o 的过程执行的是隐含规则，main.o --> main 命令在`makefile` 文件第三行定义。

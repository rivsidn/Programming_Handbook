





## call

### 原型

```makefile
$(call variable,param,param)
```

### 执行过程



### 举例说明

```makefile
define test
	echo $1
	echo $2
	echo $3
endef

all:
	$(call test,aa,bb,cc)
```

**输出：**

```
echo aa
aa
echo bb
bb
echo cc
cc
```


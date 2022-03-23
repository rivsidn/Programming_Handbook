## count

### 函数原型

> count()

### 解释

递增`map` 中的值。

### 使用

```c
tracepoint:syscalls:sys_enter_sync {
	@[comm, pid] = count();
}
i:s:10 {
	  exit();
}

/*
	开两个terminal，分别执行一次 sync。
	$ sudo bpftrace count.c 
	Attaching 2 probes...

	@[sync, 30176]: 1
	@[sync, 30177]: 1
*/
```

**注意：** 此处count() 是递增`map` 中value 的值，而不是将函数调用的总值，赋值给value。


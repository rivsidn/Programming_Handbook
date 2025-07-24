
## 协程异步框架说明

主要分几部分:

1. 协程函数
   调用协程函数不会立即执行，会返回一个协程对象
2. 通过事件循环来执行协程对象(或者另一个协程通过await来驱动执行)
3. 协程对象等待时异步IO操作，暂停执行


## 常用API

| 语法             | 说明                                                       |
|------------------|------------------------------------------------------------|
| async            | 定义协程函数                                               |
| await            | 等待IO操作结束(或驱动另一个协程执行)，只能在协程函数中调用 |
| asyncio.run()    | 事件循环，运行协程对象                                     |
| asyncio.gather() | 返回一个运行协程对象，必须通过await 启动执行               |

### 可等待对象

如果一个对象可以在`await` 语句中使用，那么它就是可等待对象.
可等待对象有三种.

- 协程(协程函数返回)
- 任务(create_task()返回)
- Future(asyncio.gather()返回)


## 代码示例

### 常用代码示例(一)

```python
#! /usr/bin/python3

import asyncio

async def say_hello():
    print("Hello")
    await asyncio.sleep(1)
    print("World")

async def main():
    await say_hello()
    await say_hello()

asyncio.run(main())
asyncio.run(main())

print("End")
```

关键知识点:

- `asyncio.run()` 函数只能在同步代码中调用
- `asyncio.run()` 在同步代码中能够多次调用
- 两个`asyncio.run()` 之间是顺序执行的
- `await` 只能在`async` 函数中被使用
- 两个`await` 之间是顺序执行的


### 常用代码示例(二)


```python
#! /usr/bin/python3

import asyncio

async def say_hello():
    print("Hello")
    await asyncio.sleep(1)
    print("World")

async def main():
    await asyncio.gather(
        say_hello(),
        say_hello(),
        say_hello()
    )

asyncio.run(main())

print("End")
```

- `asyncio.gather()` 函数返回一个协程对象
- 多个`say_hello()`  之间是并发执行的


## 总结

- 同步代码中执行协程对象使用`asyncio.run()`
- 异步代码中执行携程对象使用`await`
- 同一函数中多个`asyncio.run()`、`await()` 之间顺序执行
- `asyncio.gather()`返回的携程对象，各个组成元素之间并发执行



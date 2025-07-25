

- python 不支持函数重载


## 函数定义

```python
def func():
    print("hello world")
    return
```

## 函数参数

```python
#! /usr/bin/python3

def func(name:str|None):
    if name != None:
        print("Hello, World", name)
    else:
        print("Hello, World everyone")

    return

func("John")
func(None)
```




## 附录

### TODO

from AI，待整理.

>  1. 默认参数：
>  def greet(name, greeting="Hello"):
>      return f"{greeting}, {name}!"
>
>  2. 可变参数：
>  def process(*args, **kwargs):
>      # 根据参数数量和类型处理
>      pass
>
>  3. functools.singledispatch（类型分发）：
>  from functools import singledispatch
>
>  @singledispatch
>  def process(arg):
>      print(f"Processing {arg}")
>
>  @process.register
>  def _(arg: int):
>      print(f"Processing integer: {arg}")
>
>  @process.register
>  def _(arg: str):
>      print(f"Processing string: {arg}")
>
>  4. typing.overload（仅用于类型提示）：
>  from typing import overload
>
>  @overload
>  def func(x: int) -> int: ...
>
>  @overload  
>  def func(x: str) -> str: ...
>
>  def func(x):
>      # 实际实现
>      return x
>


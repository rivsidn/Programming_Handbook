
## 基本概念

本质上，装饰器就是一个接受函数作为参数并返回新函数的高阶函数。

基于装饰器，我们可以在不修改原函数代码的情况下，为函数添加额外的功能。


```python
# 基本装饰器语法
@decorator_name
def function_name():
    pass

# 等价于
def function_name():
    pass
function_name = decorator_name(function_name)
```


```python
def my_decorator(func):
    def wrapper():
        print("before...")
        func()
        print("after...")
    return wrapper

@my_decorator
def say_hello():
    print("Hello!")
```

装饰器几个特点:

- 装饰器本身就是一个函数
- 装饰器本身接收函数作为参数
- 装饰器函数将函数作为返回值返回


## 附录

### TODO-待整理


from AI:

> ● 高级装饰器用法
> 
>   1. 带参数的装饰器
> 
>   def repeat(times):
>       def decorator(func):
>           @functools.wraps(func)
>           def wrapper(*args, **kwargs):
>               for i in range(times):
>                   result = func(*args, **kwargs)
>               return result
>           return wrapper
>       return decorator
> 
>   @repeat(3)
>   def greet(name):
>       print(f"你好, {name}!")
> 
>   2. 类装饰器
> 
>   class CountCalls:
>       def __init__(self, func):
>           self.func = func
>           self.count = 0
> 
>       def __call__(self, *args, **kwargs):
>           self.count += 1
>           print(f"{self.func.__name__} 被调用了 {self.count} 次")
>           return self.func(*args, **kwargs)
> 
>   @CountCalls
>   def say_hello():
>       print("Hello!")
> 
>   3. 装饰器链（多个装饰器）
> 
>   @timer
>   @log_calls
>   @repeat(2)
>   def complex_function(x):
>       return x * 2
> 
>   # 执行顺序：从下到上
>   # 相当于：timer(log_calls(repeat(2)(complex_function)))
> 
>   4. 保持原函数元数据
> 
>   import functools
> 
>   def my_decorator(func):
>       @functools.wraps(func)  # 保持原函数的__name__, __doc__等
>       def wrapper(*args, **kwargs):
>           return func(*args, **kwargs)
>       return wrapper
> 
>   关键要点提醒
> 
>   你可能忽略的问题：
>   1. 忘记使用*args, **kwargs - 这会导致装饰的函数无法接受参数
>   2. 不使用functools.wraps - 会丢失原函数的元数据信息
>   3. 装饰器返回值问题 - 确保包装函数返回原函数的结果
> 
>   超出常规思考的建议：
>   1. 考虑装饰器的性能开销 - 每次调用都会增加一层函数调用
>   2. 可以用装饰器实现单例模式、缓存机制
>   3. 结合contextlib创建更复杂的装饰器
> 
>   装饰器是Python中非常优雅的设计模式，能让代码更加简洁和可维护！


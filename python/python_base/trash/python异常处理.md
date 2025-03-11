```python
try:
    print(x)
except NameError:
    print("Variable x is not defined")
except:
    print("Something else went wrong")
else:
    print("Nothin went wrong")
finally:
    print("The try except is finished")
```



| 关键字   | 解释                                            |
| -------- | ----------------------------------------------- |
| try      | 开始追踪代码块异常                              |
| except   | 允许处理错误                                    |
| else     | 没有错误的时候执行的代码块                      |
| finnally | 最终结束时执行的代码块，无论是否有错误都会执行k |


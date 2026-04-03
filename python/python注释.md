
## 单行注释

```python
 This is a comment
```

多行注释就是多个单行注释.

## 文档字符串

- 模块说明
  ```python
  """
  这是模块说明
  可以写多行
  """

  ```

- 类说明
  ```python
  class User:
      """表示系统中的一个用户。"""
  ```
- 函数说明
  ```python
  def add(a, b):
      """返回两个数的和"""
      return a + b
  ```

## docstring标准格式

### 类

```python
class User:
    """表示系统中的一个用户。

    Attributes:
        name (str): 用户名。
        age (int): 用户年龄。
    """

    def __init__(self, name: str, age: int):
        """初始化用户对象。"""
        self.name = name
        self.age = age
```

### 函数

```python
def func(arg1, arg2):
    """一句话说明函数作用。

    Args:
        arg1: 参数 1 的含义。
        arg2: 参数 2 的含义。

    Returns:
        返回值的含义。

    Raises:
        某异常: 在什么情况下抛出。
    """
```


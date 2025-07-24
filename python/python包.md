
包(package) 可以理解成是模块(modules) 的集合.

### 导入包路径查找顺序

- 内置模块（Built-in Modules）

  优先查找 Python 内置的 C 实现模块，比如 sys、math。

- 当前脚本所在目录

  即运行的 .py 文件所在目录，或者交互式解释器当前目录（os.getcwd()）。

- PYTHONPATH 环境变量指定的路径

  如果设置了 PYTHONPATH，会将这些路径添加到 sys.path 前面。

- 标准库路径

  查找 Python 安装目录下的标准库，如 /usr/lib/python3.x/。

- site-packages 目录

  即通过 pip 安装的第三方包所在目录。


### 外部导入包模块

支持的语法有.

```python
# 导入模块
import package.module.submodule

# 导入模块或者函数
from package.module import item

```

### 内部包模块相互引用

语法相同，支持相对路径.

```python

# 当前目录
from . module import item

# 上级目录
from .. submodule import item
from ..module submodule import item

```

### 混合的情况

导入包时候，会依次执行包中的`__init__.py`.


mcp/server/__init__.py 文件.

```python
from .fastmcp import FastMCP
from .lowlevel import NotificationOptions, Server
from .models import InitializationOptions

__all__ = ["Server", "FastMCP", "NotificationOptions", "InitializationOptions"]
```

mcp/server/lowlevel/__init__.py 文件.

```python
from .server import NotificationOptions, Server

__all__ = ["Server", "NotificationOptions"]
```

用户代码.

```python
from mcp.server import Server
```

上边代码最终会调用到 `mcp/server/lowlevel/server` 中的 `Server` 类.

找的顺序是这样的：

- 进入到 mcp/server/ 目录下，执行 `__init__.py`，查找Server 发现位于 lowlevel 下
- 进入到 lowlevel 下， 发现Server 来自 server 模块
- 导入到本地



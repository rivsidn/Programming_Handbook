通过帮助函数 `help()` 可以查看`python` 帮助信息。



## 已安装模块

```bash
$ python3
Python 3.8.10 (default, Nov 26 2021, 20:14:08) 
[GCC 9.3.0] on linux
Type "help", "copyright", "credits" or "license" for more information.
>>> help()
help> modules
help> 

```

进入`python` 命令行界面，输入`help()` 进入帮助文档界面，`modules` 查看所有当前安装的模块。

## 查看内建模块

```bash
help> 
You are now leaving help and returning to the Python interpreter.
If you want to ask for help on a particular object directly from the
interpreter, you can type "help(object)".  Executing "help('string')"
has the same effect as typing a particular string at the help> prompt.
>>> import sys 
>>> sys.builtin_module_names
('_abc', '_ast', '_bisect', '_blake2', '_codecs', '_collections', '_csv', '_datetime', '_elementtree', '_functools', '_heapq', '_imp', '_io', '_locale', '_md5', '_operator', '_pickle', '_posixsubprocess', '_random', '_sha1', '_sha256', '_sha3', '_sha512', '_signal', '_socket', '_sre', '_stat', '_statistics', '_string', '_struct', '_symtable', '_thread', '_tracemalloc', '_warnings', '_weakref', 'array', 'atexit', 'binascii', 'builtins', 'cmath', 'errno', 'faulthandler', 'fcntl', 'gc', 'grp', 'itertools', 'marshal', 'math', 'posix', 'pwd', 'pyexpat', 'select', 'spwd', 'sys', 'syslog', 'time', 'unicodedata', 'xxsubtype', 'zlib')
>>> 
```

帮助文档界面回车，进入命令行界面，`import sys`，输入`sys.builtin_module_names` 查看内建模块。

## 查看模块信息

```bash
>>> import math
>>> help(math)
```

导入模块，查看模块信息。

## 查看函数信息

```bash
>>> dir(math)
>>> help(math.sin)
```

`dir()` 命令显示出当前模块所有函数名；help() 查看函数解释。



## 参考资料

* [查看python模块和函数帮助方法文档方法](https://blog.csdn.net/u013810296/article/details/55509284)
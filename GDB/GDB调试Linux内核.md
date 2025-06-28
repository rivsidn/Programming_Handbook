




### 添加内核模块符号表

#### 自动添加

```bash
# 设置环境变量
export PYTHONPATH=scripts/gdb

# 加载内核内置GDB脚本
source scripts/gdb/vmlinux-gdb.py

# 执行命令加载内核模块符号表
lx-symbols
```

#### 手动添加符号表

```bash
# 查看内核模块.text段基地址
# 方法1
cat /sys/module/<module_name>/sections/.text
# 方法2
lsmod | grep <module_name>

# GDB中添加符号表
add-symbol-file modules.ko <text_address>
```


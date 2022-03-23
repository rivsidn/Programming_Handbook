

```bash

bpftrace -e 'tracepoint:raw_syscalls:sys_enter {@[comm] = count(); }'

```








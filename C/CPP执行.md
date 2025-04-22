

### 执行语法

```bash
       cpp [-Dmacro[=defn]...] [-Umacro]
           [-Idir...] [-iquotedir...]
           [-M|-MM] [-MG] [-MF filename]
           [-MP] [-MQ target...]
           [-MT target...]
           infile [[-o] outfile]
```

* 省略输出文件默认输出到标准输出
    ```bash
    $ cpp c.c
    # 0 "c.c"
    # 0 "<built-in>"
    # 0 "<command-line>"
    # 1 "/usr/include/stdc-predef.h" 1 3 4
    # 0 "<command-line>" 2
    # 1 "c.c"
    
    bb
    ```
* 省略输入、输出文件会从标准输入读，输出到标准输出
    ```bash
    $ cpp
    #define aa bb
    aa
    # 0 "<stdin>"
    # 0 "<built-in>"
    # 0 "<command-line>"
    # 1 "/usr/include/stdc-predef.h" 1 3 4
    # 0 "<command-line>" 2
    # 1 "<stdin>"

    # 此处输入Ctrl+D 表示文件结束
    
    bb
    ```


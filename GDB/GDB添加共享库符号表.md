## GDB添加共享库

### 添加debug源

```bash
# 添加调试符号源
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs) main restricted universe multiverse" | sudo tee /etc/apt/sources.list.d/ddebs.list
echo "deb http://ddebs.ubuntu.com $(lsb_release -cs)-updates main restricted universe multiverse" | sudo tee -a /etc/apt/sources.list.d/ddebs.list

# 导入密钥
sudo apt install ubuntu-dbgsym-keyring
sudo apt update
```

### 查看正使用的共享库

以`/lib/x86_64-linux-gnu/libglib-2.0.so.0` 为例，安装该库的debug sym 信息.

```gdb
(gdb) info sharedlibrary 
From                To                  Syms Read   Shared Object Library
0x00007ffff7fc4000  0x00007ffff7ff0935  Yes         /lib64/ld-linux-x86-64.so.2
0x00007ffff7f8c280  0x00007ffff7f9e6c0  Yes (*)     /lib/x86_64-linux-gnu/libz.so.1
0x00007ffff7ee4300  0x00007ffff7f7085e  Yes (*)     /lib/x86_64-linux-gnu/libpixman-1.so.0
0x00007ffff7ea8130  0x00007ffff7ed0535  Yes (*)     /lib/x86_64-linux-gnu/libncursesw.so.6
0x00007ffff7e78840  0x00007ffff7e8abb8  Yes (*)     /lib/x86_64-linux-gnu/libtinfo.so.6
0x00007ffff7e611a0  0x00007ffff7e6597f  Yes (*)     /lib/x86_64-linux-gnu/libfdt.so.1
0x00007ffff7d2f000  0x00007ffff7dd0f02  Yes (*)     /lib/x86_64-linux-gnu/libglib-2.0.so.0
0x00007ffff7c31440  0x00007ffff7cb2992  Yes         /lib/x86_64-linux-gnu/libm.so.6
0x00007ffff7bf7780  0x00007ffff7c1a745  Yes (*)     /lib/x86_64-linux-gnu/libgcc_s.so.1
0x00007ffff7828800  0x00007ffff79bd499  Yes         /lib/x86_64-linux-gnu/libc.so.6
0x00007ffff7bea180  0x00007ffff7bed31c  Yes (*)     /lib/x86_64-linux-gnu/libatomic.so.1
0x00007ffff7b4b300  0x00007ffff7bbba5c  Yes (*)     /lib/x86_64-linux-gnu/libpcre2-8.so.0
(*): Shared library is missing debugging information.
```

查看当前文件的共享库，`*` 表示缺少debug sym 信息.

### 安装调试信息

```bash
# 查找该库对应的安装包
$ apt-file search /lib/x86_64-linux-gnu/libglib-2.0.so.0
libglib2.0-0t64: /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0
libglib2.0-0t64: /usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.8200.1
libglib2.0-dev: /usr/share/gdb/auto-load/usr/lib/x86_64-linux-gnu/libglib-2.0.so.0.8200.1-gdb.py

# 查找对应的debug sym 库
$ sudo apt-cache search libglib2.0-0t64-dbgsym
libglib2.0-0t64-dbgsym - debug symbols for libglib2.0-0t64

# 安装
$ sudo apt install libglib2.0-0t64-dbgsym
```

### 添加符号表到GDB

```bash
# 查看debug sym 库包含的所有debug 文件
$ sudo dpkg -L libglib2.0-0t64-dbgsym:amd64
/.
/usr
/usr/lib
/usr/lib/debug
/usr/lib/debug/.build-id
/usr/lib/debug/.build-id/23
/usr/lib/debug/.build-id/23/f365cf00be49a4a99229d2b8cb0e0555abbddb.debug
/usr/lib/debug/.build-id/46
/usr/lib/debug/.build-id/46/a7e7bf9aacf084f0184190f1dadaea43e0198a.debug
/usr/lib/debug/.build-id/89
/usr/lib/debug/.build-id/89/7a56fdba3656decd5eaea38431bcbf3784e946.debug
/usr/lib/debug/.build-id/c8
/usr/lib/debug/.build-id/c8/cd5c1206ee99e39e54b03f1fa0ec549e2c194f.debug
/usr/lib/debug/.build-id/d1
/usr/lib/debug/.build-id/d1/f3fa989208156a5d35e54d03c515c8ab9bab3f.debug
/usr/lib/debug/.build-id/e9
/usr/lib/debug/.build-id/e9/d4de443fe07d291ae665f3641607e6a6b839ed.debug
/usr/lib/debug/.build-id/fd
/usr/lib/debug/.build-id/fd/6f8753c162be3d530f48d0ab827d7dea0d3268.debug
/usr/lib/debug/.build-id/ff
/usr/lib/debug/.build-id/ff/67265024957503040891552733483f8a18137a.debug
/usr/lib/debug/.dwz
/usr/lib/debug/.dwz/x86_64-linux-gnu
/usr/lib/debug/.dwz/x86_64-linux-gnu/libglib2.0-0t64.debug
/usr/share
/usr/share/doc
/usr/share/doc/libglib2.0-0t64-dbgsym
```

添加debug sym 文件到GDB.

```gdb
add-symbol-file /usr/lib/debug/.build-id/23/f365cf00be49a4a99229d2b8cb0e0555abbddb.debug
add-symbol-file /usr/lib/debug/.build-id/46/a7e7bf9aacf084f0184190f1dadaea43e0198a.debug
add-symbol-file /usr/lib/debug/.build-id/89/7a56fdba3656decd5eaea38431bcbf3784e946.debug
add-symbol-file /usr/lib/debug/.build-id/c8/cd5c1206ee99e39e54b03f1fa0ec549e2c194f.debug
add-symbol-file /usr/lib/debug/.build-id/d1/f3fa989208156a5d35e54d03c515c8ab9bab3f.debug
add-symbol-file /usr/lib/debug/.build-id/e9/d4de443fe07d291ae665f3641607e6a6b839ed.debug
add-symbol-file /usr/lib/debug/.build-id/fd/6f8753c162be3d530f48d0ab827d7dea0d3268.debug
add-symbol-file /usr/lib/debug/.build-id/ff/67265024957503040891552733483f8a18137a.debug
```

### 确认

```gdb
(gdb) info sharedlibrary
From                To                  Syms Read   Shared Object Library
0x00007ffff7fc4000  0x00007ffff7ff0935  Yes         /lib64/ld-linux-x86-64.so.2
0x00007ffff7f8c280  0x00007ffff7f9e6c0  Yes (*)     /lib/x86_64-linux-gnu/libz.so.1
0x00007ffff7ee4300  0x00007ffff7f7085e  Yes (*)     /lib/x86_64-linux-gnu/libpixman-1.so.0
0x00007ffff7ea8130  0x00007ffff7ed0535  Yes (*)     /lib/x86_64-linux-gnu/libncursesw.so.6
0x00007ffff7e78840  0x00007ffff7e8abb8  Yes (*)     /lib/x86_64-linux-gnu/libtinfo.so.6
0x00007ffff7e611a0  0x00007ffff7e6597f  Yes (*)     /lib/x86_64-linux-gnu/libfdt.so.1
0x00007ffff7d2f000  0x00007ffff7dd0f02  Yes         /lib/x86_64-linux-gnu/libglib-2.0.so.0
0x00007ffff7c31440  0x00007ffff7cb2992  Yes         /lib/x86_64-linux-gnu/libm.so.6
0x00007ffff7bf7780  0x00007ffff7c1a745  Yes (*)     /lib/x86_64-linux-gnu/libgcc_s.so.1
0x00007ffff7828800  0x00007ffff79bd499  Yes         /lib/x86_64-linux-gnu/libc.so.6
0x00007ffff7bea180  0x00007ffff7bed31c  Yes (*)     /lib/x86_64-linux-gnu/libatomic.so.1
0x00007ffff7b4b300  0x00007ffff7bbba5c  Yes (*)     /lib/x86_64-linux-gnu/libpcre2-8.so.0
(*): Shared library is missing debugging information.
```

重新通过`info sharedlibrary` 查看，`*` 号消失表示 debug sym 已经正确加载.



## GCC源码编译

### 源码下载

[下载地址](https://ftp.gnu.org/gnu/gcc/)

### 环境准备

安装编译依赖库.

```bash
sudo apt update
sudo apt install build-essential flex bison texinfo
sudo apt install libgmp-dev libmpfr-dev libmpc-dev
```

### 编译

```bash
# 正常编译
make build-gcc
cd   build-gcc

../configure --prefix=/home/yuchao/source_code/gcc/gcc-14.2.0/build-gcc/install \
--enable-languages=c --disable-multilib

make -j8

# 编译调试版本
make build-gcc
cd   build-gcc

../configure --prefix=/home/yuchao/source_code/gcc/gcc-14.2.0/build-gcc-debug/install \
--disable-multilib --enable-languages=c \
CFLAGS='-g -O0' CXXFLAGS='-g -O0'

make -j8
```


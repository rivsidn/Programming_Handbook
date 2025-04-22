
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
make build-gcc
cd   build-gcc

../configure --disable-multilib

make -j8
```


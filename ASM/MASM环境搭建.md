## 环境搭建

```bash
# 安装dosbox
$ sudo apt-get install dosbox
# 安装MASM
$ git clone https://github.com/xDarkLemon/DOSBox_MASM.git
$ git checkout origin/master
```

## 程序运行

```assembly
DATA SEGMENT
HW DB 'HELLO WORLD$'
DATA ENDS

CODE SEGMENT
	ASSUME CS:CODE, DS:DATA
START:	MOV AX, DATA
	MOV DS, AX
	LEA DX, HW
	MOV AH, 9H
	INT 21H
	MOV AH, 4CH
	INT 21H
CODE ENDS
END START
```



```bash
# 启动DOSBox运行
Z:\>mount C /home/rivsidn/tmp/masm
Z:\>C:
C:\>MASM.EXE
C:\>LINK.EXE
C:\>HELLO
HELLO WORLD
C:\>
```

按照提示输入即可，注意此处输入的必须是大写字母，否则`MASM.EXE` 不识别。

## 程序调试













## 附录

### 参考资料

* [dosbox+masm汇编环境的安装和使用](https://blog.csdn.net/YuzuruHanyu/article/details/80287419)
* [Linux下实现 MASM汇编](https://blog.csdn.net/Tqdada/article/details/53132201)
* [DOSBox下调试(masm、link、debug)简单的汇编语言程序](https://bingyishow.top/Technical-article/54.html)

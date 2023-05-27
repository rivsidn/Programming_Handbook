## 基础

```perl
# 设置
$num = 10;
$str = "string...";
# 访问
$num = $num + 1;
$str = $str.$str;

# 数字、字符串转换
$str_num = "010";
printf "%d\n", $str_num;	# 输出10

# 标量初始直未定义
if (defined $undef) {
	print "defined\n";
} else {
	print "not defined\n";	# 输出未定义
}
```




## 字符串操作符

```perl
# 拼接
$str1 = "hello ";
$str2 = "world\n";

print $str1.$str2;				# 输出 hello world

# 重复
$str = "fred";
print $str x 3;					# 输出fredfredfred

```



## 比较操作符

| 比较       | 数字 | 字符串 |
| ---------- | ---- | ------ |
| 相等       | ==   | eq     |
| 不等       | !=   | ne     |
| 大于       | <    | lt     |
| 小于       | >    | gt     |
| 小于或等于 | <=   | le     |
| 大于或等于 | >=   | ge     |



## 特殊标量

| 符号 | 说明               |
| ---- | ------------------ |
| $0   | 当前的可执行文件名 |
| $_   | 某些函数的默认变量 |





## 要点说明

* `perl`中标量由符号`$` 表示。
* 标量表示单一变量，可以是数字，也可以是字符串
* 标量变量可以不经过声明直接使用，未初始化的变量是`undef`类型
* 字符串、数字可以以10进制的形式相互转换


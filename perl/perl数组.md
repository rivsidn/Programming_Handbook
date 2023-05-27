## 基础

数组在`perl` 用`@` 表示。

```perl
# 设置(1)
$arr[0] = "test";
$arr[1] = 10;
# 设置(2)
@arr = (1,2,3,4,5);
# 设置(3)
@arr = (1..6);
# 设置(4)
@arr = qw(aa bb cc dd ee ff);
# 设置(5)
@arr = @arr1;
@arr = (@arr1, @arr2);

# 访问(1)
foreach $rock (@rocks) {
	print "$rock\n";
}
# 访问(2)
while (($id, $val) = each @arr) {
	print "$id->$val\n";
}
# 访问(3)
$arr[0] = $arr[1];
```

### 范围操作符

```perl
(1..10)
```

### qw简写

```perl
qw( aaa bbb ccc)		# 等同于 ("aaa", "bbb", "ccc")
```



## 数组操作函数

| 操作符  | 语法                                       | 用途                                                         | 返回值                   |
| ------- | ------------------------------------------ | ------------------------------------------------------------ | ------------------------ |
| push    | push @arr, 10                              | 添加元素到数组末尾，第一个参数为数组，<br />第二个参数可以是标量、标量直接量、数组、列表直接量 | 追加之后数组元素个数     |
| pop     | pop @arr                                   | 删除数组中最后一个元素                                       | 删除的数组元素           |
| shift   | shift @arr                                 | 删除数组头第一个元素                                         | 删除的数组元素           |
| unshift | unshift @arr, 10                           | 添加元素到数组头部，参数同 **push**                          | 同 **push**              |
| splice  | splice @arr, 2                             | 删除数组中从第三个元素以及之后的所有元素                     | 被删除的数组元素         |
|         | splice @arr, 2, 1                          | 删除数组中从第三个元素开始，一个元素                         | 同上                     |
|         | splice @arr, 2, 1, 10                      | 删除数组中从第三个元素开始，一个元素，将10插入到第三个元素位置<br />最后一个参数同**push** 第二个参数 | 同上                     |
| sort    | @sorted = sort @arr                        | 数组排序，作为参数的数组顺序不变                             | 返回排好序的元素         |
| reverse | @reversed = reverse @arr                   | 数组顺序反转，作为参数的数组顺序不变                         | 反转之后的数组           |
| each    | while (($id, $val) = each @rocks) {<br />} | 数组遍历                                                     | 返回下一个数组下标、数值 |



## 要点说明

* 数组元素是标量，同一个数组中元素可以同时有数字和字符串。



### 上下文

```perl
sub context {
	if (&CORE::wantarray) {
		print "array context\n";
	} else {
		print "scalar context\n";	
	}
}
```




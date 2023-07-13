

* 正则表达式如何匹配同一行的多个匹配项？
  ```perl
  $_ = "aa bb cc";
  if (/(\w+)/g) {
	# 此时如何输出aa bb cc ?
  	print "$1\n";
  }
  ```

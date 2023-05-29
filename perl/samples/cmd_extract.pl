#! /usr/bin/perl

# 解析形如 {['ls' '-la']} 中的命令行

while (<>) {
	if (/{\[(.*)\]}/) {
		print $1,"\n";
	}
}


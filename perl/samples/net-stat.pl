#! /usr/bin/perl

# ping 获取网络状态，状态切换时输出信息

while (1) {
	my $state, $before;
	my $ping_return = `ping @ARGV[0] -c 1 -W 2 2>&1`;

	if ($ping_return =~ /time=[.0-9]* ms/m) {
		$state = "normal";
	} else {
		$state = "error";
	}

	if ($state ne $before) {
		$before = $state;
		my $time = localtime;
		print "$time"," state => $state\n",;
	}

	sleep 1;
}



#! /usr/bin/perl

use strict;
use v5.10;

system 'date';
open PING, "ping 172.31.95.116|" or die "can not pipe from ping: $!";

sub activate {
	system './_win_activate.sh';
	system 'date';
	exit;
}

while (<PING>) {
	activate() if (/time=.*ms/);
}

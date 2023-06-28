#! /usr/bin/perl

use v5.10;
use strict;

open FLOWS_116, "<116-$ARGV[0]";
open FLOWS_119, "<119-$ARGV[0]";

my @flows_116_lines = grep { /TCP/ } <FLOWS_116>;
my @flows_119_lines = grep { /TCP/ } <FLOWS_119>;

#print @flows_116_lines;
#print @flows_119_lines;

print "-----\n";

my @reg_patterns = (
	'(\d+) → 21 \[SYN\]',
	'21 → (\d+) \[SYN, ACK\]',
	'20 → (\d+) \[SYN\]',
	'(\d+) → 20 \[SYN, ACK\]',
	'20 → (\d+) \[FIN, ACK\]',
	'(\d+) → 20 \[FIN, ACK\]',
	'(\d+) → 21 \[FIN, ACK\]',
	'21 → (\d+) \[FIN, ACK\]'
);

my $i = 0;
my $j = 0;
my $m = 0;
my $port1;
my $port2;
my $output;
# 依次匹配正则表达式
while ($i < @flows_116_lines || $j < @flows_119_lines) {
	$output = 0;
	$m %= @reg_patterns;
	if ($flows_116_lines[$i] =~ /$reg_patterns[$m]/) {
		if ($m == 0) {
			$port1 = $1;
			$output = 1;
		} elsif ($m == 2) {
			$port2 = $1;
			$output = 1;
		} elsif ($m == 1 || $m >= 6) {
			$output = 1 if $port1 == $1;
		} else {
			$output = 1 if $port2 == $1;
		}
		if ($output) {
			print "[A] $flows_116_lines[$i]";
			print "\n" if $m == 7;
			$m++;
			$i++;
		}
	}
	if ($flows_119_lines[$j] =~ /$reg_patterns[$m]/) {
		if ($m == 0) {
			$port1 = $1;
			$output = 1;
		} elsif ($m == 2) {
			$port2 = $1;
			$output = 1;
		} elsif ($m == 1 || $m >= 6) {
			$output = 1 if $port1 == $1;
		} else {
			$output = 1 if $port2 == $1;
		}
		if ($output) {
			print "[B] $flows_119_lines[$j]";
			print "\n" if $m == 7;
			$m++;
			$j++;
		}
	}
}


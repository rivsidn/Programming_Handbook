#! /usr/bin/perl

use v5.10;
use strict;

open FH, "<ifconfig.log";
my @tx_lines = grep { /TX\ packets:\d{7}/ } <FH>;
open FH, "<ifconfig.log";
my @rx_lines = grep { /RX\ packets:\d{7}/ } <FH>;

my @tx_packets;
my @rx_packets;
foreach (@tx_lines) {
	my ($packets) = /TX\ packets:(\d+)/;
	push @tx_packets, $packets;
}
foreach (@rx_lines) {
	my ($packets) = /RX\ packets:(\d+)/;
	push @rx_packets, $packets;
}

my $index;
my $rx_old = @rx_packets[0];
my $tx_old = @tx_packets[0];
for($index=1; $index < @tx_packets && $index < @rx_packets; $index++) {
	my $delta_rx = @rx_packets[$index] - $rx_old;
	my $delta_tx = @tx_packets[$index] - $tx_old;

	print "rx:",$delta_rx," tx:",$delta_tx,"\n";

	$rx_old = @rx_packets[$index];
	$tx_old = @tx_packets[$index];
}

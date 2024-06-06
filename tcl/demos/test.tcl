#! /usr/bin/tclsh

proc print12 {AA} {
	upvar $AA a
	puts "$a(1), $a(2)"
}

set test(1) "A"
set test(2) "B"

print12 test

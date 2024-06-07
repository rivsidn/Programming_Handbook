#! /usr/bin/tclsh

proc l4 {} {
	puts [info level -3]
}

proc l3 {} {
	l4
}

proc l2 {} {
	l3
}

proc l1 {a} {
	l2
}

l1 10

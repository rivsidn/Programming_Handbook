#! /usr/bin/tclsh

set x 1

if {$x == 2} {
	puts "$x is 2"
} else {
	puts "$x is not 2"
}

if $x==1 {puts "GOT 1"}

set y x
if "$$y != 1" {
	puts "$$y is != 1"
} else {
	puts "$$y is 1"
}

set y {[exit]}
if "$$y != 1" {
	puts "$$y is != 1"
} else {
	puts "$$y is 1"
}

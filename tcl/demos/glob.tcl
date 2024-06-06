#! /usr/bin/tclsh

foreach file [lsort [set files [glob]]] {
	puts $file
}

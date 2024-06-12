#! /usr/bin/tclsh

set list1 {item1 item2 item3}
set list2 [split "item1.item2.item3" "."]
set list3 [list "item1" "item2" "item3"]

puts $list1
puts $list2
puts $list3

puts [llength $list1]
puts [llength $list2]
puts [llength $list3]

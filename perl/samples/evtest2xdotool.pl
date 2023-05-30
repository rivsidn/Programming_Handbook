#! /usr/bin/perl

%key_map = (
	"KEY_ENTER" => "Return",
	"KEY_LEFTALT" => "Alt",
	"KEY_LEFTCTRL" => "Ctrl",
	"KEY_SEMICOLON" => "semicolon",
	"KEY_SPACE" => "space",
	"KEY_A" => "a",
	"KEY_B" => "b",
	"KEY_C" => "c",
	"KEY_D" => "d",
	"KEY_E" => "e",
	"KEY_F" => "f",
	"KEY_G" => "g",
	"KEY_H" => "h",
	"KEY_I" => "i",
	"KEY_J" => "j",
	"KEY_K" => "k",
	"KEY_L" => "l",
	"KEY_M" => "m",
	"KEY_N" => "n",
	"KEY_O" => "o",
	"KEY_P" => "p",
	"KEY_Q" => "q",
	"KEY_R" => "r",
	"KEY_S" => "s",
	"KEY_T" => "t",
	"KEY_U" => "u",
	"KEY_V" => "v",
	"KEY_W" => "w",
	"KEY_X" => "x",
	"KEY_Y" => "y",
	"KEY_Z" => "z",
	"KEY_F1" => "F1",
	"KEY_F2" => "F2",
	"KEY_F3" => "F3",
	"KEY_F4" => "F4",
	"KEY_F5" => "F5",
	"KEY_F6" => "F6",
	"KEY_F7" => "F7",
	"KEY_F8" => "F8",
	"KEY_F9" => "F9",
	"KEY_F10" => "F10",
	"KEY_F11" => "F11",
	"KEY_F12" => "F12",
);

while (<>) {
	($type, $code, $val) = /\((.*)\).*\((.*)\).* ([\d]+)/;

	next if $type ne "EV_KEY";

	print "Error: $type $code $val\n" if ! $key_map{$code};

	if ($val == 1) {
		print "xdotool keydown --delay 100 $key_map{$code}\n";
	} else {
		print "xdotool keyup --delay 100 $key_map{$code}\n";
	}
}


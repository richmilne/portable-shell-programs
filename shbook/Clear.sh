
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: Clear.sh
#

Clear() {
	#
	# NAME
	#	Clear - clear the terminal screen
	#
	# SYNOPSIS
	#	Clear
	#
	# DESCRIPTION
	#	This function will clear the terminal screen using
	#	either the tput(1) or clear(1) command.  If neither
	#	of these commands are available, 40 blank lines
	#	will be printed to clear the screen.
	#
	{ tput clear;  } 2>/dev/null  ||
	{ clear;       } 2>/dev/null  ||
	for i in 1 2 3 4 5 6 7 8 9 10 \
	         1 2 3 4 5 6 7 8 9 20 \
	         1 2 3 4 5 6 7 8 9 30 \
	         1 2 3 4 5 6 7 8 9 40
	do
		echo
	done
}

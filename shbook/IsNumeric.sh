
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: IsNumeric.sh
#

IsNumeric() {
	#
	# NAME
	#	IsNumeric - determine if a string is numeric
	#
	# SYNOPSIS
	#	IsNumeric string
	#
	# DESCRIPTION
	#	This function will return true (0) if the string
	#	contains a decimal, hexadecimal, or octal number;
	#	otherwise, it will return false (1).
	#
	if [ $# -ne 1 ]; then
		return 1
	fi

	expr "$1" + 1 >/dev/null 2>&1
	if [ $? -ge 2 ]; then
		return 1
	fi

	return 0
}

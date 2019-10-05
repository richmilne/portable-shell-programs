
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
		echo "Usage: IsNumeric string" 1>&2
		exit 1
	fi

	case "$1" in
		0[xX]* )
			# Hexadecimal
			echo "$1" | sed "s/^0[xX]//" |
				grep -q '^[a-fA-F0-9][a-fA-F0-9]*$'
			;;

		0* )	# Octal
			echo "$1" | grep -q '^[0-7][0-7]*$'
			;;

		* )	# Decimal
			echo "$1" | grep -q '^[0-9][0-9]*$'
			;;
	esac
}

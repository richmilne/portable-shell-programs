
#
# Copyright 1995, by Hewlett-Packard Company
#
# The code in this file is from the book "Portable Shell
# Programming" by Bruce Blinn, published by Prentice Hall.
# This file may be copied free of charge for personal,
# non-commercial use provided that this notice appears in
# all copies of the file.  There is no warranty, either
# expressed or implied, supplied with this code.
#

IsSuperuser() {
	case `id` in
		"uid=0("* )	return 0	;;
		* )		return 1	;;
	esac
}

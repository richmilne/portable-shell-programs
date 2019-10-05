
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: FullName.sh
#

FullName() {
	#
	# NAME
	#	FullName - print the full name of a file or directory
	#
	# SYNOPSIS
	#	FullName fileName | dirName
	#
	# DESCRIPTION
	#	This function will print the full name of the file
	#	or directory (the full name begins at the root
	#	directory).  If the file or directory does not
	#	exist, the name will be returned unchanged.
	#
	_CWD=`pwd`          # Save the current directory

	if [ $# -ne 1 ]; then
		echo "Usage: FullName filename | directory" 1>&2
		exit 1
	fi

	if [ -d $1 ]; then
		cd $1
		echo `/bin/pwd`
	elif [ -f $1 ]; then
		cd `dirname $1`
		echo `/bin/pwd`/`basename $1`
	else
		echo $1
	fi

	cd $_CWD
}


#
# Copyright (c) 2008 by Bruce Blinn
#
# File: Process.sh
#
# Functions
#	cpid()
#	pcommand()
#	pid()
#	pname()
#	ppid()
#	puser()
#

cpid() {
	#
	# NAME
	#	cpid - print the process IDs of the child processes
	#
	# SYNOPSIS
	#	cpid pid
	#
	# DESCRIPTION
	#	This function will print the process IDs of the
	#	child processes of the specified process.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: cpid pid" 1>&2
		exit 1
	fi

	_PID=$1
	UNIX95= ps -e -o "ppid pid" |
		awk '$1 ~ /^'$_PID'$/ {print $2}'
}

pcommand() {
	#
	# NAME
	#	pcommand - print the command executed by a process
	#
	# SYNOPSIS
	#	pcommand pid
	#
	# DESCRIPTION
	#	This function will print the command line (command
	#	name and parameters) being executed by the specified
	#	process.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: pcommand pid" 1>&2
		exit 1
	fi

	UNIX95= ps -p $1 -o "args="
}

pid() {
	#
	# NAME
	#	pid - find a process by name
	#
	# SYNOPSIS
	#	pid name
	#
	# DESCRIPTION
	#	This function will print the process IDs of all
	#	processes with the specified name.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: pid name" 1>&2
		exit 1
	fi

	_NAME=$1
	UNIX95= ps -e -o "pid comm" |
		awk '$2 ~ /^'$_NAME'$/ {print $1}'
}

pname() {
	#
	# NAME
	#	pname - print the name of a process
	#
	# SYNOPSIS
	#	pname pid
	#
	# DESCRIPTION
	#	This function will print the name of the specified
	#	process.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: pname pid" 1>&2
		exit 1
	fi

	_NAME=$(UNIX95= ps -p $1 -o "comm=")

	#
	# On some systems, when an interpreted file is executed, the
	# command name will be the name of the interpreter.  If the
	# command name is sh or ksh, try to find the name of the
	# shell script being executed.
	#
	if [ "$_NAME" = "sh" -o "$_NAME" = "ksh" ]; then
		_ARG=$(ps -p $1 -o "args="	|
			awk '{print $2}'	|
			sed "s/^\.\///")

		case "$_ARG" in
			"" )	echo "$_NAME"	;;
			-* )	echo "$_NAME"	;;
			* )	echo "$_ARG"	;;
		esac
	else
		echo "$_NAME"
	fi
}

ppid() {
	#
	# NAME
	#	ppid - print the process ID of the parent
	#
	# SYNOPSIS
	#	ppid pid
	#
	# DESCRIPTION
	#	This function will print the process ID of the
	#	parent process of the specified process.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: ppid pid" 1>&2
		exit 1
	fi

	UNIX95= ps -p $1 -o "ppid="
}

powner() {
	#
	# NAME
	#	powner - print the owner of a process
	#
	# SYNOPSIS
	#	powner pid
	#
	# DESCRIPTION
	#	This function will print the name of the owner
	#	of the specified process.
	#
	if [ $# -ne 1 ]; then
		echo "Usage: powner pid" 1>&2
		exit 1
	fi

	UNIX95= ps -p $1 -o "user=" | sed 's/ *$//'
}

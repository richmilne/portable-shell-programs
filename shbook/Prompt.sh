
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: Prompt.sh
#

Prompt() {
	#
	# NAME
	#	Prompt - print a message without a newline
	#
	# SYNOPSIS
	#	Prompt [message]
	#
	# DESCRIPTION
	#	This function prints the message to the standard
	#	output without a newline at the end of the line.
	#
	#	If the message is not specified, "> " will be
	#	printed.
	#
	if [ "`echo -n`" = "-n" ]; then
		echo "${@-> }\c"
	else
		echo -n "${@-> }"
	fi
}


#
# Copyright (c) 2008 by Bruce Blinn
#
# File: tty.sh
#
# Variables
#	BLUE
#	GREEN
#	RED
#	YELLOW
#
#	BLINK
#	BOLD
#	INVERSE
#	NORMAL
#	UNDERLINE
#
# Functions
#	IndentTo()
#	PrintBlue()
#	PrintBold()
#	PrintGreen()
#	PrintRed()
#	PrintYellow()
#	Spinner()
#

RED=$(		printf "\033[31m")
GREEN=$(	printf "\033[32m")
YELLOW=$(	printf "\033[33m")
BLUE=$(		printf "\033[34m")

BOLD=$(		printf "\033[1m")
UNDERLINE=$(	printf "\033[4m")
BLINK=$(	printf "\033[5m")
INVERSE=$(	printf "\033[7m")
NORMAL=$(	printf "\033[0m")

IndentTo () {
	#
	# SYNOPSIS
	#	IndentTo column
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will move the cursor to the indicated
	#	column; otherwise, it will print one space.
	#
	_COL=$1

	if [ -t 1 ]; then
		printf "\033[${_COL}G"
	else
		printf " "
	fi
}

PrintBlue () {
	#
	# SYNOPSIS
	#	PrintBlue message
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will print the message using blue
	#	characters; otherwise, it will simply print the
	#	message.
	#
	if [ -t 1 ]; then
		printf "$BLUE$@$NORMAL\n"
	else
		printf "$@\n"
	fi
}

PrintBold () {
	#
	# SYNOPSIS
	#	PrintBold message
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will print the message using bold
	#	characters; otherwise, it will simply print the
	#	message.
	#
	if [ -t 1 ]; then
		printf "$BOLD$@$NORMAL\n"
	else
		printf "$@\n"
	fi
}

PrintGreen () {
	#
	# SYNOPSIS
	#	PrintGreen message
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will print the message using green
	#	characters; otherwise, it will simply print the
	#	message.
	#
	if [ -t 1 ]; then
		printf "$GREEN$@$NORMAL\n"
	else
		printf "$@\n"
	fi
}

PrintRed () {
	#
	# SYNOPSIS
	#	PrintRed message
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will print the message using red
	#	characters; otherwise, it will simply print the
	#	message.
	#
	if [ -t 1 ]; then
		printf "$RED$@$NORMAL\n"
	else
		printf "$@\n"
	fi
}

PrintYellow () {
	#
	# SYNOPSIS
	#	PrintYellow message
	#
	# DESCRIPTION
	#	If the standard output is connected to a terminal,
	#	this function will print the message using yellow
	#	characters; otherwise, it will simply print the
	#	message.
	#
	if [ -t 1 ]; then
		printf "$YELLOW$@$NORMAL\n"
	else
		printf "$@\n"
	fi
}

_Spinner_Delay() {
	#
	# SYNOPSIS
	#	_Spinner_Delay
	#
	# DESCRIPTION
	#	This function is a sub-function used by the Spinner
	#	function.  It wastes time so the spinner rotates at
	#	the correct speed.
	#
	_CNT=5000

	while [ $_CNT -gt 0 ]
	do
		_CNT=$((_CNT - 1))
	done
}

Spinner() {
	#
	# SYNOPSIS
	#	Spinner
	#
	# DESCRIPTION
	#	This function will not return; therefore, it should
	#	be executed in the background and killed when it is
	#	no longer needed.
	#
	#	If the standard output is connected to a terminal,
	#	this function will print a spinning character at the
	#	current location of the cursor.  This gives the user
	#	an indication that the system is alive, but does
	#	very little else.
	#
	#	If the standard output is not connected to a
	#	terminal, this function will sleep forever.  This
	#	allows the code that uses this function to call it
	#	the same way regardless whether the standard output
	#	is connected to a terminal or not.
	#
	#	NOTE: This function uses the CPU while it is
	#	executing.  Ideally, the _Spinner_Delay function
	#	would be replaced with a sleep command that is
	#	capable of a sleep period of less than one second.
	#
	if [ -t 1 ]; then
		while :
		do
			printf    '/\b';	_Spinner_Delay
			printf -- '-\b';	_Spinner_Delay
			printf    '\\\b';	_Spinner_Delay
			printf    '|\b';	_Spinner_Delay
		done
	else
		sleep 9999
	fi
}

return

#
# To test these procedures, comment out the return command above and execute
# this file as a shell command.  For example:
#
#	$ sh tty.sh
#

PrintBlue Blue
PrintGreen Green
PrintRed Red
PrintYellow Yellow
PrintBold Bold

printf foo
IndentTo 10
printf "bar\n"

printf "Test ${RED}red${NORMAL} text.\n"
printf "Test ${GREEN}green${NORMAL} text.\n"
printf "Test ${YELLOW}yellow${NORMAL} text.\n"
printf "Test ${BLUE}blue${NORMAL} text.\n"

printf "Test ${BOLD}bold${NORMAL} text.\n"
printf "Test ${UNDERLINE}underline${NORMAL} text.\n"
printf "Test ${BLINK}blink${NORMAL} text.\n"
printf "Test ${INVERSE}inverse${NORMAL} text.\n"
printf "Test ${BOLD}${INVERSE}${UNDERLINE}${BLUE}bold, inverse, underline blue${NORMAL} text.\n"

printf "Test spinner "
Spinner &
PID=$!
sleep 5
kill $PID

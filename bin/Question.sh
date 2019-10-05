
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: Question.sh
#

Question() {
	#
	# NAME
	#	Question - ask a question
	#
	# SYNOPSIS
	#	Question question [default [helpMessage]]
	#
	# DESCRIPTION
	#	This function will print a question and return the
	#	answer entered by the user in the global variable
	#	ANSWER.
	#
	#	If a default answer is specified, it will be
	#	enclosed in square brackets and appended to the
	#	question.  The question will then be followed with
	#	a question mark and printed without a newline.
	#
	#	The default answer and help message are optional;
	#	however, if the help message is specified and the
	#	default answer is not needed, an empty string
	#	(i.e., "") must be passed in its place.
	#
	#	If the user presses enter without entering an
	#	answer, the default answer will be returned if one
	#	is available; otherwise, the question will be
	#	repeated.
	#
	#	The user may enter a question mark to receive the
	#	help message if one is available.  After the help
	#	message is printed, the question will be repeated.
	#
	#	The user may enter "quit" or "q" to exit the shell
	#	script that called this function.  This answer is
	#	not case sensitive.
	#
	#	The user may enter "!command", where "command" is
	#	the name of a command to be executed.  After the
	#	command is executed, the question will be repeated.
	#
	#	The user may enter "-x" or "+x" to cause the
	#	debugging option in the shell to be turned on or off
	#	respectively.
	#
	#	The user may enter "yes", "y", "no", or, "n", in
	#	which case "yes" or "no" will be returned.  This
	#	answer is not sensitive.
	#
	#	Any other answer will be returned exactly as it was
	#	entered by the user.
	#
	_QUESTION=$1
	_DEFAULT=$2
	_HELPMSG=$3
	ANSWER=			# Global variable for answer

	if [ $# -lt 1 -o $# -gt 3 ]; then
		echo "Usage: Question question" \
		     "[default [helpmessage]]" 1>&2
		exit 1
	fi

	if [ "$_DEFAULT" = "" ]; then
		_QUESTION="$_QUESTION? "
	else
		_QUESTION="$_QUESTION [$_DEFAULT]? "
	fi

	while :
	do
		if [ "$(echo -n)" = "-n" ]; then
			echo "$_QUESTION\c"
		else
			echo -n "$_QUESTION"
		fi
		read ANSWER
		case $(echo "$ANSWER" | tr '[:upper:]' '[:lower:]') in
			"" )	if [ "$_DEFAULT" != "" ]; then
					ANSWER=$_DEFAULT
					break
				fi
				;;

			yes | y )
				ANSWER=yes
				break
				;;

			no | n )
				ANSWER=no
				break
				;;

			quit | q )
				exit 1
				;;

			+x | -x )
				set $ANSWER
				;;

			!* )	eval ${ANSWER#\!}
				;;

			"?" )	echo ""
				if [ "$_HELPMSG" = "" ]; then
					echo "No help available."
				else
					echo "$_HELPMSG"
				fi
				echo ""
				;;

			* )	break
				;;
		esac
	done
}

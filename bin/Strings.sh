
#
# Copyright (c) 2008 by Bruce Blinn
#
# File: Strings.sh
#
# Functions
#	StrCaseCmp	 compare two strings
#	StrCaseEqual	 compare two strings for equality
#	StrCaseIsSubstr	 check for a substring
#	StrCaseNotEqual	 compare two strings for inequality
#	StrCmp		 compare two strings
#	StrDownshift	 downshift a string
#	StrEmpty	 check if string is empty
#	StrEqual	 compare two strings for equality
#	StrFill		 append characters to a string
#	StrIsSubstr	 check for a substring
#	StrLen		 return the length of a string
#	StrNotEmpty	 check if string is not empty
#	StrNotEqual	 compare two strings for inequality
#	StrReplace	 replace one string with another
#	StrSubstr	 extract a substring
#	StrUpshift	 upshift a string
#

StrCaseCmp() {
	#
	# NAME
	#	StrCaseCmp - compare two strings
	#
	# SYNOPSIS
	#	StrCaseCmp string1 string2
	#
	# DESCRIPTION
	#	This function is the same as StrCmp except the
	#	case of the strings are ignored.
	#
	#	This function returns a status of 0, 1, or 2 to
	#	indicate whether string1 is lexicographically
	#	equal to, greater than, or less than string2
	#	respectively.
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrCaseCmp string1 string2" 1>&2
		exit 1
	fi

	_STR1=$(StrDownshift "$1")
	_STR2=$(StrDownshift "$2")

	StrCmp "$_STR1" "$_STR2"
}

StrCaseEqual() {
	#
	# NAME
	#	StrCaseEqual - compare two strings for equality
	#
	# SYNOPSIS
	#	StrCaseEqual string1 string2
	#
	# DESCRIPTION
	#	This function is the same as StrEqual except the
	#	case of the strings are ignored.
	#
	#	This function returns true (0) if string1 is equal
	#	to string2; otherwise, it returns false (1).
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrCaseEqual string1 string2" 1>&2
		exit 1
	fi

	_STR1=$(StrDownshift "$1")
	_STR2=$(StrDownshift "$2")

	test "$_STR1" = "$_STR2"
}

StrCaseIsSubstr() {
	#
	# NAME
	#	StrCaseIsSubstr - check for a substring
	#
	# SYNOPSIS
	#	StrCaseIsSubstr string substring
	#
	# DESCRIPTION
	#	This function is the same as StrIsSubstr except the
	#	case of the string and substring are ignored.
	#
	#	This function returns true (0) if the second
	#	parameter is a substring of the first; otherwise, it
	#	returns false (1).
	#
	#	The substring can be any regular expression accepted
	#	by the grep(1) command.
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrCaseIsSubstr string substring" 1>&2
		exit 1
	fi

	_STR="$1"
	_SUBSTR="$2"

	echo "$_STR" | grep -qi -- "$_SUBSTR"
}

StrCaseNotEqual() {
	#
	# NAME
	#	StrCaseNotEqual - compare two strings for inequality
	#
	# SYNOPSIS
	#	StrCaseNotEqual string1 string2
	#
	# DESCRIPTION
	#	This function is the same as StrCaseNotEqual except
	#	the case of the strings are ignored.
	#
	#	This function returns true (0) if string1 is not
	#	equal to string2; otherwise, it returns false (1).
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrCaseNotEqual string1 string2" 1>&2
		exit 1
	fi

	_STR1=$(StrDownshift "$1")
	_STR2=$(StrDownshift "$2")

	test "$_STR1" != "$_STR2"
}

StrCmp() {
	#
	# NAME
	#	StrCmp - compare two strings
	#
	# SYNOPSIS
	#	StrCmp string1 string2
	#
	# DESCRIPTION
	#	This function returns a status of 0, 1, or 2 to
	#	indicate whether string1 is lexicographically
	#	equal to, greater than, or less than string2
	#	respectively.
	#
	_TMP=

	if [ $# -ne 2 ]; then
		echo "Usage: StrCmp string1 string2" 1>&2
		exit 1
	fi

	if [ "$1" = "$2" ]; then
		return 0
	else
		_TMP=$({ echo "$1"; echo "$2"; } |
			sort |
			sed -n '1p')

		if [ "$_TMP" = "$1" ]; then
			return 2
		else
			return 1
		fi
	fi
}

StrDownshift() {
	#
	# NAME
	#	StrDownshift - downshift a string
	#
	# SYNOPSIS
	#	StrDownshift string
	#
	# DESCRIPTION
	#	This function will downshift the alphabetic
	#	characters in the string.  Nonalphabetic characters
	#	will not be affected.
	#

	echo "$*" | tr '[:upper:]' '[:lower:]'
}

StrEmpty() {
	#
	# NAME
	#	StrEmpty - check if string is empty
	#
	# SYNOPSIS
	#	StrEmpty string
	#
	# DESCRIPTION
	#	This function returns true (0) if the string is
	#	empty; otherwise, it returns false (1).
	#

	test "$*" = ""
}

StrEqual() {
	#
	# NAME
	#	StrEqual - compare two strings for equality
	#
	# SYNOPSIS
	#	StrEqual string1 string2
	#
	# DESCRIPTION
	#	This function returns true (0) if string1 is equal
	#	to string2; otherwise, it returns false (1).
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrEqual string1 string2" 1>&2
		exit 1
	fi

	test "$1" = "$2"
}

StrFill() {
	#
	# NAME
	#	StrFill - append characters to a string
	#
	# SYNOPSIS
	#	StrFill [-f fillChar] length [string ...]
	#
	# DESCRIPTION
	#	This command will append the fill character to the
	#	string until the string is the specified length.
	#
	#	If the fill character is not specified, a space will
	#	be used.
	#
	#	If the string is not empty, at least one fill
	#	character will be appended to the string even if it
	#	is already longer than the specified length.
	#
	_USAGE="StrFill [-f fillChar] length [string ...]"
	_FILL_CHAR=" "
	_NEW_LEN=
	_CUR_LEN=
	_STR=

	while [ $# -gt 0 ]
	do
		case $1 in
			-f)	_FILL_CHAR=$2
				shift 2
				;;
			-f*)	_FILL_CHAR=${1#??}
				shift
				;;
			--)	shift
				break
				;;
			-*)	echo "$_USAGE" 1>&2
				exit 1
				;;
			*)	break
				;;
		esac
	done

	if [ $# -lt 1 ]; then
		echo "$_USAGE" 1>&2
		return 1
	fi

	_NEW_LEN=$1
	shift
	_STR="$*"

	if [ "$_STR" != "" ]; then
		_STR="$_STR$_FILL_CHAR"
	fi

	_CUR_LEN=${#_STR}
	while [ $_CUR_LEN -lt $_NEW_LEN ]
	do
		_STR="$_STR$_FILL_CHAR"
		_CUR_LEN=$((_CUR_LEN + 1))
	done

	echo "$_STR"
}

StrIsSubstr() {
	#
	# NAME
	#	StrIsSubstr - check for a substring
	#
	# SYNOPSIS
	#	StrIsSubstr string substring
	#
	# DESCRIPTION
	#	This function returns true (0) if the second
	#	parameter is a substring of the first; otherwise, it
	#	returns false (1).
	#
	#	The substring can be any regular expression accepted
	#	by the grep(1) command.
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrIsSubstr string substring" 1>&2
		exit 1
	fi

	_STR="$1"
	_SUBSTR="$2"

	echo "$_STR" | grep -q "$_SUBSTR"
}

StrLen() {
	#
	# NAME
	#	StrLen - return the length of a string
	#
	# SYNOPSIS
	#	StrLen string
	#
	# DESCRIPTION
	#	This command will return the number of characters
	#	in the string.
	#
	_STR="$*"

	echo ${#_STR}
}

StrNotEmpty() {
	#
	# NAME
	#	StrNotEmpty - check if string is not empty
	#
	# SYNOPSIS
	#	StrNotEmpty string
	#
	# DESCRIPTION
	#	This function returns true (0) if the string is not
	#	empty; otherwise, it returns false (1).
	#

	test "$*" != ""
}

StrNotEqual() {
	#
	# NAME
	#	StrNotEqual - compare two strings for inequality
	#
	# SYNOPSIS
	#	StrNotEqual string1 string2
	#
	# DESCRIPTION
	#	This function returns true (0) if string1 is not
	#	equal to string2; otherwise, it returns false (1).
	#
	if [ $# -ne 2 ]; then
		echo "Usage: StrNotEqual string1 string2" 1>&2
		exit 1
	fi

	test "$1" != "$2"
}

StrReplace() {
	#
	# NAME
	#	StrReplace - replace one string with another
	#
	# SYNOPSIS
	#	StrReplace string oldSubstring newSubstring
	#
	# DESCRIPTION
	#	This function will replace one substring with
	#	another substring.  The new string will be
	#	written to the standard output.
	#
	#	The old substring can be any regular expression
	#	accepted by the sed(1) command.
	#
	#	If there is more than one instance of the old
	#	substring, they will all be replaced.  If the
	#	original string does not contain the old
	#	substring, the original string will be returned
	#	unchanged.
	#
	_STR=$1
	_OLD=$2
	_NEW=$3
	_SEP=
	_CHR=

	if [ $# -ne 3 ]; then
		echo "Usage: StrReplace string oldSubstring" \
		     "newSubstring" 1>&2
		exit 1
	fi

	for _CHR in '/' ';' '@'
	do
		case "$_OLD$_NEW" in
			*$_CHR* ) ;;
			* )	_SEP=$_CHR
				break
				;;
		esac
	done
	if [ "$_SEP" = "" ]; then
		echo "StrReplace: Cannot find a separator." 1>&2
		return 1
	fi

	echo "$_STR" | sed "s${_SEP}$_OLD${_SEP}$_NEW${_SEP}g"
}

StrSubstr() {
	#
	# NAME
	#	StrSubstr - extract a substring
	#
	# SYNOPSIS
	#	StrSubstr string position length
	#
	# DESCRIPTION
	#	This command will return the part of the string
	#	indicated by the specified position and length.
	#	The position of the first character in the string
	#	is one (1).
	#
	if [ $# -ne 3 ]; then
		echo "Usage: StrSubstr string position length" 1>&2
		exit 1
	fi

	_STR=$1
	_POS=$2
	_LEN=$3

	echo "$_STR" | awk '{print substr($0, '$_POS', '$_LEN')}'
}

StrUpshift() {
	#
	# NAME
	#	StrUpshift - upshift a string
	#
	# SYNOPSIS
	#	StrUpshift string
	#
	# DESCRIPTION
	#	This function will upshift the alphabetic
	#	characters in the string.  Nonalphabetic characters
	#	will not be affected.
	#

	echo "$*" | tr '[:lower:]' '[:upper:]'
}

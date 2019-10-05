
#
# File: FullName.sh
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
# CHANGES
#    19 Jul 00  Use /bin/pwd instead of shell built-in.  This
#               will print the real path vs. the path you used
#               to arrive there when symbolic links are
#               traversed.
#

FullName() {
     #
     # NAME
     #    FullName - return full name of a file or directory
     #
     # SYNOPSIS
     #    FullName filename | directory
     #
     # DESCRIPTION
     #    This function will return the full name of the
     #    file or directory (the full name begins at the
     #    root directory).  The full name will be written
     #    to the standard output.  If the file or directory
     #    does not exist, the name will be returned
     #    unchanged.
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

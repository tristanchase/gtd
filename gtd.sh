#!/bin/bash
#
# gtd.sh
#
# Tristan M. Chase
# Created: Mon 2018-04-09 01:24:12
#
# Description: 
#-----------------------------------

# Variables


# Dependencies


# Process

# Remember starting directory
startdir="`pwd`"

# Change to gtd directory
cd $GTDDIR # This is set in my .zshrc

# Ideas (see $GTDDIR/guidelines.txt)

# update tags projects done canceled (using sed and grep combo; examples in todo.sh)

# take input from command line
#   gtd -t "blah"
# and nudge to correct file

#grep -n "^ *\*" *.txt | vim -
if [[ -e todos.txt ]]; then
	rm todos.txt
fi

grep -n "^ *\*" *.txt > todos.txt
vim todos.txt

# Change back to starting directory
cd $startdir

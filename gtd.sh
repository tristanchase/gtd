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

# We don't want to search this file; it is generated by the grep statement
if [[ -e todos.txt ]]; then
	rm todos.txt
fi

# Update #tags @Locations projects done canceled (using sed and grep combo; examples in todo.sh)
grep -o '#[a-zA-Z0-9-]\+*' *.txt | sed -n 's/\(.*:\)\(#.*\)/\2/p' | sort | uniq > tags
grep -o '@[a-zA-Z0-9-]\+*' *.txt | sed -n 's/\(.*:\)\(@.*\)/\2/p' | sort | uniq > locations

# Search through .txt files for items marked with a "*" 
grep -n "^ *\*" *.txt | sed 's:\*:\t\t\*:' > todos.txt

# Open the file for exploitation
vim todos.txt

# Change back to starting directory
cd $startdir

# Ideas (see $GTDDIR/roadmap/roadmap.txt)


# take input from command line
#   gtd -t "blah"
# and nudge to correct file


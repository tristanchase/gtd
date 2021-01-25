#!/usr/bin/env bash

#-----------------------------------
# Usage Section

#<usage>
#//Usage: gtd [ {-d|--debug} ] [ {-h|--help} | <options>] [<arguments>]
#//Description: Get things done!
#//Examples: gtd foo; gtd --debug bar
#//Options:
#//	-d --debug	Enable debug mode
#//	-h --help	Display this help message
#</usage>

#<created>
# Created: Mon 2018-04-09 01:24:12
# Tristan M. Chase <tristan.m.chase@gmail.com>
#</created>

#<depends>
# Depends on:
#  list
#  of
#  dependencies
#</depends>

#-----------------------------------
# TODO Section

#<todo>
# * Insert script
# * Clean up stray ;'s
# * Modify command substitution to "$(this_style)"
# * Rename function_name() to function __function_name__ /\w+\(\)
# * Rename $variables to "${_variables}" /\$\w+/s+1 @v vEl,{n
# * Check that _variable="variable definition" (make sure it's in quotes)
# * Update usage, description, and options section
# * Update dependencies section

# DONE

#</todo>

#-----------------------------------
# License Section

#<license>
# Put license here
#</license>

#-----------------------------------
# Runtime Section

#<main>
# Initialize variables
#_temp="file.$$"

# List of temp files to clean up on exit (put last)
#_tempfiles=("${_temp}")

# Put main script here
function __main_script__ {

# Remember starting directory
_startdir="$(pwd)"

# Change to gtd directory
export _GTDDIR=$HOME/gtd
mkdir -p $_GTDDIR
cd $_GTDDIR

# We don't want to search this file; it is generated by the grep statement
if [[ -e todos.txt ]]; then
	rm todos.txt
fi

# Update #tags @Locations projects done canceled (using sed and grep combo; examples in todo.sh)
grep -o '#[a-zA-Z0-9-]\+*' *.txt | sed -n 's/\(.*:\)\(#.*\)/\2/p' | sort -u > tags
grep -o '@[a-zA-Z0-9-]\+*' *.txt | sed -n 's/\(.*:\)\(@.*\)/\2/p' | sort -u > locations

# Search through .txt files for items marked with a "*"
grep -n '^\s\+*\*' *.txt | sed 's/\*/    \*/' > todos.txt

# Open the file for exploitation
vim todos.txt

# Change back to starting directory
cd $_startdir

# Ideas (see $_GTDDIR/roadmap/roadmap.txt)


# take input from command line
#   gtd -t "blah"
# and nudge to correct file

} #end __main_script__
#</main>

#-----------------------------------
# Local functions

#<functions>
function __local_cleanup__ {
	:
}
#</functions>

#-----------------------------------
# Source helper functions
for _helper_file in functions colors git-prompt; do
	if [[ ! -e ${HOME}/."${_helper_file}".sh ]]; then
		printf "%b\n" "Downloading missing script file "${_helper_file}".sh..."
		sleep 1
		wget -nv -P ${HOME} https://raw.githubusercontent.com/tristanchase/dotfiles/master/"${_helper_file}".sh
		mv ${HOME}/"${_helper_file}".sh ${HOME}/."${_helper_file}".sh
	fi
done

source ${HOME}/.functions.sh

#-----------------------------------
# Get some basic options
# TODO Make this more robust
#<options>
if [[ "${1:-}" =~ (-d|--debug) ]]; then
	__debugger__
elif [[ "${1:-}" =~ (-h|--help) ]]; then
	__usage__
fi
#</options>

#-----------------------------------
# Bash settings
# Same as set -euE -o pipefail
#<settings>
#set -o errexit
set -o nounset
set -o errtrace
#set -o pipefail
IFS=$'\n\t'
#</settings>

#-----------------------------------
# Main Script Wrapper
if [[ "${BASH_SOURCE[0]}" = "${0}" ]]; then
	trap __traperr__ ERR
	trap __ctrl_c__ INT
	trap __cleanup__ EXIT

	__main_script__


fi

exit 0

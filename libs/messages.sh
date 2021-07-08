#!/bin/sh

## See LICENSE for License information
## Simple POSIX script library that provides a nicer logging interface than
## using `echo -e` or `printf` with ANSI control codes for colorization

__msg_istty=0
__msg_myname="${0##*/}"
__msg_myname="${__msg_myname%.sh}"
__msg_libname="messages"

__msg_detect_tty() {
	## Respect NO_COLOR if set, though if set as 'NO_COLOR=""' we have no efficient
	## way of differentiating it from not being set
	if [ "${#NO_COLOR}" -eq 0 ]
	then
		__msg_istty=0
		return "${__msg_istty}"
	fi
	if tty -s 2<&- >/dev/null
	then
		__msg_istty=1
	fi
}

## Only "public" function in this library
msg() {
	:
}

usage() {
	printf "[%s]: %s\n"\
		"${__msg_libname}" "A formatted message/logging library for POSIX-compliant shell scripts"
}

## Parse options if given, else do nothing, use of `if` block to prevent returning 1 when sourced
if [ "${#}" -ne 0 ]
then
	__msg_main "${@}"
else
	__msg_detect_tty ## Initialize __msg_istty so it never has to be calculated again
fi

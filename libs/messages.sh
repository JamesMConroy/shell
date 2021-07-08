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

# set colors based on tput if avalable
if tput -V > /dev/null 2>&1
then
	__red=$(tput setaf 1)
	__blue=$(tput setaf 4)
	__NC=$(tput sgr0)
else
	__red="\e[31m"
	__blue="\e[34m"
	__NC="\e[0m"
fi

# Prefix strings space padded to be 8 spaces long
__no_pre="        "
__info="+++++++ "
__warn="warning "
__error="ERROR   "
__fatal="FATAL!! "


# log takes 2 arguments, a severity and a string in that order
# severity is an intiger from 1 to 5
# if log does not reconsie the severity it passes all argumets to __msg
log() {
	case "${1}" in
		1) shift; prefix="${__no_pre}"; color="${__NC}"  ; __msg "${@}" ;;
		2) shift; prefix="${__info}"  ; color="${__NC}"  ; __msg "${@}" ;;
		3) shift; prefix="${__warn}"  ; color="${__blue}"; __msg "${@}" ;;
		4) shift; prefix="${__error}" ; color="${__red}" ; __err "${@}" ;;
		5) shift; prefix="${__fatal}" ; color="${__red}" ; __die "${@}" ;;
		*) prefix="$__no_pre" ; color="${__NC}" ; __msg "${@}" ;;
	esac
}

__msg() {
	if [ ${__msg_istty} -eq 0 ]
	then
		printf "%s%s[%s] %s%s\n" \
			"${color}" "${prefix}" "${__msg_myname}" "${1}" "${__NC}"
	else
		printf "%s[%s] %s\n" "${prefix}" "${__msg_myname}" "${1}"
	fi
	unset prefix; unset color
}

__err() {
	__msg "${1}" 2>&1
}

__die() {
	__err "${1}"
	exit 1
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

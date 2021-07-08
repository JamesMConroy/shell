#!/bin/sh

## See the LICENSE file for license information

## Prints the length of the first argument, all other arguments are ignored
strlen() {
	echo "${#1}"
}

strlen "${@}"

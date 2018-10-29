#!/usr/bin/env bash
function printargs() {
	for var in "$@"
	do
		echo "Argument: ${var}"
	done
	echo "Count: $#"
}

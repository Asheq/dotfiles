function printargs() {
	local arg
	for arg in "$@"
	do
		echo "Argument: ${arg}"
	done
	echo "Count: $#"
}

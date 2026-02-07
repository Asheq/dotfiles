#!/bin/sh

# Usage: path_remove <path> <variable>
# Example: path_remove ~/bin PATH
# ==============================================================================
path_remove() {
	dir_to_remove=$1
	var=${2:-PATH}

	# Guard against empty path
	if [ -z "$dir_to_remove" ]; then
		return 1
	fi

	# Normalize trailing slash
	dir_to_remove=${dir_to_remove%/}

	newpath=
	first=1

	eval "set -- \$(printf '%s\n' \"\$$var\" | tr ':' '\n')"

	for dir; do
		if [ "$dir" != "$dir_to_remove" ]; then
			if [ $first -eq 1 ]; then
				newpath="$dir"
				first=0
			else
				newpath="$newpath:$dir"
			fi
		fi
	done

	export "$var=$newpath"
}

# Usage: path_prepend <path> <variable>
# Example: path_prepend ~/bin PATH
# ==============================================================================
path_prepend() {
	dir_to_prepend=$1
	var=${2:-PATH}

	# Guard against empty path
	if [ -z "$dir_to_prepend" ]; then
		return 1
	fi

	# Normalize trailing slash
	dir_to_prepend=${dir_to_prepend%/}

	# Call the path_remove function to ensure we don't have duplicates
	path_remove "$dir_to_prepend" "$var"

	# Get the current value of the variable (e.g., $PATH)
	eval current_value="\$$var"

	# Prepend the directory to the value of the variable
	if [ -n "$current_value" ]; then
		new_value="$dir_to_prepend:$current_value"
	else
		new_value="$dir_to_prepend"
	fi

	# Export the updated variable
	export "$var=$new_value"
}

# Usage: path_append <path> <variable>
# Example: path_append ~/bin PATH
# ==============================================================================
path_append() {
	dir_to_append=$1
	var=${2:-PATH}

	# Guard against empty path
	if [ -z "$dir_to_append" ]; then
		return 1
	fi

	# Normalize trailing slash
	dir_to_append=${dir_to_append%/}

	# Call the path_remove function to ensure we don't have duplicates
	path_remove "$dir_to_append" "$var"

	# Get the current value of the variable (e.g., $PATH)
	eval current_value="\$$var"

	# Append the directory to the value of the variable
	if [ -n "$current_value" ]; then
		new_value="$current_value:$dir_to_append"
	else
		new_value="$dir_to_append"
	fi

	# Export the updated variable
	export "$var=$new_value"
}

# Usage: safe_source <filename>
# ==============================================================================
safe_source () {
	if [ -r "$1" ]; then
		# shellcheck source=/dev/null
		. "$1"
		return 0
	fi
	return 1
}

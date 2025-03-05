# NOTE: This file should be 100% POSIX-compliant

# Usage: pathremove <path> <variable>
# Example: pathremove ~/bin PATH
# ==============================================================================
pathremove() {
    dir_to_remove=$1
    var=${2:-PATH}
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

    eval "export $var=\"$newpath\""
}

# Usage: pathprepend <path> <variable>
# Example: pathprepend ~/bin PATH
# ==============================================================================
pathprepend() {
    dir_to_prepend=$1
    var=${2:-PATH}

    # Call the pathremove function to ensure we don't have duplicates
    pathremove "$dir_to_prepend" "$var"

    # Get the current value of the variable (e.g., $PATH)
    eval current_value="\$$var"

    # Prepend the directory to the value of the variable
    if [ -n "$current_value" ]; then
        new_value="$dir_to_prepend:$current_value"
    else
        new_value="$dir_to_prepend"
    fi

    # Export the updated variable
    eval "export $var=\"$new_value\""
}

# Usage: pathappend <path> <variable>
# Example: pathappend ~/bin PATH
# ==============================================================================
pathappend() {
    dir_to_append=$1
    var=${2:-PATH}

    # Call the pathremove function to ensure we don't have duplicates
    pathremove "$dir_to_append" "$var"

    # Get the current value of the variable (e.g., $PATH)
    eval current_value="\$$var"

    # Append the directory to the value of the variable
    if [ -n "$current_value" ]; then
        new_value="$current_value:$dir_to_append"
    else
        new_value="$dir_to_append"
    fi

    # Export the updated variable
    eval "export $var=\"$new_value\""
}

# Usage: ssource <filename>
# ==============================================================================
ssource () {
    if [ -r "$1" ]; then
        # shellcheck source=/dev/null
        . "$1"
    fi
}

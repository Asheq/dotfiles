# Original source: https://bitbucket.org/flowblok/shell-startup/src/default/.shell/env_functions

# Usage: pathremove <path> <variable>
# Example: pathremove ~/bin PATH
# ==============================================================================
pathremove () {
    local IFS=':'
    local newpath
    local dir
    local var=${2:-PATH}
    for dir in ${!var}; do
        IFS=''
        if [ "$dir" != "$1" ]; then
            newpath=$newpath:$dir
        fi
    done
    export $var=${newpath#:}
}

# Usage: pathprepend <path> <variable>
# Example: pathprepend ~/bin PATH
# ==============================================================================
pathprepend () {
    pathremove "$1" "$2"
    local var="${2:-PATH}"
    local value=${!var}
    export ${var}="${1}${value:+:${value}}"
}

# Usage: pathappend <path> <variable>
# Example: pathappend ~/bin PATH
# ==============================================================================
pathappend () {
    pathremove "${1}" "${2}"
    local var=${2:-PATH}
    local value=${!var}
    export $var="${value:+${value}:}${1}"
}

# Usage: ssource <filename>
# ==============================================================================
ssource () {
    if [ -r "$1" ]; then
        # shellcheck source=/dev/null
        . "$1"
    fi
}

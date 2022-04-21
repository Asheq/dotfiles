# Basic file maangement
# ==============================================================================

if command -v exa &> /dev/null; then
    alias l='exa -F'
    alias la='exa -FA'
    alias ll='exa -Falh'
else
    alias l='ls --color -F'
    alias la='ls --color -FA'
    alias ll='ls --color -Falh'
fi

if command -v open &> /dev/null; then
    alias o='open'
elif command -v xdg-open &> /dev/null; then
    alias o='xdg-open'
fi

alias v='nvim'

# git
# ==============================================================================
alias g='git'
# TODO: Add completions via __git_complete
# command -v __git_complete && __git_complete g __git_main

# npm
# ==============================================================================
alias n='npm'
complete -o default -F _npm_completion n

# React Native development
# ==============================================================================
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'

# Bell
# ==============================================================================
# TODO: Is the second one cross-platform?
alias bell=$'echo ; osascript -e \'display notification "Bell rang from kitty terminal"\''
# alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

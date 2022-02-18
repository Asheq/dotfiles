# Basic file maangement
# ==============================================================================

if command -v exa &> /dev/null; then
    alias l='exa -F'
    alias la='exa -Fa'
    alias ll='exa -Flah'
else
    alias l='ls --color'
    alias la='ls --color -Fa'
    alias ll='ls --color -Flah'
fi

if command -v open &> /dev/null; then
    alias o='open'
elif command -v xdg-open &> /dev/null; then
    alias o='xdg-open'
fi

alias v='nvim'
alias c='cd'

# git
# ==============================================================================
alias g='git'
# TODO: Add __git_complete
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
alias bell=$'echo ; osascript -e \'display notification "Bell rang from kitty terminal"\''

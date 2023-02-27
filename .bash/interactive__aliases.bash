# Basic file management
# ==============================================================================

if command -v exa &> /dev/null; then
    alias l='exa -F'
    alias la='exa -Fa'
    alias ll='exa -Falh'
else
    alias l='ls --color -F'
    alias la='ls --color -F'
    alias ll='ls --color -Falh'
fi

if command -v open &> /dev/null; then
    alias o='open'
elif command -v xdg-open &> /dev/null; then
    alias o='xdg-open'
fi

alias c='cd'

alias v='nvim'

alias box='cd ~/Library/CloudStorage/Box-Box/me/'
alias doc='cd ~/Documents/'
alias notes='cd ~/Documents/notes/'
alias todo='cd ~/Documents/todo/'

alias s="kitty +kitten ssh"

alias xp="~/.xprofile"

# git
# ==============================================================================
alias g='git'
# TODO: Add completions for g via __git_complete
# command -v __git_complete && __git_complete g __git_main

# npm
# ==============================================================================
alias n='npm'
complete -o default -F _npm_completion n

# React Native development
# ==============================================================================
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'

# Alert
# ==============================================================================
if command -v osascript &> /dev/null; then
    alias bell=$'osascript -e \'display notification "Ring ring ring!"\''
fi

if command -v notify-send &> /dev/null; then
    alias bell='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

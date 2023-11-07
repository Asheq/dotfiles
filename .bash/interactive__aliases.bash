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
complete -o dirnames -o nospace -F _fzf_dir_completion c

alias v='nvim'

alias drive='cd ~/My\ Drive/'
alias notes='cd ~/My\ Drive/notes/'
alias todo='cd ~/My\ Drive/todo/'

# git
# ==============================================================================
alias g='git'
__git_complete g __git_main

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
elif command -v notify-send &> /dev/null; then
    alias bell='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
fi

# Terminal
# ==============================================================================
alias dark=" kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox Dark"
alias light="kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox Light"
# NOTE: These are faster but do not affect new windows
# alias dark="kitty @ --to="$KITTY_LISTEN_ON" set-colors --all ~/.config/kitty/Gruvbox\ Dark.conf"
# alias light="kitty @ --to="$KITTY_LISTEN_ON" set-colors --all ~/.config/kitty/Gruvbox\ Light.conf"

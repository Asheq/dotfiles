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

alias c='cd'
complete -o dirnames -o nospace -F _fzf_dir_completion c

alias o='open'
alias v='nvim'

# Bookmarks
# ==============================================================================
alias drive='cd ~/My\ Drive/'
alias notes='cd ~/My\ Drive/Notes/'
alias todo='cd ~/My\ Drive/Todo/'

# git
# ==============================================================================
alias g='git'
__git_complete g __git_main

# npm
# ==============================================================================
alias n='npm'
complete -o default -F _npm_completion n

# React Native Debugger
# ==============================================================================
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'

# Bell
# ==============================================================================
alias bell=$'osascript -e \'display notification "Ring ring ring!"\''

# Terminal theme
# ==============================================================================
alias  dark='kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox Dark'
alias light='kitty +kitten themes --config-file-name=theme.conf --reload-in=all Gruvbox Light'

# NOTE: These are faster but do not affect windows created after invoking them
alias  darkf='kitty @ --to="$KITTY_LISTEN_ON" set-colors --all ~/.config/kitty/Gruvbox\ Dark.conf'
alias lightf='kitty @ --to="$KITTY_LISTEN_ON" set-colors --all ~/.config/kitty/Gruvbox\ Light.conf'

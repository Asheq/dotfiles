# Basic file management
# ==============================================================================
if command -v eza &> /dev/null; then
    alias l='eza -F'
    alias la='eza -F -a'
    alias ll='eza -F -a -l -h'
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
alias tasks='cd ~/My\ Drive/Tasks/'

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
alias notify='kitten notify'

# Terminal theme
# ==============================================================================
alias dark='kitty @ set-colors -a ~/.config/kitty/my-themes/dark.conf'
alias light='kitty @ set-colors -a ~/.config/kitty/my-themes/light.conf'

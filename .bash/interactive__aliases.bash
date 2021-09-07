# Basic file maangement
# ==============================================================================
alias l='exa -F'
alias la='exa -Fa'
alias ll='exa -Flah'

alias o='open'
alias v='nvim'
alias p='cd "/Users/asheq.imran/Google Drive/other/planner"'
alias s='cd "/Users/asheq.imran/dev/github.com/ServiceMax-Engineering"'

alias c='cd'
complete -o dirnames -o nospace -F _fzf_dir_completion c

# git
# ==============================================================================
alias g='git'
__git_complete g __git_main

# npm
# ==============================================================================
alias n='npm'
complete -o default -F _npm_completion n

# Terminal test
# ==============================================================================
alias termtest='~/dev/zzz/github.com/p-e-w/ternimal/ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00'

# React Native development
# ==============================================================================
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'
alias opendb='open $(xcrun simctl get_app_container booted com.servicemaxinc.fsadev data)/Library/LocalDatabase/fsa.db'

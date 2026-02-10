#!/usr/bin/env bash

# Basic file management
# ==============================================================================
if command -v eza &> /dev/null; then
	alias l='eza -F'
	alias la='eza -F -a'
	alias ll='eza -F -a -l -h'
else
	alias l='ls --color -F'
	alias la='ls --color -F -a'
	alias ll='ls --color -F -a -l -h'
fi

alias c='cd'
complete -o dirnames -o nospace -F _fzf_dir_completion c

alias o='open'
alias v='nvim'

# Bookmarks
# ==============================================================================
if [[ "$(hostname)" == "AIMRAN0ML" ]]; then
	alias drive='cd ~/Documents/'
	alias notes='cd ~/Documents/Notes/'
	alias tasks='cd ~/Documents/Tasks/'
	alias cv='cd ~/.config/nvim'
else
	alias drive='cd ~/My\ Drive/'
	alias notes='cd ~/My\ Drive/Notes/'
	alias tasks='cd ~/My\ Drive/Tasks/'
	alias cv='cd ~/.config/nvim'
fi

# git
# ==============================================================================
alias g='git'
__git_complete g _git

# npm
# ==============================================================================
alias n='npm'
complete -o default -o nospace -F _npm_completion n

# Bell
# ==============================================================================
alias mb=$'osascript -e \'display notification "Ring ring ring!"\''
alias kb='kitten notify'

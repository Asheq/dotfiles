# ------------------------------------------------------------------------------
# Basic file management
# ------------------------------------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias md='mkdir -pv'

# TODO See:
# - https://github.com/sindresorhus/trash-cli
# - https://github.com/sindresorhus/guides/blob/master/how-not-to-rm-yourself.md#safeguard-rm
# - https://github.com/andreafrancia/trash-cli
alias rf='rm -rf'
alias rd='rmdir'

alias o='open'
alias r='ranger'

# ------------------------------------------------------------------------------
# Change directory
# ------------------------------------------------------------------------------
alias cd='echo "Use c"'

alias c='\cd'

# ------------------------------------------------------------------------------
# List files
# ------------------------------------------------------------------------------
alias ls='echo "Use one of: l la lr ll lg"'

alias l='exa -F'
alias la='l -a'
alias lr='l -R'
alias ll='l -lah --group-directories-first'
alias lg='la | ag'

# ------------------------------------------------------------------------------
# (Neo)vim
# ------------------------------------------------------------------------------
alias vim='nvim'
alias vi='nvim'
alias v='nvim'

# ------------------------------------------------------------------------------
# Kitty kittens
# ------------------------------------------------------------------------------
alias icat="kitty +kitten icat"

# ------------------------------------------------------------------------------
# npm
# ------------------------------------------------------------------------------
alias n='npm'
alias nr='npm run --silent'
alias nrv='npm run'

# ------------------------------------------------------------------------------
# nvm
# ------------------------------------------------------------------------------
alias nu='nvm use'
alias nui='nvm use $INITIAL_NODE_VERSION'

# ------------------------------------------------------------------------------
# React native debugger
# ------------------------------------------------------------------------------
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'

# ------------------------------------------------------------------------------
# python
# ------------------------------------------------------------------------------
alias py2='python'
alias py3='python3'
alias py='py3'

# ------------------------------------------------------------------------------
# Miscellaneous
# ------------------------------------------------------------------------------
# TODO Are these POSIX-compliant or bash-specific?
alias h='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
alias info='info --vi-keys'
alias termtest='~/dev/github.com/p-e-w/ternimal/ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00'
alias cal='cal -3'
alias now='date +"%a %b %-d %-I:%M:%S %p"'
alias please='sudo'
alias t='true'

# ------------------------------------------------------------------------------
# git
# Inspired by oh-my-zsh: https://github.com/ohmyzsh/ohmyzsh/blob/master/plugins/git/git.plugin.zsh
# TODO Put git aliases in ~/.config/git/config. This will probably preserve
# completion properly for everything.
# ------------------------------------------------------------------------------
# git
alias g='git'

# git add
alias ga='git add'
alias gaa='git add --all'

# git branch
alias gb='git branch'

# git commit
alias gc='git commit -v'
alias gcnv='git commit --no-verify'

# git checkout
alias gco='git checkout'

# git diff
alias gd='git diff'
alias gdv='gd | v -'
alias gdc='git diff --cached'
alias gdcv='gdca | v -'

# git fetch
alias gf='git fetch'

# git push
alias gp='git push'

# git status
alias gsta='nvim -c Gstatus'
alias gst='git status'
alias gs='git status -sb'

# ------------------------------------------------------------------------------
# Preseve completion
# ------------------------------------------------------------------------------
__git_complete g __git_main
complete -o dirnames -o nospace -F _fzf_dir_completion c
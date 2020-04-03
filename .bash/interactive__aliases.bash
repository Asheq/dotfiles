# ------------------------------------------------------------------------------
# Basic file management
# ------------------------------------------------------------------------------
alias cp='cp -iv'
alias mv='mv -iv'
alias md='mkdir -pv'

alias rf='rm -rf'
alias rd='rmdir'

alias o='open'
alias r='ranger'

# ------------------------------------------------------------------------------
# Change directory
# ------------------------------------------------------------------------------
alias cd='echo "Use c"'

alias c='\cd'
complete -o dirnames -o nospace -F _fzf_dir_completion c

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
alias d="kitty +kitten diff"

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
# ------------------------------------------------------------------------------

alias g=git
__git_complete g __git_main

alias_git gl   log      'git log'
alias_git gls  log      'git log --stat'
alias_git glg  log      'git log --graph'
alias_git glo  log      'git log --oneline'

alias_git gd   diff     'git diff'
alias_git gdc  diff     'git diff --cached'

alias_git gs   status   'git status -sb'
alias_git gst  status   'git status'
alias gsta='nvim -c Gstatus'

alias_git ga   add      'git add'
alias_git gaa  add      'git add --all'

alias_git gc   commit   'git commit -v'
alias_git gcnv commit   'git commit --no-verify'

alias_git gsw  switch   'git switch'
alias_git gb   branch   'git branch'
alias_git gco  checkout 'git checkout'
alias_git gf   fetch    'git fetch'
alias_git gp   push     'git push'

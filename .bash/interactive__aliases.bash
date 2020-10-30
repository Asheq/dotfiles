# Basic file maangement
# ==============================================================================
alias l='exa -F'
alias la='exa -Fa'
alias ll='exa -Flah'

alias c='\cd'
complete -o dirnames -o nospace -F _fzf_dir_completion c

alias o='open'

alias v='nvim'

# npm run
# ==============================================================================
alias nr='npm run --silent'

# React Native development
# ==============================================================================
alias rnd='open "rndebugger://set-debugger-loc?host=localhost&port=8081"'
alias opendb='open $(xcrun simctl get_app_container booted com.servicemaxinc.fsadev data)/Library/LocalDatabase/fsa.db'

# Terminal test
# ==============================================================================
alias termtest='~/dev/zzz/github.com/p-e-w/ternimal/ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00'

# git
# TODO: Migrate to git aliases
# ==============================================================================
function alias_git() {
  local alias_from="$1"
  local completion_category="$2"
  local alias_to="$3"

  # shellcheck disable=SC2139
  alias "$alias_from"="$alias_to"
  __git_complete "$alias_from" "_git_${completion_category}"
}

alias g=git
__git_complete g __git_main

alias_git gl    log      'git log'
alias_git glo   log      'git log --oneline'

alias_git gd    diff     'git diff'

alias_git ga    add      'git add'
alias_git gaa   add      'git add --all'

alias_git gc    commit   'git commit -v'
alias_git gcnv  commit   'git commit --no-verify'

alias_git gb    branch   'git branch'
alias_git gco   checkout 'git checkout'
alias_git gp    push     'git push'

alias_git gs    status   'git status -sb'
alias_git gst   status   'git status'
alias gsta='nvim -c Gstatus'

unset -f alias_git

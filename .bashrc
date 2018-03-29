########################################################
### Guard
########################################################

# If not running bash interactively, do not run this script
[[ "$-" != *i* ]] && return
echo 'Executing ~/.bashrc'

########################################################
### Bash History
########################################################

# Do not put duplicate lines or lines starting with space in history
HISTCONTROL=ignoreboth

# Ignore some controlling instructions.
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:vi:vim:tmux:cd:jobs'

HISTSIZE=1000
HISTFILESIZE=2000

########################################################
### Miscellaneous
########################################################

# Allow switching direction in reverse-i-search using Ctrl+s
stty -ixon

# Node BS
export NODE_TLS_REJECT_UNAUTHORIZED=0

########################################################
### Editor
########################################################
export EDITOR=vim
export VISUAL=$EDITOR

########################################################
### Aliases
########################################################

# ls
alias ls='ls -hFG'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias lA='ls -A'
alias llA='ll -A'

# grep
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# cd
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# tmux
alias t='tmux'
alias tls='tmux ls'
alias ta='tmux a -t'

# vim
alias vim='vim -u ~/.vimrc' # use only ~/.vimrc as init file; do not load /etc/vimrc or any other
alias vi='vim'

# git
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gls='git ls-tree -r master --name-only'
alias gs='git status'
alias gp='git push'

# Miscellaneous
alias info='info --vi-keys'
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
alias h='history'
alias o='open'
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

########################################################
### Functions
########################################################

# Proxies
function setproxy() {
    export {http,https,ftp,all}_proxy='http://proxy-src.research.ge.com:8080'
    export no_proxy='localhost,127.0.0.1,127.0.0.0/8,127.0.*.*,local.home,192.168.*.*,github.build.ge.com,github.sw.ge.com,openge.ge.com,devcloud.swcoe.ge.com'
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset no_proxy
}

# Call setproxy function immediately
setproxy

########################################################
### Source external shell scripts
########################################################

# git (add ability to include git info in prompt via __git_ps1)
[ -f ~/.bash_git ] && source ~/.bash_git

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

########################################################
### Prompt and Title
########################################################

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

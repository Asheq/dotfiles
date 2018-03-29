###############################################################################
### Guard
###############################################################################

# If not running bash interactively, do not run this script
[[ "$-" != *i* ]] && return
echo 'Executing ~/.bashrc'

###############################################################################
### shopt
###############################################################################

# Append to the history file, don't overwrite it
shopt -s histappend

# Save multi-line commands as one command
shopt -s cmdhist

# Update window size after every command
shopt -s checkwinsize

# Prepend cd to directory names automatically
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd
shopt -s cdspell 2> /dev/null

###############################################################################
### set
###############################################################################

# Prevent file overwrite on stdout redirection
# Use `>|` to force redirection to an existing file
set -o noclobber

###############################################################################
### alias
###############################################################################

# ------------------------------------------------------
# ls
# ------------------------------------------------------
alias ls='ls -hFG'
alias ll='ls -l'
alias la='ls -a'
alias lla='ll -a'
alias lA='ls -A'
alias llA='ll -A'

# ------------------------------------------------------
# grep
# ------------------------------------------------------
alias grep='grep --color'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# ------------------------------------------------------
# cd
# ------------------------------------------------------
alias ..='cd ..'
alias ...='cd ..; cd ..'
alias ....='cd ..; cd ..; cd ..'

# ------------------------------------------------------
# tmux
# ------------------------------------------------------
alias t='tmux'
alias tls='tmux ls'
alias ta='tmux a -t'

# ------------------------------------------------------
# vim
# ------------------------------------------------------
alias vim='vim -u ~/.vimrc' # Use only ~/.vimrc as init file; do not load /etc/vimrc or any other
alias vi='vim'

# ------------------------------------------------------
# git
# ------------------------------------------------------
alias g='git'
alias ga='git add'
alias gaa='git add -A'
alias gc='git commit -m'
alias gd='git diff'
alias gdc='git diff --cached'
alias gl='git log'
alias gls='git ls-tree -r master --name-only'
alias gs='git status'
alias gp='git push'
alias gp='git pull'

# ------------------------------------------------------
# Show and hide hidden files
# ------------------------------------------------------
alias showFiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hideFiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# ------------------------------------------------------
# Misc.
# ------------------------------------------------------
alias info='info --vi-keys'
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
alias h='history'
alias o='open'

###############################################################################
### function
###############################################################################

# ------------------------------------------------------
# Proxies
# ------------------------------------------------------
function setproxy() {
    export {http,https,ftp,all}_proxy='http://proxy-src.research.ge.com:8080'
    export no_proxy='localhost,127.0.0.1,127.0.0.0/8,127.0.*.*,local.home,192.168.*.*,github.build.ge.com,github.sw.ge.com,openge.ge.com,devcloud.swcoe.ge.com'
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset no_proxy
}

# ------------------------------------------------------
# Update everything
# ------------------------------------------------------
function updateEverything() {
    # softwareupdate --install --all
    (brew update && brew upgrade && brew cleanup && brew doctor)
    npm update -g
    # (pip3 list --outdated --format=freeze | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U)
    # (gem update --system && gem update && gem cleanup)
}

###############################################################################
### source
###############################################################################

[ -f ~/.bash_git ] && source ~/.bash_git # adds __git_ps1 command

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.config/up/up.sh ] && source ~/.config/up/up.sh

###############################################################################
### =
###############################################################################

# ------------------------------------------------------
# fzf
# ------------------------------------------------------

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ------------------------------------------------------
# Bash history
# ------------------------------------------------------

# Record each line as it gets issued
PROMPT_COMMAND='history -a'

# Expand history size
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries
HISTCONTROL=erasedups:ignoreboth

# Dont' record some commdns
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls:clear:vi:vim:tmux:cd:jobs'

# ------------------------------------------------------
# Editor
# ------------------------------------------------------
export EDITOR=vim
export VISUAL=$EDITOR

# ------------------------------------------------------
# Misc.
# ------------------------------------------------------

# Automatically trim long paths in the prompt (requires Bash 4.x)
PROMPT_DIRTRIM=2

# Node thing TODO: Figure out how to do this the proper way
export NODE_TLS_REJECT_UNAUTHORIZED=0

# ------------------------------------------------------
# Prompt and title (PS1)
# ------------------------------------------------------
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
unset color_prompt

# If this is an xterm, set the title to user@host:dir
case "$TERM" in
    xterm*|rxvt*)
        PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
        ;;
    *)
        ;;
esac

###############################################################################
### Call some functions immediately
###############################################################################
setproxy

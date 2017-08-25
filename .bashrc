# ~/.bashrc: executed by bash(1) for interactive shells.
# Note: This configuration has only been tested on Cygwin

# If not running interactively, don't do anything
[[ "$-" != *i* ]] && return

# History Options
#
# Don't put duplicate lines in the history.
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
#
# Ignore some controlling instructions
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# Aliases
#
# Misc :)
alias grep='grep --color'               # show differences in colour
alias egrep='egrep --color=auto'        # show differences in colour
alias fgrep='fgrep --color=auto'        # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'           # classify files in colour
alias ll='ls -l'                        # long list
alias la='ls -A'                        # all but . and ..
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
#
alias open='cygstart'
alias cdu='cd $USERPROFILE'               # Windows user profile on Cygwin
alias cdh='cd $HOMEDRIVE'                 # Windows home drive on Cygwin
alias cdg='cd $HOMEDRIVE/Development/GE/' # GE development directory
#
alias info='info --vi-keys'
#
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
#
alias gitls='git ls-tree -r master --name-only'
#
# Do not load /etc/vimrc
alias vim='vim -u ~/.vimrc'

# Allow switching direction in reverse-i-search using Ctrl+s
stty -ixon

# Make programs aware that the terminal is capable of 256 colors
export TERM=xterm-256color

# Add up command
source ~/.config/up/up.sh

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

source ~/.bash_git

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

function setproxy() {
    export {http,https,ftp,all}_proxy='http://proxy-src.research.ge.com:8080'
    export no_proxy='localhost,127.0.0.0/8,127.0.*.*,local.home,192.168.*.*,github.build.ge.com,github.sw.ge.com,openge.ge.com'
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset no_proxy
}

setproxy

########################################################
### If not running interactively, don't do anything
########################################################
[[ "$-" != *i* ]] && return
echo 'Executing ~/.bashrc'

########################################################
### History Options
########################################################

# Don't put duplicate lines or lines starting with space in history.
HISTCONTROL=ignoreboth

# Ignore some controlling instructions.
# HISTIGNORE is a colon-delimited list of patterns which should be excluded.
# The '&' is a special pattern which suppresses duplicate entries.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:ls'

# Set HISTSIZE and HISTFILESIZE
HISTSIZE=1000
HISTFILESIZE=2000

########################################################
### Aliases
########################################################

# Grep
alias grep='grep --color'                 # show differences in colour
alias egrep='egrep --color=auto'          # show differences in colour
alias fgrep='fgrep --color=auto'          # show differences in colour

# List Directory
alias ls='ls -hFG'                        # classify files in colour
alias ll='ls -l'                          # long list
alias la='ll -a'                          # all
alias lA='ll -A'                          # all but . and ..

# Miscellaneous
alias info='info --vi-keys'
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
alias gitls='git ls-tree -r master --name-only'
alias vim='vim -u ~/.vimrc'               # Do not load /etc/vimrc

# Cygwin Overrides
# TODO: Figure out how to apply these overrides automatically only when running Cygwin
# alias ls='ls -hF --color=tty'             # classify files in colour
# alias open='cygstart'
# alias cdu='cd $USERPROFILE'               # Windows user profile on Cygwin
# alias cdr='cd $HOMEDRIVE'                 # Windows home drive on Cygwin
# alias cdg='cd $HOMEDRIVE/Development/GE/' # GE development directory

########################################################
### Source external shell scripts
########################################################
source ~/.config/up/up.sh # add up command
source ~/.bash_git        # add ability to include git info in prompt via __git_ps1

########################################################
### Prompt and Title
########################################################

# Get a colored prompt, if the terminal has the capability
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

# TODO: Improve prompt, particularly git info
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\]$(__git_ps1 " (%s)")\n\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm, set the title to user@host:dir
# TODO: Is this necessary?
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

########################################################
### Proxies
########################################################

function setproxy() {
    export {http,https,ftp,all}_proxy='http://proxy-src.research.ge.com:8080'
    export no_proxy='localhost,127.0.0.0/8,127.0.*.*,local.home,192.168.*.*,github.build.ge.com,github.sw.ge.com,openge.ge.com'
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset no_proxy
}

# Call setproxy function immediately
setproxy

########################################################
### Miscellaneous
########################################################

# Allow switching direction in reverse-i-search using Ctrl+s
stty -ixon

# Make programs aware that the terminal is capable of 256 colors
export TERM=xterm-256color

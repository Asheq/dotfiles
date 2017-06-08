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

# Aliases
#
# Misc :)
alias grep='grep --color'                     # show differences in colour
alias egrep='egrep --color=auto'              # show differences in colour
alias fgrep='fgrep --color=auto'              # show differences in colour
#
# Some shortcuts for different directory listings
alias ls='ls -hF --color=tty'                 # classify files in colour
alias ll='ls -l'                              # long list
alias la='ll -A'                              # all but . and ..
alias dir='ls --color=auto --format=vertical'
alias vdir='ls --color=auto --format=long'
alias l='ls -C'
#
alias open='cygstart'
alias home='cd /cygdrive/c/Users/212341870'
#
alias info='info --vi-keys'
#
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
#
alias gitls='git ls-tree -r master --name-only'

# Allow switching direction in reverse-i-search using Ctrl+s
stty -ixon

# Make programs aware that the terminal is capable of 256 colors
export TERM=xterm-256color

# Add up command
source ~/.config/up/up.sh

#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#
# The personal per-interactive-shell startup file.

# Only continue running this script if bash is being run interactively
[[ "$-" != *i* ]] && return

# echo 'Executing ~/.bashrc'

# TODO: Get comments from 'man bash'
# TODO: Split up into several files

###############################################################################
### shopt
###############################################################################

# Update window size after every command.
shopt -s checkwinsize

# Turn on recursive globbing (enables ** to recurse all directories).
shopt -s globstar 2> /dev/null

# Case-insensitive globbing (used in pathname expansion).
shopt -s nocaseglob;

# Append to the history file, don't overwrite it.
shopt -s histappend

# Save multi-line commands as one command.
shopt -s cmdhist

# Prepend cd to directory names automatically.
shopt -s autocd 2> /dev/null

# Correct spelling errors during tab-completion.
shopt -s dirspell 2> /dev/null

# Correct spelling errors in arguments supplied to cd.
shopt -s cdspell 2> /dev/null

# This allows you to bookmark your favorite places across the file system
# Define a variable containing a path and you will be able to cd into it regardless of the directory you're in
shopt -s cdable_vars

###############################################################################
### bind
###############################################################################

# Enable history expansion with space.
# E.g. typing !!<space> will replace the !! with your last command.
bind Space:magic-space

###############################################################################
### set
###############################################################################

# Prevent file overwrite on stdout redirection.
# Use `>|` to force redirection to an existing file.
set -o noclobber

###############################################################################
### =
###############################################################################

# ------------------------------------------------------
# Bash settings
# ------------------------------------------------------

# Record each line as it gets issued.
PROMPT_COMMAND='history -a'

# Expand history size.
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries.
#                            ┌─ Don't save commands beginning with a space.
#                            │
#            ┌─ ignoredups + ignorespace
#            │
HISTCONTROL="ignoreboth:erasedups"
#                       │
#                       └─ Erase duplicate lines in the history.

# Don't record some commands.
#             ┌─ Ignore commands containing only 2 characters.
#             │
HISTIGNORE="?:??:clear:history:exit:jobs:tmux:vim:nvim"
#           │
#           └─ Ignore commands containing only 1 character.

# Automatically trim long paths in the prompt.
PROMPT_DIRTRIM=2

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# ------------------------------------------------------
# PS1
# ------------------------------------------------------
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1="\033[00;36m"
    if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
        PS1+=" \h "
    fi
    PS1+=" \u\033[00m "
    PS1+="\033[00;33m  \w\033[00m "
    PS1+="\033[00;36m\`parse_git_branch\`"
    PS1+='`[ \j -gt 0 ] && echo [ \j]`\033[00m'
    PS1+="\n\033[00;36m \033[00m"
else
    PS1="\u@\h \w\\n$ "
fi
unset color_prompt

# ------------------------------------------------------
# Cdable vars
# ------------------------------------------------------
gh="$HOME/Development/github.com"
ghb="$HOME/Development/github.build.ge.com"


###############################################################################
### export =
###############################################################################
# TODO: Should these go here or in .profile or somewhere else?

# ------------------------------------------------------
# fzf
# ------------------------------------------------------
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ------------------------------------------------------
# Editor
# ------------------------------------------------------
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPAGER="nvim -c 'set ft=man' -"

# ------------------------------------------------------
# Misc.
# ------------------------------------------------------
# TODO: Figure out the proper way to handle Node errors.
export NODE_TLS_REJECT_UNAUTHORIZED=0
export NVM_DIR="$HOME/.nvm"

###############################################################################
### function
###############################################################################
# ------------------------------------------------------
# Proxies
# ------------------------------------------------------
function setproxy() {
    proxy_url='http://proxy-src.research.ge.com:8080'
    no_proxy_urls='127.0.0.1,10.*,3.*,localhost,github.build.ge.com,openge.ge.com,ice.ge.com,g2ua6181mjne.logon.ds.ge.com'

    export {http,https,ftp,all}_proxy=$proxy_url
    export {HTTP,HTTPS,FTP,ALL}_PROXY=$proxy_url
    export no_proxy=$no_proxy_urls
    export NO_PROXY=$no_proxy_urls
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset {HTTP,HTTPS,FTP,ALL}_PROXY
    unset {no_proxy,NO_PROXY}
}

# ------------------------------------------------------
# Update everything
# ------------------------------------------------------
function updateEverything() {
    (brew update && brew upgrade && brew cleanup && brew doctor)
}

###############################################################################
### source
###############################################################################
[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f ~/.bash_git_functions ] && source ~/.bash_git_functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.config/up/up.sh ] && source ~/.config/up/up.sh

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

###############################################################################
### Call some functions immediately
###############################################################################
setproxy

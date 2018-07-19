#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

###############################################################################
### Guard
###############################################################################

# Only continue running this script if bash is being run interactively
[[ "$-" != *i* ]] && return

echo 'Executing ~/.bashrc'

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
### source
###############################################################################

[ -f ~/.bash_aliases ] && source ~/.bash_aliases

[ -f ~/.bash_git_functions ] && source ~/.bash_git_functions

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.config/up/up.sh ] && source ~/.config/up/up.sh

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
HISTCONTROL=erasedups:ignoreboth

# Don't record some commands.
HISTIGNORE=$'[ \t]*:&:[fb]g:exit:clear:cd:jobs:tmux:l:la:ls:v:vi:vim:nvim'

# Automatically trim long paths in the prompt.
PROMPT_DIRTRIM=2

# Use standard ISO 8601 timestamp
# %F equivalent to %Y-%m-%d
# %T equivalent to %H:%M:%S (24-hours format)
HISTTIMEFORMAT='%F %T '

# ------------------------------------------------------
# Cdable vars
# ------------------------------------------------------
gh="$HOME/Development/github.com"
ghb="$HOME/Development/github.build.ge.com"

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

# ------------------------------------------------------
# PS1
# ------------------------------------------------------
if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \`parse_git_branch\` [\j]\n$ "
else
    PS1="\u@\h \w\\n$ "
fi
unset color_prompt

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
    (brew update && brew upgrade && brew cleanup && brew doctor)
}

###############################################################################
### Call some functions immediately
###############################################################################
setproxy

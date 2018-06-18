#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

###############################################################################
### Guard
###############################################################################
echo 'Executing ~/.bashrc'

# If bash is not being run interactively, do not continue running this script.
[[ "$-" != *i* ]] && return

echo 'Running bash interactively so continuing execution of ~/.bashrc'

###############################################################################
### shopt
###############################################################################

# Append to the history file, don't overwrite it.
shopt -s histappend

# Save multi-line commands as one command.
shopt -s cmdhist

# Update window size after every command.
shopt -s checkwinsize

# Prepend cd to directory names automatically.
shopt -s autocd 2> /dev/null

# Correct spelling errors in arguments supplied to cd.
shopt -s cdspell 2> /dev/null

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
# fzf
# ------------------------------------------------------

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ------------------------------------------------------
# Bash history
# ------------------------------------------------------

# Record each line as it gets issued.
PROMPT_COMMAND='history -a'

# Expand history size.
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries.
HISTCONTROL=erasedups:ignoreboth

# Don't record some commands.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:clear:cd:jobs:tmux:l:la:ls:v:vi:vim:nvim'

# ------------------------------------------------------
# Editor
# ------------------------------------------------------
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPAGER="nvim -c 'set ft=man' -"

# ------------------------------------------------------
# Misc.
# ------------------------------------------------------

# Automatically trim long paths in the prompt (requires Bash 4.x).
PROMPT_DIRTRIM=2

# TODO: Figure out the proper way to handle Node errors.
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
    PS1="\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \`parse_git_branch\` [\j]\n$ "
else
    PS1="\u@\h \w\\n$ "
fi
unset color_prompt

###############################################################################
### Call some functions immediately
###############################################################################
setproxy

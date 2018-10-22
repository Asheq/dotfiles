#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#
# The personal per-interactive-shell startup file.
#
# When an interactive shell that is not a login shell is started, bash reads and executes commands
# from ~/.bashrc

# Only continue running this script if bash is being run interactively.
[[ "$-" != *i* ]] && return

# ------------------------------------------------------------------------------
# Echo bash info
# ------------------------------------------------------------------------------
echo "Running $0 ${BASH_VERSION}."

# ------------------------------------------------------------------------------
# Shell options (shopt)
# ------------------------------------------------------------------------------
shopt -s checkwinsize
shopt -s globstar
shopt -s nocaseglob
shopt -s histappend
shopt -s cmdhist
shopt -s autocd
shopt -s dirspell
shopt -s cdspell
shopt -s cdable_vars

# ------------------------------------------------------------------------------
# Shell options (set)
# ------------------------------------------------------------------------------
set -o noclobber

# ------------------------------------------------------------------------------
# Internal shell variables
# ------------------------------------------------------------------------------
# HIST
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '
HISTCONTROL="ignoreboth:erasedups"
HISTIGNORE="?:??:clear:history:exit:jobs:tmux:vim:nvim"

# PROMPT
PROMPT_DIRTRIM=3
[ -f ~/.bash/prompt.sh ] && source ~/.bash/prompt.sh

# cd-able vars
gh="${HOME}/Development/github.com"
ghb="${HOME}/Development/github.build.ge.com"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
[ -f ~/.bash/aliases.sh ] && source ~/.bash/aliases.sh

# ------------------------------------------------------------------------------
# Custom functions and commands
# ------------------------------------------------------------------------------
[ -f ~/.bash/setproxy.sh ]      && source ~/.bash/setproxy.sh
[ -f ~/.bash/printargs.sh ]     && source ~/.bash/printargs.sh

# TODO: Download into another directory?
[ -f ~/.bash/up.sh ]            && source ~/.bash/up.sh
[ -f ~/.bash/git_functions.sh ] && source ~/.bash/git_functions.sh

# ------------------------------------------------------------------------------
# Setup fzf
# ------------------------------------------------------------------------------
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# ------------------------------------------------------------------------------
# Setup nvm
# ------------------------------------------------------------------------------
[ -s "$NVM_DIR/nvm.sh" ]          && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ------------------------------------------------------------------------------
# Set proxy
# ------------------------------------------------------------------------------
setproxy

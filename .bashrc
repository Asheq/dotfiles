#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#
# "The individual per-interactive-shell startup file"
#
# When an interactive shell that is not a login shell is invoked, bash reads and
# executes commands from ~/.bashrc.

# Only continue running this script if bash is interactive.
[[ "$-" != *i* ]] && return

# ------------------------------------------------------------------------------
# Echo bash info
# ------------------------------------------------------------------------------
echo "BASH_VERSION: ${BASH_VERSION}"

# ------------------------------------------------------------------------------
# Set shell options (shopt)
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
# Set shell options (set)
# ------------------------------------------------------------------------------
set -o noclobber

# ------------------------------------------------------------------------------
# Set internal shell variables
# ------------------------------------------------------------------------------
# HIST
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '
HISTCONTROL="ignoreboth:erasedups"
HISTIGNORE="?:??:clear:history:exit:jobs:tmux:vim:nvim"

# PROMPT
PROMPT_DIRTRIM=3
[ -f ~/.bash.d/prompt.sh ] && source ~/.bash.d/prompt.sh

# cd-able vars
gh="${HOME}/Development/github.com"
ghb="${HOME}/Development/github.build.ge.com"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
[ -f ~/.bash.d/aliases.sh ] && source ~/.bash.d/aliases.sh

# ------------------------------------------------------------------------------
# Custom functions and commands
# ------------------------------------------------------------------------------
[ -f ~/.bash.d/setproxy.sh ]      && source ~/.bash.d/setproxy.sh
[ -f ~/.bash.d/printargs.sh ]     && source ~/.bash.d/printargs.sh

# TODO: Download into another directory?
[ -f ~/.bash.d/up.sh ]            && source ~/.bash.d/up.sh
[ -f ~/.bash.d/git_functions.sh ] && source ~/.bash.d/git_functions.sh

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

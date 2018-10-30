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

# ------------------------------------------------------------------------------
# Double-check that this bash is interactive before continuing
# ------------------------------------------------------------------------------
[[ "$-" != *i* ]] && return

# ------------------------------------------------------------------------------
# Show temporary prompt
# ------------------------------------------------------------------------------
echo -n '> '

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
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='?:??:clear:history:exit:jobs:tmux:vim:nvim'

# PROMPT
PROMPT_DIRTRIM=3
PROMPT_COMMAND=__prompt_command

# cdable_vars
gh="${HOME}/Development/github.com"
ghb="${HOME}/Development/github.build.ge.com"

# ------------------------------------------------------------------------------
# Create aliases
# ------------------------------------------------------------------------------
[ -f ~/.bash.d/aliases.sh ]                && source ~/.bash.d/aliases.sh

# ------------------------------------------------------------------------------
# Create functions
# ------------------------------------------------------------------------------
[ -f ~/.bash.d/__prompt_command.sh ]       && source ~/.bash.d/__prompt_command.sh
[ -f ~/.bash.d/setproxy.sh ]               && source ~/.bash.d/setproxy.sh
[ -f ~/.bash.d/printargs.sh ]              && source ~/.bash.d/printargs.sh

# ------------------------------------------------------------------------------
# Source external scripts
# ------------------------------------------------------------------------------
# up
[ -f ~/.bash.d/external/up.sh ]            && source ~/.bash.d/external/up.sh

# git
[ -f ~/.bash.d/external/git_functions.sh ] && source ~/.bash.d/external/git_functions.sh

# fzf
[ -f ~/.fzf.bash ]                         && source ~/.fzf.bash

# nvm
[ -s "$NVM_DIR/nvm.sh" ]                   && source "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ]          && source "$NVM_DIR/bash_completion"

# ------------------------------------------------------------------------------
# Set proxy
# ------------------------------------------------------------------------------
setproxy

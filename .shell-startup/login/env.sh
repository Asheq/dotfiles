#!/bin/sh

export EDITOR='nvim-smart-open'
export VISUAL="$EDITOR"

# TODO: Replace with 'nvim-smart-open +Man!' when latest Neovim release allows
# +{cmd} to be used with --remote:
export MANPAGER='less'

export NVM_DIR=~/.nvm

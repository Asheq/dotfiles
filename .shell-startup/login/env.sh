#!/bin/sh

export EDITOR='nvim-smart-open'
export VISUAL="$EDITOR"

# Using less for now. TODO: Switch to 'nvim-smart-open +Man!' once the latest
# Neovim release allows +{cmd} to be used with --remote.
export MANPAGER='less'

export NVM_DIR=~/.nvm

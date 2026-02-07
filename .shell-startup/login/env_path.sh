#!/bin/sh

# Add directories to PATH
# ==============================================================================

# Python
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Homebrew
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Node
path_prepend "$NVM_DIR"/versions/node/v24.11.1/bin PATH

# Cargo
path_prepend ~/.cargo/bin PATH

# User
path_prepend ~/bin PATH
path_prepend ~/.local/bin PATH

# Remove directories from PATH
# ==============================================================================
path_remove . PATH
path_remove "" PATH

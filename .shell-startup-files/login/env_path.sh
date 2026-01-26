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
pathprepend "$NVM_DIR"/versions/node/v24.11.1/bin PATH

# Cargo
pathprepend ~/.cargo/bin PATH

# Doom Emacs
pathprepend ~/.config/emacs/bin PATH

# User
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Remove directories from PATH
# ==============================================================================
pathremove . PATH
pathremove "" PATH

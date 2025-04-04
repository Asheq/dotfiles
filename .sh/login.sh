# NOTE: This file should be 100% POSIX-compliant

# Set other environment variables
# ==============================================================================

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For man
export MANPAGER='nvim +Man!'

# For nvm
export NVM_DIR=~/.nvm

# Set PATH
# ==============================================================================

# Add user's private binaries
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Add node binaries
pathprepend "$NVM_DIR"/versions/node/v20.17.0/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add python binaries
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Add brew binaries
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

# Source login.private.sh
ssource ~/.sh/login.private.sh

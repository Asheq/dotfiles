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

# For Android SDK
export ANDROID_SDK_ROOT=~/Library/Android/sdk

# Set PATH
# ==============================================================================

# Add user's private binaries
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Add doom emacs binary
pathprepend ~/.emacs.d/bin PATH

# Add node binaries
# TODO: Update to latest node and run `npm install -g neovim`
pathprepend "$NVM_DIR"/versions/node/v19.7.0/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add Android SDK binaries
pathprepend "$ANDROID_SDK_ROOT"/tools PATH
pathprepend "$ANDROID_SDK_ROOT"/tools/bin PATH

pathprepend "$ANDROID_SDK_ROOT"/emulator PATH
pathprepend "$ANDROID_SDK_ROOT"/platform-tools PATH

# Add python binaries
command -v pyenv &> /dev/null && eval "$(pyenv init --path)"

# Add brew binaries
command -v /opt/homebrew/bin/brew &> /dev/null && eval "$(/opt/homebrew/bin/brew shellenv)"

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

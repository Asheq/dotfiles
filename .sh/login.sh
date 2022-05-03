# NOTE: This file should be  100% POSIX-compliant

# Set other environment variables
# ==============================================================================

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For nvr
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# For man
# TODO: This does not work because with an appimage
export MANPAGER='nvim +Man!'

# For nvm
export NVM_DIR=~/.nvm

# For Android SDK
# TODO: This is a Mac-only path
export ANDROID_SDK_ROOT=~/Library/Android/sdk

# Set PATH
# ==============================================================================

# Add user/local binaries
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Add node binaries
# TODO
# pathprepend "$NVM_DIR"/versions/node/v14.17.0/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add Android SDK binaries
pathprepend "$ANDROID_SDK_ROOT"/emulator PATH
pathprepend "$ANDROID_SDK_ROOT"/platform-tools PATH

pathprepend "$ANDROID_SDK_ROOT"/tools PATH
pathprepend "$ANDROID_SDK_ROOT"/tools/bin PATH

# Add rvm binaries
pathappend ~/.rvm/bin

# Add python binaries
command -v pyenv &> /dev/null && eval "$(pyenv init --path)"

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

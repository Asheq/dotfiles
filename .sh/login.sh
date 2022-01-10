# TODO: Make sure this file is 100% POSIX-compliant

# Set other environment variables
# ==============================================================================

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For nvr
export NVIM_LISTEN_ADDRESS=/tmp/nvimsocket

# For man
export MANPAGER='nvim -c "set ft=man" -'

# For nvm
export NVM_DIR=~/.nvm

# For Android SDK
# TODO: This is Mac-only path
export ANDROID_HOME=~/Library/Android/sdk

# Set PATH
# ==============================================================================

# Add user/local binaries
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add node binaries
pathprepend "$NVM_DIR"/versions/node/v14.17.0/bin PATH

# Add Android SDK binaries
pathprepend "$ANDROID_HOME"/emulator PATH # Android emulator
pathprepend "$ANDROID_HOME"/tools PATH # ???
pathprepend "$ANDROID_HOME"/tools/bin PATH # Android SDK tools
pathprepend "$ANDROID_HOME"/platform-tools PATH # Android SDK platform tools

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

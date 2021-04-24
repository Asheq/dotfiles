# Set other environment variables
# ==============================================================================

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For man
export MANPAGER='nvim -c "set ft=man" -'

# For nvm
export NVM_DIR=~/.nvm

# For Android SDK
export ANDROID_HOME=~/Library/Android/sdk

# Set PATH
# ==============================================================================

# Add user binaries
pathprepend ~/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add node binaries
pathprepend "$NVM_DIR"/versions/node/v15.14.0/bin PATH

# Add Android SDK binaries
pathprepend "$ANDROID_HOME"/emulator PATH # Android emulator
pathprepend "$ANDROID_HOME"/tools PATH # ???
pathprepend "$ANDROID_HOME"/tools/bin PATH # Android SDK tools
pathprepend "$ANDROID_HOME"/platform-tools PATH # Android SDK platform tools

# Add kitty terminal
pathprepend /Applications/kitty.app/Contents/MacOS

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

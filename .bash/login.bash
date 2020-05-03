# vim:foldmethod=marker

# Set other environment variables {{{

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For man
export MANPAGER='nvim -c "set ft=man" -'

# For fzf
export FZF_CTRL_T_COMMAND="all_git_branches_normalized"

# For nvm
export NVM_DIR=~/.nvm

# For Android SDK
export ANDROID_HOME="$HOME"/Library/Android/sdk

# For my own bash startup files
export INITIAL_NODE_VERSION='10.17.0'

# }}}

# Set PATH {{{

# Add user binaries
pathprepend ~/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add node binaries
pathprepend ~/.nvm/versions/node/v"$INITIAL_NODE_VERSION"/bin PATH

# Add Android SDK stuff
pathprepend "$ANDROID_HOME"/emulator PATH # Android emulator
pathprepend "$ANDROID_HOME"/tools PATH # ???
pathprepend "$ANDROID_HOME"/tools/bin PATH # Android SDK tools
pathprepend "$ANDROID_HOME"/platform-tools PATH # Android SDK platform tools

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

# # }}}

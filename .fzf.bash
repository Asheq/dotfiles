# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/asheqimran/.fzf/bin* ]]; then
  export PATH="$PATH:/Users/asheqimran/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/asheqimran/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/asheqimran/.fzf/shell/key-bindings.bash"


# Setup fzf
# ---------
if [[ ! "$PATH" == */Users/a212341870/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/Users/a212341870/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/Users/a212341870/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/Users/a212341870/.fzf/shell/key-bindings.bash"

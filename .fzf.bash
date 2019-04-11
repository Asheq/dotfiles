# Setup fzf
# ---------
if [[ ! "$PATH" == */home/asheqimran/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/asheqimran/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/asheqimran/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/asheqimran/.fzf/shell/key-bindings.bash"

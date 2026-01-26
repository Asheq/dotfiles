# Source library scripts that enhance the interactive shell environment

# Git
git_etc_dir="$(dirname "$(realpath "$(command -v git)")")"/../etc
ssource "$git_etc_dir"/bash_completion.d/git-completion.bash
ssource "$git_etc_dir"/bash_completion.d/git-prompt.sh
unset git_etc_dir

# NPM
# shellcheck source=/dev/null
source <(command -v npm &> /dev/null && npm completion)

# NVM
ssource "$NVM_DIR"/nvm.sh --no-use
ssource "$NVM_DIR"/bash_completion

# rbenv
if hash rbenv 2>/dev/null; then
    eval "$(rbenv init - bash)"
fi

# fzf
ssource ~/.fzf.bash

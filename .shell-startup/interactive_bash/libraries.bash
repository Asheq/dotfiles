#!/usr/bin/env bash

# Source library scripts that enhance the interactive shell environment

# Git
git_etc_dir="$(dirname "$(realpath "$(command -v git)")")"/../etc
safe_source "$git_etc_dir"/bash_completion.d/git-completion.bash
safe_source "$git_etc_dir"/bash_completion.d/git-prompt.sh
unset git_etc_dir

# NPM
# shellcheck source=/dev/null
source <(command -v npm &> /dev/null && npm completion)

# NVM
safe_source "$NVM_DIR"/nvm.sh --no-use
safe_source "$NVM_DIR"/bash_completion

# rbenv
if hash rbenv 2>/dev/null; then
    eval "$(rbenv init - bash)"
fi

# fzf
safe_source ~/.fzf.bash

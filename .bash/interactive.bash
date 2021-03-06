# Source library scripts
# ==============================================================================

# git
git_etc_dir="$(dirname "$(realpath "$(command -v git)")")"/../etc
ssource "$git_etc_dir"/bash_completion.d/git-completion.bash
ssource "$git_etc_dir"/bash_completion.d/git-prompt.sh
unset git_etc_dir

# nvm
ssource "$NVM_DIR"/nvm.sh --no-use
ssource "$NVM_DIR"/bash_completion

# rvm
ssource ~/.rvm/scripts/rvm

# fzf
ssource ~/.fzf.bash

# kitty
if hash kitty 2>/dev/null; then
    # shellcheck source=/dev/null
    source <(kitty + complete setup bash)
fi

# Source my scripts
# ==============================================================================
ssource ~/.bash/interactive__environment_variables.bash
ssource ~/.bash/interactive__aliases.bash
ssource ~/.bash/interactive__functions.bash
ssource ~/.bash/interactive__options.bash

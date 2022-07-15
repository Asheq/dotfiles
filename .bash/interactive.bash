# Source library scripts
# ==============================================================================

# TODO
ssource /etc/bash_completion

# git
git_etc_dir="$(dirname "$(realpath "$(command -v git)")")"/../etc
ssource "$git_etc_dir"/bash_completion.d/git-completion.bash
ssource "$git_etc_dir"/bash_completion.d/git-prompt.sh
unset git_etc_dir

# npm
# shellcheck source=/dev/null
source <(command -v npm &> /dev/null && npm completion)

# nvm
ssource "$NVM_DIR"/nvm.sh --no-use
ssource "$NVM_DIR"/bash_completion

# rbenv
eval "$(rbenv init - bash)"

# fzf
ssource ~/.fzf.bash

# kitty
# TODO: Double-check kitty setup
if hash kitty 2>/dev/null; then
    # shellcheck source=/dev/null
    source <(kitty + complete setup bash)
fi

# Source my scripts
# ==============================================================================
ssource ~/.bash/interactive__environment_variables.bash
ssource ~/.bash/interactive__options.bash
ssource ~/.bash/interactive__aliases.bash
ssource ~/.bash/interactive__functions.bash

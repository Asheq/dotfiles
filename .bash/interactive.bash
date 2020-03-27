# vim:foldmethod=marker

# Source library scripts {{{

# For git
git_etc_dir="$(dirname "$(realpath "$(command -v git)")")"/../etc
ssource "$git_etc_dir"/bash_completion.d/git-completion.bash
ssource "$git_etc_dir"/bash_completion.d/git-prompt.sh

# For nvm
ssource "$NVM_DIR"/nvm.sh --no-use
ssource "$NVM_DIR"/bash_completion

# For rvm
ssource "$HOME"/.rvm/scripts/rvm

# For fzf
ssource "$HOME"/.fzf.bash

# For kitty
if hash kitty 2>/dev/null; then
    source <(kitty + complete setup bash)
fi

# }}}

# Source my scripts {{{
ssource ~/.bash/interactive__aliases.bash
ssource ~/.bash/interactive__environment_variables.bash
ssource ~/.bash/interactive__functions.bash
ssource ~/.bash/interactive__options.bash
# }}}

echo 'https://cmdchallenge.com/#/remove_extensions_from_files'

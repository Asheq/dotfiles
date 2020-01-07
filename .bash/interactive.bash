. ~/.shell/interactive

. ~/.bash/interactive_environment_variables.bash
. ~/.bash/interactive_functions.bash
. ~/.bash/interactive_options.bash

# Source bash-specific nvm script
ssource "$NVM_DIR/bash_completion"

# Source bash-specific rvm script
ssource "$HOME/.rvm/scripts/rvm"

# Source bash-specific fzf script
ssource ~/.fzf.bash

# Source bash-specific kitty script
if hash kitty 2>/dev/null; then
    source <(kitty + complete setup bash)
fi

echo 'https://cmdchallenge.com/#/remove_extensions_from_files'

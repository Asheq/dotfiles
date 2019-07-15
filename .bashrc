# "The individual per-interactive-shell startup file"
#
# When bash is invoked as an interactive shell that is _not_ a login shell, it
# reads and executes commands from ~/.bashrc.

# ------------------------------------------------------------------------------
# Double-check that this bash is interactive before continuing
# ------------------------------------------------------------------------------
[[ "$-" != *i* ]] && return

# ------------------------------------------------------------------------------
# Source git completion scripts
# ------------------------------------------------------------------------------
[[ -s ~/.config/git/git-completion.bash ]] && source ~/.config/git/git-completion.bash

# ------------------------------------------------------------------------------
# Source nvm's scripts
# ------------------------------------------------------------------------------
[[ -s "$NVM_DIR/nvm.sh" ]]          && source "$NVM_DIR/nvm.sh" --no-use
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

if [[ "${USE_CUSTOM_SHELL_SETTINGS}" == "yes" ]]; then
  # ------------------------------------------------------------------------------
  # Source fzf's scripts
  # ------------------------------------------------------------------------------
  [[ -f ~/.fzf.bash ]]                && source ~/.fzf.bash

  # ------------------------------------------------------------------------------
  # Source individual files
  # ------------------------------------------------------------------------------
  function source_files_recursively() {
    local dir="$1"
    local file
    if [[ -d "${dir}" ]] ; then
      for file in "${dir}"/** ; do
        if [[ -f "${file}" ]] ; then
          source "${file}"
        fi
      done
    fi
  }

  # Source functions *first* to avoid accidentally using aliased versions of
  # commands in function body definitions
  source_files_recursively "${HOME}/.bashrc.d/first"
  source_files_recursively "${HOME}/.bashrc.d/second"
fi


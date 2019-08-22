# NOTE: Strive to keep this file strictly POSIX-compliant

# ------------------------------------------------------------------------------
# Modify environment variables
# ------------------------------------------------------------------------------

DEFAULT_NODE_VERSION='8.14.1'

# PATH
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/.cargo/bin" ] ; then
  PATH="${HOME}/.cargo/bin:${PATH}"
fi

# Ensure we have a default node version in our PATH at startup
if [ -d "${HOME}/.nvm/versions/node/v${DEFAULT_NODE_VERSION}/bin" ] ; then
  PATH="${HOME}/.nvm/versions/node/v${DEFAULT_NODE_VERSION}/bin:${PATH}"
fi

if [ -d "/usr/local/lib/ruby/gems/2.5.0/bin" ] ; then
  PATH="/usr/local/lib/ruby/gems/2.5.0/bin:${PATH}"
fi

# MANPATH
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# INFOPATH
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# NODE and NVM
export NVM_DIR="${HOME}/.nvm"

# DISPLAY (for X Server)
export DISPLAY=:0

if [ "${USE_CUSTOM_SHELL_SETTINGS}" == "yes" ]; then
  # EDITOR
  export EDITOR=nvim

  # MANPAGER
  export MANPAGER='nvim -c "set ft=man" -'

  # FZF
  export FZF_DEFAULT_COMMAND='ag -g ""'
  export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"
else
  export EDITOR='vim -u NONE'
fi

export VISUAL="${EDITOR}"

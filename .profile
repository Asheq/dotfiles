#                   __ _ _
#  _ __  _ __ ___  / _(_) | ___
# | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | | | (_) |  _| | |  __/
# | .__/|_|  \___/|_| |_|_|\___|
# |_|

# ------------------------------------------------------------------------------
# Modify environment variables
# ------------------------------------------------------------------------------

# PATH
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

if [ -d "${HOME}/.cargo/bin" ] ; then
  PATH="${HOME}/.cargo/bin:${PATH}"
fi

# MANPATH
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# INFOPATH
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# EDITOR
export EDITOR=nvim
export VISUAL="${EDITOR}"
export MANPAGER="nvim -c 'set ft=man' -"

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# NODE and NVM
export NVM_DIR="${HOME}/.nvm"

# USE_FANCY_SYMBOLS
export USE_FANCY_SYMBOLS='yes'

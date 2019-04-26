# NOTE: Strive to keep this file strictly POSIX-compliant.

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

# EDITOR
if command -v nvim > /dev/null; then
  export EDITOR=nvim
  export MANPAGER='nvim -c "set ft=man" -'
else
  export EDITOR=vim
fi
export VISUAL="${EDITOR}"

# FZF
export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="${FZF_DEFAULT_COMMAND}"

# NODE and NVM
export NVM_DIR="${HOME}/.nvm"

# USE_FANCY_GLYPHS
export USE_FANCY_GLYPHS=yes

# DISPLAY (for X Server)
export DISPLAY=:0

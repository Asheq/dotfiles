# echo 'Executing ~/.profile'

# Set PATH so it includes user's private bin.
if [ -d "${HOME}/bin" ] ; then
  PATH="${HOME}/bin:${PATH}"
fi

# Set MANPATH so it includes user's private man.
if [ -d "${HOME}/man" ]; then
  MANPATH="${HOME}/man:${MANPATH}"
fi

# Set INFOPATH so it includes user's private info.
if [ -d "${HOME}/info" ]; then
  INFOPATH="${HOME}/info:${INFOPATH}"
fi

# Set PATH to include other things.
# TODO: Why does it show up twice in tmux session?
PATH="${HOME}/.cargo/bin:${PATH}"

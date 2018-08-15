#  _               _                           __ _ _
# | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                      |_____|_|
# The personal initialization file, executed for login shells.

echo 'Executing ~/.bash_profile'

# Source .profile.
if [ -f "${HOME}/.profile" ] ; then
  source "${HOME}/.profile"
fi

# Source .bashrc.
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

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

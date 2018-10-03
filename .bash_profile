#  _               _                           __ _ _
# | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                      |_____|_|
# The personal initialization file, executed for login shells.

# When bash is started as a login shell, it looks for (in order):
#     ~/.bash_profile
#     ~/.bash_login
#     ~/.profile
# It executes _only_ the first one. Also, because it is started as a login shell, bash does not read
# `~/.bashrc` (even if it's interactive).

# This file ensures both ~/.profile and ~/.bashrc are executed.

# echo 'Executing ~/.bash_profile'

# Source ~/.profile.
if [ -f "${HOME}/.profile" ] ; then
  source "${HOME}/.profile"
fi

# Source ~/.bashrc.
if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

# "The personal initialization file, executed for login shells"
#
# When bash is invoked as a login shell, it first executes commands from
# /etc/profile. It then looks for (in order):
#    ~/.bash_profile
#    ~/.bash_login
#    ~/.profile
# It executes _only_ the first one. Also, because it is started as a _login_
# shell, bash does not execute ~/.bashrc. This file ensures both ~/.profile and
# ~/.bashrc are executed.

# ------------------------------------------------------------------------------
# Source ~/.profile and ~/.bashrc
# ------------------------------------------------------------------------------
if [[ -f "${HOME}/.profile" ]] ; then
  source "${HOME}/.profile"
fi

if [[ -f "${HOME}/.bashrc" ]] ; then
  source "${HOME}/.bashrc"
fi

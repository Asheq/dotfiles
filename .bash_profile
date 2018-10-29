#!/usr/bin/env bash
#  _               _                           __ _ _
# | |__   __ _ ___| |__       _ __  _ __ ___  / _(_) | ___
# | '_ \ / _` / __| '_ \     | '_ \| '__/ _ \| |_| | |/ _ \
# | |_) | (_| \__ \ | | |    | |_) | | | (_) |  _| | |  __/
# |_.__/ \__,_|___/_| |_|____| .__/|_|  \___/|_| |_|_|\___|
#                      |_____|_|
#
# "The personal initialization file, executed for login shells"
#
# When bash is invoked as a login shell, it first reads and executes commands
# from /etc/profile. It then looks for (in order):
#	~/.bash_profile
#	~/.bash_login
#	~/.profile
# It executes _only_ the first one. Also, because it is started as a _login_
# shell, bash does not execute ~/.bashrc.

# This file ensures both ~/.profile and ~/.bashrc are executed.

# ------------------------------------------------------------------------------
# Echo environment info
# ------------------------------------------------------------------------------
echo "MACHTYPE: ${MACHTYPE}"
echo "BASH_VERSION: ${BASH_VERSION}"

# ------------------------------------------------------------------------------
# Source ~/.profile and ~/.bashrc
# ------------------------------------------------------------------------------
if [ -f "${HOME}/.profile" ] ; then
  source "${HOME}/.profile"
fi

if [ -f "${HOME}/.bashrc" ] ; then
  source "${HOME}/.bashrc"
fi

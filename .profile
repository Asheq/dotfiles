# ~/.profile is executed by the command interpreter for login shells.
# The login shell may be different on different systems so make sure everything
# in here is 100% POSIX-compliant.

# If the login shell happens to be bash, this file is not read by bash if
# ~/.bash_profile or ~/.bash_login exists.

# The default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
# umask 022

. ~/.sh/env.sh
. ~/.sh/login.sh

. ~/.xprofile

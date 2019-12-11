# When bash starts as a login shell (whether interactive or non-interactive), it
# first executes /etc/profile. It then looks for (in
# order):
#    ~/.bash_profile
#    ~/.bash_login
#    ~/.profile
# It executes _only_ the first one it finds.

. ~/.bash/env
. ~/.bash/login
if [ "$PS1" ]; then
    . ~/.bash/interactive
fi

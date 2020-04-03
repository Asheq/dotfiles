# When bash starts as a login shell (interactive or non-interactive), it
# executes, in order:
#
# 1. /etc/profile
# 2. Only one of the following (which ever it finds first in this given order):
#    ~/.bash_profile
#    ~/.bash_login
#    ~/.profile

. ~/.bash/env.bash
. ~/.bash/login.bash

if [ "$PS1" ]; then
    . ~/.bash/interactive.bash
fi

# When bash starts as a non-login interactive shell, it first executes
# /etc/bash.bashrc. It then executes ~/.bashrc.

echo 'This is a non-login interactive bash shell'

. ~/.bash/env
. ~/.bash/interactive

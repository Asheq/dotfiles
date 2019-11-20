# When bash is invoked as a non-login interactive shell, it first executes
# /etc/bash.bashrc. It then executes ~/.bashrc.

# When bash is invoked as a remote shell (over ssh or similar), it executes
# ~/.bashrc.

. ~/.bash/env
. ~/.bash/interactive

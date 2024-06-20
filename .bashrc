# When an interactive shell that is not a login shell is started, bash reads
# and executes commands from ~/.bashrc, if that file exists. This may be
# inhibited by using the --norc option. The --rcfile file option will force
# bash to read and execute commands from file instead of ~/.bashrc.

. ~/.sh/env.sh
ssource ~/.bash/interactive.bash

# You might be tempted to move these environment variables to ./bash/login and
# export them so that interactive bash sub-processes would see them
# automatically. However, you should not do this because they are bash-specific
# environment variables and we do not want other sub-processes (e.g. vim) to see
# them. Thus we should set these everytime an interactive bash starts.

# HIST...
HISTSIZE=10000
HISTFILESIZE=20000
HISTTIMEFORMAT='%F %T '
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='?:??:clear:history:exit:jobs:tmux:vim:nvim'

# PROMPT_COMMAND
PROMPT_COMMAND='__prompt_command; history -a'


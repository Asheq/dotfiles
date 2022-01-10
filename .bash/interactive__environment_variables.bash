# You might be tempted to move these environment variables to ./bash/login.bash
# and export them so that interactive bash sub-processes would see them
# automatically. However, you should avoid doing this because these are
# _bash-specific_ variables and we don't want to pollute the variable list of
# other sub-processes (e.g. vim). Instead, let's set these as non-exported
# variables only when an interactive bash starts.

# HIST...
# ==============================================================================
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='?:??'

# PROMPT_COMMAND
# ==============================================================================
PROMPT_COMMAND='__prompt_command; history -a'

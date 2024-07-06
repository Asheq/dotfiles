# These are variables relevant only for interactive bash. Do not export them to
# avoid polluting the variable list of subprocesses (e.g., vim).

# HIST...
# ==============================================================================
HISTSIZE=10000
HISTFILESIZE=20000
HISTCONTROL='ignoreboth:erasedups'
HISTIGNORE='?:??'

# PROMPT_COMMAND
# ==============================================================================
PROMPT_COMMAND='__prompt_command; history -a'

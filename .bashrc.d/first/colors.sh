# ------------------------------------------------------------------------------
# ANSI escape sequences
# TODO: Understand these better
# ------------------------------------------------------------------------------
ANSI_WHITE_FG_BOLD='\[\e[1;39m\]'
ANSI_RESET='\[\e[0m\]'

ANSI_BLACK_FG='\[\e[0;30m\]'
ANSI_RED_FG='\[\e[0;31m\]'
ANSI_GREEN_FG='\[\e[0;32m\]'
ANSI_YELLOW_FG='\[\e[0;33m\]'
ANSI_BLUE_FG='\[\e[0;34m\]'
ANSI_MAGENTA_FG='\[\e[0;35m\]'
ANSI_CYAN_FG='\[\e[0;36m\]'
ANSI_WHITE_FG='\[\e[0;37m\]'
ANSI_DEFAULT_FG='\[\e[0;39m\]'

ANSI_BLACK_BG='\[\e[0;40m\]'
ANSI_RED_BG='\[\e[0;41m\]'
ANSI_GREEN_BG='\[\e[0;42m\]'
ANSI_YELLOW_BG='\[\e[0;43m\]'
ANSI_BLUE_BG='\[\e[0;44m\]'
ANSI_MAGENTA_BG='\[\e[0;45m\]'
ANSI_CYAN_BG='\[\e[0;46m\]'
ANSI_WHITE_BG='\[\e[0;47m\]'
ANSI_DEFAULT_BG='\[\e[0;49m\]'

# ------------------------------------------------------------------------------
# tput
# TODO: Understand these better
# ------------------------------------------------------------------------------
BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

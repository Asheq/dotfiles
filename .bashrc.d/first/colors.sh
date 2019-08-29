# ------------------------------------------------------------------------------
# ANSI escape sequences
# ------------------------------------------------------------------------------
ANSI_RESET='\[\e[0m\]'
ANSI_BLACK_FG='\[\e[0;30m\]'
ANSI_RED_FG='\[\e[0;31m\]'
ANSI_GREEN_FG='\[\e[0;32;40m\]'
ANSI_YELLOW_FG='\[\e[0;33m\]'
ANSI_BLUE_FG='\[\e[0;34m\]'
ANSI_MAGENTA_FG='\[\e[0;35m\]'
ANSI_CYAN_FG='\[\e[0;36m\]'
ANSI_LIGHT_GRAY_FG='\[\e[0;37m\]'
ANSI_DEFAULT_FG='\[\e[0;39m\]'
ANSI_DEFAULT_FG_BOLD='\[\e[1;39m\]'

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

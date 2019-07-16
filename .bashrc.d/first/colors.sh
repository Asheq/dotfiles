# ------------------------------------------------------------------------------
# ANSI escape sequences
# TODO: Understand these better
# ------------------------------------------------------------------------------
ANSI_WHITE_BOLD='\[\e[1;39m\]'
ANSI_WHITE='\[\e[0;37m\]'
ANSI_RED='\[\e[0;31m\]'
ANSI_BLUE='\[\e[0;34m\]'
ANSI_RESET='\[\e[0m\]'

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

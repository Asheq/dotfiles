# When an interactive shell that is not a login shell is started, bash reads
# and executes commands from ~/.bashrc, if that file exists. This may be
# inhibited by using the --norc option. The --rcfile file option will force
# bash to read and execute commands from file instead of ~/.bashrc.
. ~/.bash/env.bash
. ~/.bash/interactive.bash


# This is added to .bashrc automatically everytime kitty is started
# TODO: Move to appropriate place and stop adding automatically


# BEGIN_KITTY_SHELL_INTEGRATION
if test -n "$KITTY_INSTALLATION_DIR" -a -e "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; then source "$KITTY_INSTALLATION_DIR/shell-integration/bash/kitty.bash"; fi
# END_KITTY_SHELL_INTEGRATION

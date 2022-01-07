# When an interactive login shell exits, or a non-interactive login shell
# executes the exit builtin command, bash reads and executes commands from the
# file ~/.bash_logout, if it exists.

# When leaving the console clear the screen to increase privacy.
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi

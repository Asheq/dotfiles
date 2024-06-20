# When bash is invoked as an interactive login shell, or as a non-interactive
# shell with the --login option, it first reads and executes commands from the
# file /etc/profile, if that file exists.  After reading that file, it looks
# for ~/.bash_profile, ~/.bash_login, and ~/.profile, in that order, and reads
# and executes commands from the first one that exists and is readable. The
# --noprofile option may be used when the shell is started to inhibit this
# behavior.

. ~/.profile

# PS1 is set and $- includes i if bash is interactive, allowing a shell script
# or a startup file to test this state.
if [ "$PS1" ]; then
    ssource ~/.bash/interactive.bash
fi

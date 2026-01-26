. "$HOME"/.shell-startup-files/util.sh

ssource ~/.shell-startup-files/login/main.sh
ssource ~/.private-login-shell-startup.sh

# PS1 is set if bash is interactive
if [ "$PS1" ]; then
    ssource ~/.shell-startup-files/interactive_bash/main.bash
fi

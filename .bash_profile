. "$HOME"/.shell-startup/util.sh

safe_source ~/.shell-startup/login/main.sh

if [[ $- == *i* ]]; then
    safe_source ~/.shell-startup/interactive_bash/main.bash
fi

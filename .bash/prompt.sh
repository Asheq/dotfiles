# TODO: Set fancy or non-fancy icons based on an $USE_FANCY_SYMBOLS.
# TODO: Change color based on exit code of last command.
# TODO: Show depth of nested shells.
# TODO: Show time last command took to run.
color_prompt=yes
if [ "$color_prompt" = yes ]; then
	PS1="\[\033[00;36m\]\n┌╴"
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1+=" \h "
	fi
	PS1+=" \u\[\033[00m\] "
	PS1+="\[\033[00;33m\]  \w\[\033[00m\] "
	PS1+="\[\033[00;36m\]\`parse_git_branch\`"
	PS1+='`[ \j -gt 0 ] && echo [ \j]`\[\033[00m\]'
	PS1+="\n\[\033[00;36m\]└╴\[\033[00m\]"
else
	PS1="\u@\h \w\\n$ "
fi
unset color_prompt

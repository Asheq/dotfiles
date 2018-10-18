# TODO: Set fancy or non-fancy icons based on an $USE_FANCY_SYMBOLS.
# TODO: Change color based on exit code of last command.
# TODO: Show depth of nested shells.
# TODO: Show time last command took to run.
color_prompt=yes
if [ "$color_prompt" = yes ]; then
	PS1="\[\033[00;36m\]"
	PS1+="\n"
	PS1+="┌╴"
	PS1+="  \w"
	PS1+=" "
	PS1+="\[\033[00;02m\]"
	PS1+="\`parse_git_branch\`"
	PS1+='`[ \j -gt 0 ] && echo [ \j]`'
	PS1+=" "
	PS1+=" \u"
	PS1+=" "
	if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_TTY" ]; then
		PS1+=" \h "
	fi
	PS1+="\n"
	PS1+="\[\033[00;36m\]"
	PS1+="└╴"
	PS1+="\[\033[00m\]"
else
	PS1="\u@\h \w\\n$ "
fi
unset color_prompt

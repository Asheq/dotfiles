# TODO
# - Set fancy or non-fancy icons based on an $USE_FANCY_SYMBOLS.
# - Show depth of nested shells.
# - Show time last command took to run.

PROMPT_COMMAND=__prompt_command

__prompt_command() {
	local EXIT="$?"
	PS1=""

	local reset_color='\[\e[0m\]'

	if [ $EXIT != 0 ]; then
		local main_color='\[\e[0;31m\]' # Red
	else
		local main_color='\[\e[0;36m\]' # Cyan
	fi

	local secondary_color='\[\e[0;02m\]' # Gray

	PS1="${secondary_color}"
	PS1+="\n"
	PS1+="┌╴"
	PS1+='`pwd_head`'
	PS1+="${main_color}"
	PS1+='`pwd_tail` '
	PS1+="${secondary_color}"
	PS1+="\`parse_git_branch\`"
	PS1+='`[ \j -gt 0 ] && echo [ \ \j]\ `'
	PS1+="[  \u] "
	if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
		PS1+="[  \h]"
	fi
	PS1+="\n"
	PS1+="${secondary_color}"
	PS1+="└╴"
	PS1+="${reset_color}"
}

# PS1='`pwd_head`'
# PS1+="\[\e[0;36m\]"
# PS1+='`pwd_tail`'
# PS1+="\[\e[0m\]"
# PS1+=' > '

pwd_head() {
	local head
	if [ "${PWD}" = '/' ]; then
		head=''
	else
		head="$(dirname "${PWD}")"
		if [ "${head}" = '/' ]; then
			head="/"
		else
			head="${head}/"
		fi
	fi
	echo "${head}"
}

pwd_tail() {
	echo "$(basename "${PWD}")"
}

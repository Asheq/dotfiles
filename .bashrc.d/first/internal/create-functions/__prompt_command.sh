# TODO: Set fancy or non-fancy icons based on $USE_FANCY_SYMBOLS.

function __prompt_command() {
	local exit="$?"
	local primary_color
	if [ "${exit}" != 0 ]; then
		primary_color='\[\e[0;31m\]' # Red
	else
		primary_color='\[\e[0;36m\]' # Cyan
	fi
	local secondary_color='\[\e[0;02m\]' # Gray
	local reset_color='\[\e[0m\]'

	PS1='\n'
	PS1+="${secondary_color}"
	PS1+='┌─ '
	PS1+='$(pwd_head)'
	PS1+="${primary_color}"
	PS1+='$(pwd_tail) '
	PS1+="${secondary_color}"
	PS1+='$(parse_git_branch)'
	PS1+='$([ \j -gt 0 ] && echo  \ \j\ )'
	PS1+='$(shell_level)'
	PS1+='  \u '
	if [ -n "${SSH_CLIENT}" ] || [ -n "${SSH_TTY}" ]; then
		PS1+='  \h '
	fi
	PS1+='\n'
	PS1+="${secondary_color}"
	PS1+='└─ '
	PS1+="${reset_color}"
}

function pwd_head() {
	local l_head
	if [ "${PWD}" = '/' ] || [ "${PWD}" = "${HOME}" ]; then
		l_head=''
	else
		l_head="$(dirname "${PWD}")"
		[[ "${l_head}" =~ ^"$HOME"(/|$) ]] && l_head="~${l_head#$HOME}"
		if [ "${l_head}" = '/' ]; then
			l_head="/"
		else
			l_head="${l_head}/"
		fi
	fi
	echo "${l_head}"
}

function pwd_tail() {
	local l_tail
	if [ "${PWD}" = "${HOME}" ]; then
		l_tail='~'
	else
		l_tail="$(basename "${PWD}")"
	fi
	echo "${l_tail}"
}

function shell_level() {
	if [ -n "${TMUX}" ]; then
		if [ "${SHLVL}" -gt 2 ]; then
			echo " ${SHLVL} "
		fi
	else
		if [ "${SHLVL}" -gt 1 ]; then
			echo " ${SHLVL} "
		fi
	fi
}

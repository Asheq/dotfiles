# TODO: Set fancy or non-fancy icons based on $USE_FANCY_SYMBOLS.

# ------------------------------------------------------------------------------
# The all-important __prompt_command function
# ------------------------------------------------------------------------------
function __prompt_command() {

	# Color palette
	local exit_code="$?"
	local primary_color
	if [ "${exit_code}" != 0 ]; then
		primary_color='\[\e[0;31m\]' # Red
	else
		primary_color='\[\e[0;36m\]' # Cyan
	fi
	local secondary_color='\[\e[0;02m\]' # Gray
	local reset_color='\[\e[0m\]'

	# Set PS1
	PS1='\n'
	PS1+="${secondary_color}"
	PS1+='┌─ '
	PS1+='$(pwd_head)'
	PS1+="${primary_color}"
	PS1+='$(pwd_tail) '
	PS1+="${secondary_color}"
	PS1+='$(parse_git_branch)'
	PS1+='$(jobs_count_flag)'
	PS1+='$(is_not_login_shell_flag)'
	PS1+='$(user_flag)'
	if [ -n "${SSH_CONNECTION}" ]; then
		PS1+='[  \h] '
	fi
	PS1+='\n'
	PS1+="${secondary_color}"
	PS1+='└─ '
	PS1+="${reset_color}"
}

# ------------------------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------------------------
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

function is_not_login_shell_flag() {
	if ! shopt -q login_shell ; then
		echo "[ ] "
	fi
}

function shell_level_flag() {
	if [ "${SHLVL}" -ne 0 ] ; then
		local flag='['
		flag+=$(repeat "" "${SHLVL}")
		flag+='] '
		echo "${flag}"
	fi
}

function jobs_count_flag() {
	local count="$(jobs | wc -l)"
	if [ "${count}" -ne 0 ] ; then
		local flag='['
		flag+=$(repeat " " "${count}")
		flag+='] '
		echo "${flag}"
	fi
}

function user_flag() {
	local username="$(whoami)"
	if [ "${username}" != "${LOGNAME}" ] ; then
		echo "[  ${username}] "
	fi
}

function repeat() {
	local str=$1
	local num=$2
	if [ "${num}" -ne 0 ] ; then
		printf "${str}"'%.0s' $(seq 1 "${num}")
	fi
}
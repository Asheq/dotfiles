if [ "${USE_FANCY_GLYPHS}" = "yes" ]; then
	jobs_symbol=' '
	not_login_shell_symbol=' '
	shell_level_symbol=' '
	user_symbol=' '
else
	jobs_symbol='j'
	not_login_shell_symbol='»'
	shell_level_symbol='sh'
	user_symbol='u '
fi

# TODO: Change the [ to [[

# ------------------------------------------------------------------------------
# The all-important __prompt_command function
# ------------------------------------------------------------------------------
function __prompt_command() {

	# Color palette
	local exit_code="$?"
	local bright_color='\[\e[0;1m\]' # White Bold
	local faded_color='\[\e[0;02m\]' # Gray

	local exit_code_color
	if [ "${exit_code}" != 0 ]; then
		exit_code_color='\[\e[0;31m\]' # Red
	else
		exit_code_color='\[\e[0;34m\]' # Blue
	fi
	local reset_color='\[\e[0m\]'

	# Set PS1
	PS1='\n'
	PS1+="${exit_code_color}"
	PS1+='┌─ '
	PS1+="${faded_color}"
	PS1+='$(pwd_head)'
	PS1+="${bright_color}"
	PS1+='$(pwd_tail) '
	PS1+="${faded_color}"
	PS1+='$(parse_git_branch)'
	PS1+='$(jobs_count_flag)'
	PS1+='$(is_not_login_shell_flag)'
	# PS1+='$(shell_level_flag)'
	PS1+='$(user_flag)'
	if [ -n "${SSH_CONNECTION}" ]; then
		PS1+='[  \h] '
	fi
	PS1+='\n'
	PS1+="${exit_code_color}"
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
		echo "[${not_login_shell_symbol}] "
	fi
}

function shell_level_flag() {
	if [ "${SHLVL}" -ne 0 ] ; then
		local flag='['
		flag+=$(repeat "${shell_level_symbol}" "${SHLVL}")
		flag+='] '
		echo "${flag}"
	fi
}

function jobs_count_flag() {
	local count="$(\jobs | wc -l)"
	if [ "${count}" -ne 0 ] ; then
		local flag='['
		flag+=$(repeat "${jobs_symbol}" "${count}")
		flag+='] '
		echo "${flag}"
	fi
}

function user_flag() {
	local username="$(whoami)"
	if [ "${username}" != "${LOGNAME}" ] ; then
		echo "[${user_symbol} ${username}] "
	fi
}

function repeat() {
	local str=$1
	local num=$2
	if [ "${num}" -ne 0 ] ; then
		printf "${str}"'%.0s' $(seq 1 "${num}")
	fi
}

# Text style ANSI escape codes
__style_reset='\[\e[0m\]'
__style_connector='\[\e[0;36m\]'
__style_primary='\[\e[0;30;46m\]'
__style_secondary='\[\e[0;30;43m\]'
__style_tertiary='\[\e[0;30;47m\]'
__style_error='\[\e[0;31m\]'
__style_success='\[\e[0;32m\]'

# Glyphs
__glyph_host='Hostname'
__glyph_jobs='Jobs'
__glyph_non_login='Non-login'
__glyph_success='✔'
__glyph_user='User'

function __prompt_command() {
	local start='\[\e]133;A\e\\\]'
	local exit_code="$?"
	PS1="${start}"
	PS1+="${__style_connector}╭─"
	PS1+="$(__prompt_section_pwd)"
	PS1+="$(__prompt_section_git)"
	PS1+="$(__prompt_section_other)"
	PS1+="$(__prompt_section_exit_code ${exit_code})"
	PS1+="\n"
	PS1+="${__style_connector}╰─$ "
	PS1+="${__style_reset}"
}

function __prompt_section_pwd() {
	echo "${__style_primary} \w "
}

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_SHOWUPSTREAM=true
export GIT_PS1_STATESEPARATOR=' '
export GIT_PS1_DESCRIBE_STYLE='branch'
export GIT_PS1_SHOWCOLORHINTS=true # Only works when using __git_ps1 for PROMPT_COMMAND
export GIT_PS1_HIDE_IF_PWD_IGNORED=true
function __prompt_section_git() {
	if command -v __git_ps1 &> /dev/null; then
		local git_ps1_output
		git_ps1_output="$(__git_ps1)"
	fi

	if [[ "${git_ps1_output}" != "" ]] ; then
		local output="${git_ps1_output:2:-1}"
		echo "${__style_reset} ${output} "
	fi
}

function __prompt_section_other() {
	local flag_array=("$(__prompt_flag_node)" "$(__prompt_flag_npm)" "$(__prompt_flag_user)" "$(__prompt_flag_host)" "$(__prompt_flag_jobs)" "$(__prompt_flag_not_login_shell)")

	local flagstring=""
	for flag in "${flag_array[@]}" ; do
		if [[ "${flag}" != "" ]] ; then
			flagstring+="${flag}  "
		fi
	done

	flagstring="${flagstring/%  /}"

	if [[ "${flagstring}" != "" ]] ; then
		echo "${__style_tertiary} ${flagstring} "
	fi
}

function __prompt_flag_node() {
	if command -v node &> /dev/null; then
		echo "node=$(node -v)"
	fi
}

function __prompt_flag_npm() {
	if command -v npm &> /dev/null; then
		echo "npm=$(npm -v)"
	fi
}

function __prompt_flag_python() {
	if command -v python &> /dev/null; then
		echo "python=$(python --version)"
	fi
}

function __prompt_flag_pip() {
	if command -v pip &> /dev/null; then
		echo "pip=$(pip --version)"
	fi
}

function __prompt_flag_user() {
	if [[ "${USER}" != "${LOGNAME}" ]] ; then
		echo "${__glyph_user}=${USER}"
	fi
}

function __prompt_flag_host() {
	if [[ -n "${SSH_CONNECTION}" ]]; then
		echo "${__glyph_host}=${HOSTNAME}"
	fi
}

function __prompt_flag_jobs() {
	local count
	count="$(\jobs | wc -l | sed 's/^ *\(\d*\)/\1/')"
	if [[ "${count}" -ne 0 ]] ; then
		echo "${__glyph_jobs}=${count}"
	fi
}

function __prompt_flag_not_login_shell() {
	if ! shopt -q login_shell ; then
		echo "${__glyph_non_login}"
	fi
}

function __prompt_section_exit_code() {
	local exit_code="$1"
	if [[ "${exit_code}" != 0 ]]; then
		echo "${__style_error} ${exit_code} "
	else
		echo "${__style_success} ${__glyph_success} "
	fi
}

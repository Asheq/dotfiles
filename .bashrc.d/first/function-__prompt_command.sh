# ------------------------------------------------------------------------------
# The all-important __prompt_command function
# ------------------------------------------------------------------------------
function __prompt_command() {
  local exit_code="$?"
  local colors_exit_code
  if [[ "${exit_code}" != 0 ]]; then
    colors_exit_code="${ANSI_RED}"
  else
    colors_exit_code="${ANSI_BLUE}"
  fi

  # Set PS1
  PS1='\n'
  PS1+="${ANSI_WHITE}"
  PS1+='$(pwd_head)'
  PS1+="${ANSI_WHITE_BOLD}"
  PS1+='$(pwd_tail) '
  PS1+="${ANSI_WHITE}"
  PS1+='$(parse_git_branch)' # really slow
  PS1+='$(user_flag)'
  PS1+='$(hostname_flag)'
  PS1+='$(jobs_count_flag)' # slow
  # PS1+='$(shell_level_flag)' # slow, noisy
  PS1+='$(is_not_login_shell_flag)'
  PS1+='\n'
  PS1+="${colors_exit_code}"
  PS1+=':'
  PS1+="${ANSI_RESET}"
}

# ------------------------------------------------------------------------------
# Helper functions
# ------------------------------------------------------------------------------
function pwd_head() {
  local l_head
  if [[ "${PWD}" = '/' ]] || [[ "${PWD}" = "${HOME}" ]]; then
    l_head=''
  else
    l_head="${PWD%/*}"
    [[ "${l_head}" =~ ^"$HOME"(/|$) ]] && l_head="~${l_head#$HOME}"
    if [[ "${l_head}" = '/' ]]; then
      l_head="/"
    else
      l_head="${l_head}/"
    fi
  fi
  echo "${l_head}"
}

function pwd_tail() {
  local l_tail
  if [[ "${PWD}" = "${HOME}" ]]; then
    l_tail='~'
  elif [[ "${PWD}" = '/' ]]; then
    l_tail='/'
  else
    l_tail="${PWD##*/}"
  fi
  echo "${l_tail}"
}

function user_flag() {
  if [[ "${USER}" != "${LOGNAME}" ]] ; then
    echo "[${symbols_user} ${USER}] "
  fi
}

function hostname_flag() {
  if [[ -n "${SSH_CONNECTION}" ]]; then
    echo "[${symbols_hostname} ${HOSTNAME}] "
  fi
}

function jobs_count_flag() {
  local count="$(\jobs | wc -l)"
  if [[ "${count}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${symbols_jobs}" "${count}")
    flag+='] '
    echo "${flag}"
  fi
}

function shell_level_flag() {
  if [[ "${SHLVL}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${symbols_shell_level}" "${SHLVL}")
    flag+='] '
    echo "${flag}"
  fi
}

function is_not_login_shell_flag() {
  if ! shopt -q login_shell ; then
    echo "[${symbols_not_login_shell}] "
  fi
}

function repeat() {
  local str=$1
  local num=$2
  if [[ "${num}" -ne 0 ]] ; then
    printf "${str}"'%.0s' $(seq 1 "${num}")
  fi
}

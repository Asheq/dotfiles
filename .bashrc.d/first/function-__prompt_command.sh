if [ "${USE_FANCY_GLYPHS}" = "yes" ]; then
  # TODO: Use glyphs
  hostname_symbol='h'
  jobs_symbol='j'
  not_login_shell_symbol='»'
  shell_level_symbol='s'
  user_symbol='u'
else
  hostname_symbol='h '
  jobs_symbol='j'
  not_login_shell_symbol='»'
  shell_level_symbol='s'
  user_symbol='u'
fi

# Colors
# TODO: Replace with tput?
# Reference: https://www.tecmint.com/customize-bash-colors-terminal-prompt-linux
colors_bold_white='\[\e[1;39m\]'
colors_white='\[\e[0;37m\]'
colors_bold_red='\[\e[1;31m\]'
colors_bold_blue='\[\e[1;34m\]'
colors_reset='\[\e[0m\]'

# ------------------------------------------------------------------------------
# The all-important __prompt_command function
# ------------------------------------------------------------------------------
function __prompt_command() {
  local exit_code="$?"
  local colors_exit_code
  if [[ "${exit_code}" != 0 ]]; then
    colors_exit_code="${colors_bold_red}"
  else
    colors_exit_code="${colors_bold_blue}"
  fi

  # Set PS1
  PS1='\n'
  PS1+="${colors_white}"
  PS1+='$(pwd_head)'
  PS1+="${colors_bold_white}"
  PS1+='$(pwd_tail) '
  PS1+="${colors_white}"
  PS1+='$(parse_git_branch)' # really slow
  PS1+='$(user_flag)'
  PS1+='$(hostname_flag)'
  PS1+='$(jobs_count_flag)' # slow
  # PS1+='$(shell_level_flag)' # slow, noisy
  PS1+='$(is_not_login_shell_flag)'
  PS1+='\n'
  PS1+="${colors_exit_code}"
  PS1+=':'
  PS1+="${colors_reset}"
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
    echo "[${user_symbol} ${USER}] "
  fi
}

function hostname_flag() {
  if [[ -n "${SSH_CONNECTION}" ]]; then
    echo "[${hostname_symbol} ${HOSTNAME}] "
  fi
}

function jobs_count_flag() {
  local count="$(\jobs | wc -l)"
  if [[ "${count}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${jobs_symbol}" "${count}")
    flag+='] '
    echo "${flag}"
  fi
}

function shell_level_flag() {
  if [[ "${SHLVL}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${shell_level_symbol}" "${SHLVL}")
    flag+='] '
    echo "${flag}"
  fi
}

function is_not_login_shell_flag() {
  if ! shopt -q login_shell ; then
    echo "[${not_login_shell_symbol}] "
  fi
}

function repeat() {
  local str=$1
  local num=$2
  if [[ "${num}" -ne 0 ]] ; then
    printf "${str}"'%.0s' $(seq 1 "${num}")
  fi
}

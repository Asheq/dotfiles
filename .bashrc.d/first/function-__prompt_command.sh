function __prompt_command() {
  local exit_code="$?"
  local colors_exit_code
  if [[ "${exit_code}" != 0 ]]; then
    colors_exit_code="${ANSI_RED}"
  else
    colors_exit_code="${ANSI_BLUE}"
  fi

  PS1='\n'
  PS1+="${colors_exit_code}"
  PS1+="┏━ "
  PS1+="${ANSI_WHITE}"
  PS1+='$(pwd_head)'
  PS1+="${ANSI_WHITE_BOLD}"
  PS1+='$(pwd_tail) '
  PS1+="${ANSI_WHITE}"
  PS1+='$(parse_git_branch)'
  PS1+='$(user_flag)'
  PS1+='$(hostname_flag)'
  PS1+='$(jobs_count_flag)'
  PS1+='$(is_not_login_shell_flag)'
  PS1+='\n'
  PS1+="${colors_exit_code}"
  PS1+='┗━ '
  PS1+="${ANSI_RESET}"
}

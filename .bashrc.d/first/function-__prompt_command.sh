function __prompt_command() {
  local exit_code="$?"
  if [[ "${exit_code}" != 0 ]]; then
    exit_symbol="  ${ANSI_RED_FG}${symbols_exit_code_fail} ${exit_code}${ANSI_WHITE_FG}"
  else
    exit_symbol="  ${ANSI_GREEN_FG}${symbols_exit_code_success}${ANSI_WHITE_FG}"
  fi

  PS1="\n"
  PS1+="${ANSI_WHITE_FG}"
  PS1+="┌─ "
  PS1+='$(pwd_head)'
  PS1+="${ANSI_WHITE_FG_BOLD}"
  PS1+='$(pwd_tail)'
  PS1+="${ANSI_WHITE_FG}"
  PS1+='$(git_flag)'
  PS1+='$(user_flag)'
  PS1+='$(hostname_flag)'
  PS1+='$(jobs_count_flag)'
  PS1+='$(is_not_login_shell_flag)'
  PS1+="${exit_symbol}"
  PS1+="\n"
  PS1+="${ANSI_WHITE_FG}"
  PS1+='└─ '
  PS1+="${ANSI_RESET}"
}

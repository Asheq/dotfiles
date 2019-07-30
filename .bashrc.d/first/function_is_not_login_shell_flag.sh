function is_not_login_shell_flag() {
  if ! shopt -q login_shell ; then
    echo "  ${symbols_not_login_shell}"
  fi
}

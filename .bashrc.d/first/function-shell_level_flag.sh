function shell_level_flag() { # TODO: slow
  if [[ "${SHLVL}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${symbols_shell_level}" "${SHLVL}")
    flag+='] '
    echo "${flag}"
  fi
}

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

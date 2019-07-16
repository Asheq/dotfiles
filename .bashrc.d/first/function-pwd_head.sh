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

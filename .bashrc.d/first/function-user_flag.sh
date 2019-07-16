function user_flag() {
  if [[ "${USER}" != "${LOGNAME}" ]] ; then
    echo "[${symbols_user} ${USER}] "
  fi
}

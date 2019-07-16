function hostname_flag() {
  if [[ -n "${SSH_CONNECTION}" ]]; then
    echo "[${symbols_hostname} ${HOSTNAME}] "
  fi
}

function repeat() {
  local str=$1
  local num=$2
  if [[ "${num}" -ne 0 ]] ; then
    printf "${str}"'%.0s' $(seq 1 "${num}")
  fi
}

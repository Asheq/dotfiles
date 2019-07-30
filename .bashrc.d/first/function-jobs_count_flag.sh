function jobs_count_flag() { # TODO: This is slow
  local count="$(\jobs | wc -l | sed 's/^ *\(\d*\)/\1/')"
  if [[ "${count}" -ne 0 ]] ; then
    flag+=$(repeat "${symbols_jobs}" "${count}")
    echo "  ${symbols_jobs} ${count}"
  fi
}

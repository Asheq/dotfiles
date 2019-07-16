function jobs_count_flag() { # TODO: This is slow
  local count="$(\jobs | wc -l)"
  if [[ "${count}" -ne 0 ]] ; then
    local flag='['
    flag+=$(repeat "${symbols_jobs}" "${count}")
    flag+='] '
    echo "${flag}"
  fi
}

if [ "${USE_FANCY_GLYPHS}" = "yes" ]; then
  symbols_branch=' '
  symbols_directory=' '
  symbols_exit_code_fail=' '
  symbols_exit_code_success=' '
  symbols_hostname=' '
  symbols_jobs=' '
  symbols_not_login_shell=' '
  symbols_user=' '
else
  symbols_branch='β'
  symbols_directory='Δ'
  symbols_exit_code_fail='✖'
  symbols_exit_code_success='✔'
  symbols_hostname='H'
  symbols_jobs='J'
  symbols_not_login_shell='NL'
  symbols_user='U'
fi

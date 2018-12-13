# function dirvish() {
# 	nvim -c 'Dirvish' -c 'autocmd VimLeave * call writefile([expand("%:h")], expand("$HOME") . "/.dirvishdir")'; LASTDIR=`cat ${HOME}/.dirvishdir`; cd "${LASTDIR}"
# }

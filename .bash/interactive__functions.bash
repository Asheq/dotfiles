# Bash prompt
# ==============================================================================
# ANSI escape codes
__prompt_ansi_escape_code_reset='\[\e[0m\]'
__prompt_ansi_escape_code_connector='\[\e[0;35m\]'
__prompt_ansi_escape_code_primary='\[\e[2;30;45m\]'
__prompt_ansi_escape_code_secondary='\[\e[0;30;47m\]'
__prompt_ansi_escape_code_tertiary='\[\e[0;30;107m\]'
__prompt_ansi_escape_code_error='\[\e[0;31m\]'
__prompt_ansi_escape_code_success='\[\e[0;32m\]'

# Glyphs
__prompt_glyph_host='@'
__prompt_glyph_jobs='J'
__prompt_glyph_logout='>'
__prompt_glyph_success='✔'
__prompt_glyph_user='U'

function __prompt_command() {
  local exit_code="$?"
  PS1=""
  PS1+="${__prompt_ansi_escape_code_connector}┌─"
  PS1+="$(__prompt_section_pwd)"
  PS1+="$(__prompt_section_git)"
  PS1+="$(__prompt_section_other)"
  PS1+="$(__prompt_section_exit_code ${exit_code})"
  PS1+="\n"
  PS1+="${__prompt_ansi_escape_code_connector}└─$ "
  PS1+="${__prompt_ansi_escape_code_reset}"
}

function __prompt_section_pwd() {
  echo "${__prompt_ansi_escape_code_primary} \w "
}

# shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=true
# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=true
# shellcheck disable=SC2034
GIT_PS1_SHOWUNTRACKEDFILES=true
# shellcheck disable=SC2034
GIT_PS1_SHOWUPSTREAM='verbose'
# shellcheck disable=SC2034
GIT_PS1_DESCRIBE_STYLE='branch'
# shellcheck disable=SC2034
GIT_PS1_HIDE_IF_PWD_IGNORED=true
function __prompt_section_git() {
  git_ps1_output="$(__git_ps1)"

  if [[ "${git_ps1_output}" != "" ]] ; then
    output="${git_ps1_output:2:-1}"
    echo "${__prompt_ansi_escape_code_secondary} ${output} "
  fi
}

function __prompt_section_other() {
  flag_array=("N=$(node -v)" "$(__prompt_flag_user)" "$(__prompt_flag_host)" "$(__prompt_flag_jobs)" "$(__prompt_flag_not_login_shell)")

  flagstring=""
  for flag in "${flag_array[@]}" ; do
    if [[ "${flag}" != "" ]] ; then
      flagstring+="${flag}  "
    fi
  done

  flagstring="${flagstring/%  /}"

  if [[ "${flagstring}" != "" ]] ; then
    echo "${__prompt_ansi_escape_code_tertiary} ${flagstring} "
  fi
}

function __prompt_section_exit_code() {
  local exit_code="$1"
  if [[ "${exit_code}" != 0 ]]; then
    echo "${__prompt_ansi_escape_code_error} ${exit_code} "
  else
    echo "${__prompt_ansi_escape_code_success} ${__prompt_glyph_success} "
  fi
}

function __prompt_flag_user() {
  if [[ "${USER}" != "${LOGNAME}" ]] ; then
    echo "${__prompt_glyph_user}=${USER}"
  fi
}

function __prompt_flag_host() {
  if [[ -n "${SSH_CONNECTION}" ]]; then
    echo "${__prompt_glyph_host}=${HOSTNAME}"
  fi
}

function __prompt_flag_jobs() {
  local count
  count="$(\jobs | wc -l | sed 's/^ *\(\d*\)/\1/')"
  if [[ "${count}" -ne 0 ]] ; then
    echo "${__prompt_glyph_jobs}=${count}"
  fi
}

function __prompt_flag_not_login_shell() {
  if ! shopt -q login_shell ; then
    echo "${__prompt_glyph_logout}"
  fi
}

# Print colors
# ==============================================================================
function print_colors() {
  for clbg in {40..47} {100..107} 49 ; do
    for clfg in {30..37} {90..97} 39 ; do
      for attr in {0..9} ; do
        echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
      done
      echo
    done
  done
}

function print_colors_256() {
  for fgbg in 38 48 ; do
    for color in {0..255} ; do
      printf "\e[${fgbg};5;%sm  %3s  \e[0m" "$color" "$color"
      if [ $(((color + 1) % 6)) == 4 ] ; then
        echo
      fi
    done
    echo
  done
}

function print_colors_spectrum() {
  awk -v term_cols="${width:-$(tput cols || echo 80)}" 'BEGIN{
      s="/\\";
      for (colnum = 0; colnum<term_cols; colnum++) {
          r = 255-(colnum*255/term_cols);
          g = (colnum*510/term_cols);
          b = (colnum*255/term_cols);
          if (g>255) g = 510-g;
          printf "\033[48;2;%d;%d;%dm", r,g,b;
          printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
          printf "%s\033[0m", substr(s,colnum%2+1,1);
      }
      printf "\n";
  }'
}

# Miscellaneous
# ==============================================================================
function print_args() {
  local arg
  for arg in "$@"
  do
    echo "Argument: ${arg}"
  done
  echo "Count: $#"
}

# shellcheck disable=SC2034
FZF_CTRL_T_COMMAND="all_git_branches_normalized"
all_git_branches_normalized() {
  branches=$(git branch --all | grep -v HEAD | sed "s/.* //") &&
    echo "$branches"
}

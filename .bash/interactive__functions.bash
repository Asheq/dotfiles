# ------------------------------------------------------------------------------
# __prompt_command
# ------------------------------------------------------------------------------
function __prompt_command() {
  local exit_code="$?"
  PS1=""
  PS1+="${__prompt_ansi_primary_connector}┌─"
  PS1+="$(__prompt_section_pwd)"
  PS1+="$(__prompt_section_git)"
  PS1+="$(__prompt_section_other)"
  PS1+="$(__prompt_section_exit_code ${exit_code})"
  PS1+="\n"
  PS1+="${__prompt_ansi_primary_connector}└─$ "
  PS1+="${__prompt_ansi_reset}"

  # local is_login_shell
  # if shopt -q login_shell ; then
  #   is_login_shell=true
  # else
  #   is_login_shell=false
  # fi

  # PS1="$(node /Users/asheq.imran/dev/github.com/Asheq/prompt/lib/main.js -e $exit_code -l $is_login_shell)"
}

# ------------------------------------------------------------------------------
# __prompt_command helpers
# ------------------------------------------------------------------------------
# ANSI escape codes to format text
__prompt_ansi_reset='\[\e[0m\]'

__prompt_ansi_primary_connector='\[\e[0;35m\]'
__prompt_ansi_primary='\[\e[2;30;45m\]'
__prompt_ansi_primary_bright='\[\e[1;30;45m\]'

__prompt_ansi_secondary='\[\e[0;30;47m\]'

__prompt_ansi_tertiary='\[\e[0;30;107m\]'

__prompt_ansi_error='\[\e[0;31m\]'
__prompt_ansi_success='\[\e[0;32m\]'

# Glyphs
__prompt_glyph_success='✔'
__prompt_glyph_jobs='J'
__prompt_glyph_logout='>'
__prompt_glyph_host='@'
__prompt_glyph_user='U'

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

function __prompt_section_pwd() {
  echo "${__prompt_ansi_primary} $(pwd_head)${__prompt_ansi_primary_bright}$(pwd_tail) "
}

GIT_PS1_SHOWDIRTYSTATE=true
GIT_PS1_SHOWSTASHSTATE=true
GIT_PS1_SHOWUNTRACKEDFILES=true
GIT_PS1_SHOWUPSTREAM='verbose'
GIT_PS1_DESCRIBE_STYLE='branch'
GIT_PS1_HIDE_IF_PWD_IGNORED=true
function __prompt_section_git() {
  git_ps1_output="$(__git_ps1)"

  if [[ "${git_ps1_output}" != "" ]] ; then
    output="${git_ps1_output:2:-1}"
    echo "${__prompt_ansi_secondary} ${output} "
  fi
}

function __prompt_section_other() {
  flag_array=("Node($(node -v))" "$(__prompt_flag_user)" "$(__prompt_flag_host)" "$(__prompt_flag_jobs)" "$(__prompt_flag_not_login_shell)")

  flagstring=""
  for flag in "${flag_array[@]}" ; do
    if [[ "${flag}" != "" ]] ; then
      flagstring+="${flag}  "
    fi
  done

  flagstring="${flagstring/%  /}"

  if [[ "${flagstring}" != "" ]] ; then
    echo "${__prompt_ansi_tertiary} ${flagstring} "
  fi
}

function __prompt_section_exit_code() {
  local exit_code="$1"
  if [[ "${exit_code}" != 0 ]]; then
    echo "${__prompt_ansi_error} ${exit_code} "
  else
    echo "${__prompt_ansi_success} ${__prompt_glyph_success} "
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

# ------------------------------------------------------------------------------
# Print colors
# ------------------------------------------------------------------------------
function print_colors() {
  # Background
  for clbg in {40..47} {100..107} 49 ; do
    # Foreground
    for clfg in {30..37} {90..97} 39 ; do
      # Formatting
      for attr in {0..9} ; do
        # Print the result
        echo -en "\e[${attr};${clbg};${clfg}m ^[${attr};${clbg};${clfg}m \e[0m"
      done
      echo # Newline
    done
  done
}

function print_256_colors() {
  for fgbg in 38 48 ; do # Foreground / Background
    for color in {0..255} ; do # Colors
      # Display the color
      printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
      # Display 6 colors per lines
      if [ $(((color + 1) % 6)) == 4 ] ; then
        echo # New line
      fi
    done
    echo # New line
  done
}

function print_color_spectrum() {
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

# ------------------------------------------------------------------------------
# print_args
# ------------------------------------------------------------------------------
function print_args() {
  local arg
  for arg in "$@"
  do
    echo "Argument: ${arg}"
  done
  echo "Count: $#"
}

# ------------------------------------------------------------------------------
# setproxy and unsetproxy
# ------------------------------------------------------------------------------
function setproxy() {
  local proxy_url=''
  local no_proxy_urls=''

  # Uppercase
  export {HTTP,HTTPS,FTP,ALL}_PROXY="${proxy_url}"
  export NO_PROXY="${no_proxy_urls}"

  # Lowercase
  export {http,https,ftp,all}_proxy="${proxy_url}"
  export no_proxy="${no_proxy_urls}"
}

function unsetproxy() {
  # Uppercase
  unset {HTTP,HTTPS,FTP,ALL}_PROXY
  unset NO_PROXY

  # Lowercase
  unset {http,https,ftp,all}_proxy
  unset no_proxy
}


# Usage: mcd this/is/a/directory/path
# Makes directory (including intermediate directories) and cds into it
mcd () {
    \mkdir -pv "$1"
    \cd "$1" || exit
}

add_icu () {
  export NODE_ICU_DATA='/Users/asheq.imran/.nvm/versions/node/v8.12.0/lib/node_modules/full-icu'
}

all_git_branches_normalized() {
  branches=$(git branch --all | grep -v HEAD | sed "s/.* //") &&
    echo "$branches"
}

f() {
    fff "$@"
    \cd "$(cat "${XDG_CACHE_HOME:=${HOME}/.cache}/fff/.fff_d")" || exit
}

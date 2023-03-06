# Bash prompt
# ==============================================================================
# Text style ANSI escape codes
__style_reset='\[\e[0m\]'
__style_connector='\[\e[0;34m\]'
__style_primary='\[\e[0;30;44m\]'
__style_secondary='\[\e[0;30;43m\]'
__style_tertiary='\[\e[0;30;47m\]'
__style_error='\[\e[0;31m\]'
__style_success='\[\e[0;32m\]'

# Glyphs
__glyph_host='Hostname'
__glyph_jobs='Jobs'
__glyph_logout='Non-login'
__glyph_success='✔'
__glyph_user='User'

function __prompt_command() {
    local exit_code="$?"
    PS1=""
    PS1+="${__style_connector}┌─"
    PS1+="$(__prompt_section_pwd)"
    PS1+="$(__prompt_section_git)"
    PS1+="$(__prompt_section_other)"
    PS1+="$(__prompt_section_exit_code ${exit_code})"
    PS1+="\n"
    PS1+="${__style_connector}└─$ "
    PS1+="${__style_reset}"
}

function __prompt_section_pwd() {
    echo "${__style_primary} \w "
}

# shellcheck disable=SC2034
GIT_PS1_SHOWDIRTYSTATE=true
# shellcheck disable=SC2034
GIT_PS1_SHOWSTASHSTATE=true
# shellcheck disable=SC2034
GIT_PS1_SHOWUNTRACKEDFILES=true
# shellcheck disable=SC2034
GIT_PS1_SHOWUPSTREAM=true
# shellcheck disable=SC2034
GIT_PS1_STATESEPARATOR=' '
# shellcheck disable=SC2034
GIT_PS1_DESCRIBE_STYLE='branch'
# shellcheck disable=SC2034
GIT_PS1_SHOWCOLORHINTS=true # Only works when using __git_ps1 for PROMPT_COMMAND
# shellcheck disable=SC2034
GIT_PS1_HIDE_IF_PWD_IGNORED=true
function __prompt_section_git() {
    if command -v __git_ps1 &> /dev/null; then
        git_ps1_output="$(__git_ps1)"
    fi

    if [[ "${git_ps1_output}" != "" ]] ; then
        output="${git_ps1_output:2:-1}"
        echo "${__style_secondary} ${output} "
    fi
}

function __prompt_section_other() {
    flag_array=("$(__prompt_flag_node)" "$(__prompt_flag_npm)" "$(__prompt_flag_user)" "$(__prompt_flag_host)" "$(__prompt_flag_jobs)" "$(__prompt_flag_not_login_shell)")

    flagstring=""
    for flag in "${flag_array[@]}" ; do
        if [[ "${flag}" != "" ]] ; then
            flagstring+="${flag}  "
        fi
    done

    flagstring="${flagstring/%  /}"

    if [[ "${flagstring}" != "" ]] ; then
        echo "${__style_tertiary} ${flagstring} "
    fi
}

function __prompt_flag_node() {
    if command -v node &> /dev/null; then
        echo "node=$(node -v)"
    fi
}

function __prompt_flag_npm() {
    if command -v npm &> /dev/null; then
        echo "npm=$(npm -v)"
    fi
}

function __prompt_flag_python() {
    if command -v python &> /dev/null; then
        echo "python=$(python --version)"
    fi
}

function __prompt_flag_pip() {
    if command -v pip &> /dev/null; then
        echo "pip=$(pip --version)"
    fi
}

function __prompt_flag_user() {
    if [[ "${USER}" != "${LOGNAME}" ]] ; then
        echo "${__glyph_user}=${USER}"
    fi
}

function __prompt_flag_host() {
    if [[ -n "${SSH_CONNECTION}" ]]; then
        echo "${__glyph_host}=${HOSTNAME}"
    fi
}

function __prompt_flag_jobs() {
    local count
    count="$(\jobs | wc -l | sed 's/^ *\(\d*\)/\1/')"
    if [[ "${count}" -ne 0 ]] ; then
        echo "${__glyph_jobs}=${count}"
    fi
}

function __prompt_flag_not_login_shell() {
    if ! shopt -q login_shell ; then
        echo "${__glyph_logout}"
    fi
}

function __prompt_section_exit_code() {
    local exit_code="$1"
    if [[ "${exit_code}" != 0 ]]; then
        echo "${__style_error} ${exit_code} "
    else
        echo "${__style_success} ${__glyph_success} "
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

function gps() {
    echo "
    *  has UNSTAGED changes
    +  has STAGED changes
    $  something is STASHED
    %  has UNTRACKED files
    <  branch is BEHIND upstream
    >  branch is AHEAD of upstream
   <>  branch has DIVERGED from upstream
    =  branch has NO DIFFERENCE with upstream
    "
}

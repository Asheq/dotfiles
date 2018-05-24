#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#

###############################################################################
### Guard
###############################################################################
echo 'Executing ~/.bashrc'

# If not running bash interactively, do not run this script.
[[ "$-" != *i* ]] && return

echo 'Running bash interactively so continuing execution of ~/.bashrc'

###############################################################################
### shopt
###############################################################################

# Append to the history file, don't overwrite it.
shopt -s histappend

# Save multi-line commands as one command.
shopt -s cmdhist

# Update window size after every command.
shopt -s checkwinsize

# Prepend cd to directory names automatically.
shopt -s autocd 2> /dev/null

# Correct spelling errors in arguments supplied to cd.
shopt -s cdspell 2> /dev/null

###############################################################################
### bind
###############################################################################

# Enable history expansion with space.
# E.g. typing !!<space> will replace the !! with your last command.
bind Space:magic-space

###############################################################################
### set
###############################################################################

# Prevent file overwrite on stdout redirection.
# Use `>|` to force redirection to an existing file.
set -o noclobber

###############################################################################
### alias
###############################################################################

# ------------------------------------------------------
# Miscellaneous
# ------------------------------------------------------
alias hr='printf "%*s\n" "${COLUMNS:-$(tput cols)}" "" | tr " " -'
alias info='info --vi-keys'
alias o='open'
alias perftest='~/Development/github.com/p-e-w/ternimal/ternimal length=20 thickness=70,15,0,1,0 padding=10 radius=5 gradient=0.03:#ffff00,0.15:#0000ff,0.3:#ff0000,0.5:#00ff00'
alias r=ranger

# ------------------------------------------------------
# (Neo)vim
# ------------------------------------------------------
alias vim='nvim'
alias vi='vim'
alias v='vi'

# ------------------------------------------------------
# ls
# ------------------------------------------------------
alias ls='ls -hFG'
alias l='ls'
alias la='ls -A'
alias ll='ls -la'

# ------------------------------------------------------
# cd
# ------------------------------------------------------
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'

# ------------------------------------------------------
# directories
# ------------------------------------------------------
alias md='mkdir -p'
alias rd=rmdir

# ------------------------------------------------------
# npm
# ------------------------------------------------------
alias npmis="npm i -S "
alias npmid="npm i -D "
alias npmig="npm i -g "

# ------------------------------------------------------
# bower
# ------------------------------------------------------
alias bis="bower i -S"
alias bid="bower i -D"

# ------------------------------------------------------
# tmux
# ------------------------------------------------------
alias ta='tmux attach -t'
alias ts='tmux new-session -s'
alias tl='tmux list-sessions'

# ------------------------------------------------------
# git (copied from zsh)
# ------------------------------------------------------
alias g='git'
alias ga='git add'
alias gaa='git add --all'
alias gapa='git add --patch'
alias gau='git add --update'
alias gap='git apply'
alias gb='git branch'
alias gba='git branch -a'
alias gbd='git branch -d'
alias gbda='git branch --no-color --merged | command grep -vE "^(\*|\s*(master|develop|dev)\s*$)" | command xargs -n 1 git branch -d'
alias gbl='git blame -b -w'
alias gbnm='git branch --no-merged'
alias gbr='git branch --remote'
alias gbs='git bisect'
alias gbsb='git bisect bad'
alias gbsg='git bisect good'
alias gbsr='git bisect reset'
alias gbss='git bisect start'
alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gcn!='git commit -v --no-edit --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gcan!='git commit -v -a --no-edit --amend'
alias gcans!='git commit -v -a -s --no-edit --amend'
alias gcam='git commit -a -m'
alias gcsm='git commit -s -m'
alias gcb='git checkout -b'
alias gcf='git config --list'
alias gcl='git clone --recursive'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
alias gcm='git checkout master'
alias gcd='git checkout develop'
alias gcmsg='git commit -m'
alias gco='git checkout'
alias gcount='git shortlog -sn'
alias gcp='git cherry-pick'
alias gcpa='git cherry-pick --abort'
alias gcpc='git cherry-pick --continue'
alias gcs='git commit -S'
alias gd='git diff'
alias gdca='git diff --cached'
alias gdcw='git diff --cached --word-diff'
alias gdct='git describe --tags `git rev-list --tags --max-count=1`'
alias gdt='git diff-tree --no-commit-id --name-only -r'
alias gdw='git diff --word-diff'
alias gf='git fetch'
alias gfa='git fetch --all --prune'
alias gfo='git fetch origin'
alias gg='git gui citool'
alias gga='git gui citool --amend'
alias ggpur='ggu'
alias ggpull='git pull origin $(git_current_branch)'
alias ggpush='git push origin $(git_current_branch)'
alias ggsup='git branch --set-upstream-to=origin/$(git_current_branch)'
alias gpsup='git push --set-upstream origin $(git_current_branch)'
alias ghh='git help'
alias gignore='git update-index --assume-unchanged'
alias gignored='git ls-files -v | grep "^[[:lower:]]"'
alias git-svn-dcommit-push='git svn dcommit && git push github master:svntrunk'
alias gk='\gitk --all --branches'
alias gke='\gitk --all $(git log -g --pretty=%h)'
alias gl='git pull'
alias glg='git log --stat'
alias glgp='git log --stat -p'
alias glgg='git log --graph'
alias glgga='git log --graph --decorate --all'
alias glgm='git log --graph --max-count=10'
alias glo='git log --oneline --decorate'
alias glol="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"
alias glola="git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --all"
alias glog='git log --oneline --decorate --graph'
alias gloga='git log --oneline --decorate --graph --all'
alias glp="_git_log_prettily"
alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'
alias gmtvim='git mergetool --no-prompt --tool=vimdiff'
alias gmum='git merge upstream/master'
alias gma='git merge --abort'
alias gp='git push'
alias gpd='git push --dry-run'
alias gpoat='git push origin --all && git push origin --tags'
alias gpu='git push upstream'
alias gpv='git push -v'
alias gr='git remote'
alias gra='git remote add'
alias grb='git rebase'
alias grba='git rebase --abort'
alias grbc='git rebase --continue'
alias grbi='git rebase -i'
alias grbm='git rebase master'
alias grbs='git rebase --skip'
alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'
alias grmv='git remote rename'
alias grrm='git remote remove'
alias grset='git remote set-url'
alias grt='cd $(git rev-parse --show-toplevel || echo ".")'
alias gru='git reset --'
alias grup='git remote update'
alias grv='git remote -v'
alias gsb='git status -sb'
alias gsd='git svn dcommit'
alias gsi='git submodule init'
alias gsps='git show --pretty=short --show-signature'
alias gsr='git svn rebase'
alias gss='git status -s'
alias gst='git status'
alias gsta='git stash save'
alias gstaa='git stash apply'
alias gstc='git stash clear'
alias gstd='git stash drop'
alias gstl='git stash list'
alias gstp='git stash pop'
alias gsts='git stash show --text'
alias gsu='git submodule update'
alias gts='git tag -s'
alias gtv='git tag | sort -V'
alias gunignore='git update-index --no-assume-unchanged'
alias gunwip='git log -n 1 | grep -q -c "\-\-wip\-\-" && git reset HEAD~1'
alias gup='git pull --rebase'
alias gupv='git pull --rebase -v'
alias glum='git pull upstream master'
alias gwch='git whatchanged -p --abbrev-commit --pretty=medium'
alias gwip='git add -A; git rm $(git ls-files --deleted) 2> /dev/null; git commit --no-verify -m "--wip-- [skip ci]"'

###############################################################################
### function
###############################################################################

# ------------------------------------------------------
# Proxies
# ------------------------------------------------------
function setproxy() {
    export {http,https,ftp,all}_proxy='http://proxy-src.research.ge.com:8080'
    export no_proxy='localhost,127.0.0.1,127.0.0.0/8,127.0.*.*,local.home,192.168.*.*,github.build.ge.com,github.sw.ge.com,openge.ge.com,devcloud.swcoe.ge.com'
}

function unsetproxy() {
    unset {http,https,ftp,all}_proxy
    unset no_proxy
}

# ------------------------------------------------------
# Update everything
# ------------------------------------------------------
function updateEverything() {
    (brew update && brew upgrade && brew cleanup && brew doctor)
}

# ------------------------------------------------------
# Git
# ------------------------------------------------------
function parse_git_branch() {
        BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
        if [ ! "${BRANCH}" == "" ]
        then
                STAT=`parse_git_dirty`
                echo "[${BRANCH}${STAT}]"
        else
                echo ""
        fi
}

function parse_git_dirty {
        status=`git status 2>&1 | tee`
        dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
        untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
        ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
        newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
        renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
        deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
        bits=''
        if [ "${renamed}" == "0" ]; then
                bits=">${bits}"
        fi
        if [ "${ahead}" == "0" ]; then
                bits="*${bits}"
        fi
        if [ "${newfile}" == "0" ]; then
                bits="+${bits}"
        fi
        if [ "${untracked}" == "0" ]; then
                bits="?${bits}"
        fi
        if [ "${deleted}" == "0" ]; then
                bits="x${bits}"
        fi
        if [ "${dirty}" == "0" ]; then
                bits="!${bits}"
        fi
        if [ ! "${bits}" == "" ]; then
                echo " ${bits}"
        else
                echo ""
        fi
}

###############################################################################
### source
###############################################################################

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

[ -f ~/.config/up/up.sh ] && source ~/.config/up/up.sh

###############################################################################
### =
###############################################################################

# ------------------------------------------------------
# fzf
# ------------------------------------------------------

export FZF_DEFAULT_COMMAND='ag -g ""'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# ------------------------------------------------------
# Bash history
# ------------------------------------------------------

# Record each line as it gets issued.
PROMPT_COMMAND='history -a'

# Expand history size.
HISTSIZE=1000
HISTFILESIZE=2000

# Avoid duplicate entries.
HISTCONTROL=erasedups:ignoreboth

# Don't record some commands.
export HISTIGNORE=$'[ \t]*:&:[fb]g:exit:clear:cd:jobs:tmux:l:la:ls:v:vi:vim:nvim'

# ------------------------------------------------------
# Editor
# ------------------------------------------------------
export EDITOR=nvim
export VISUAL=$EDITOR
export MANPAGER="nvim -c 'set ft=man' -"

# ------------------------------------------------------
# Misc.
# ------------------------------------------------------

# Automatically trim long paths in the prompt (requires Bash 4.x).
PROMPT_DIRTRIM=2

# TODO: Figure out the proper way to handle Node errors.
export NODE_TLS_REJECT_UNAUTHORIZED=0

# ------------------------------------------------------
# Prompt and title (PS1)
# ------------------------------------------------------

if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    color_prompt=yes
else
    color_prompt=
fi

if [ "$color_prompt" = yes ]; then
    PS1="\[\033[01;92m\]\u@\h\[\033[00m\] \[\033[01;33m\]\w\[\033[00m\] \`parse_git_branch\`\n\j $ "
else
    PS1="\u@\h \w\ \`parse_git_branch\`\n $ "
fi
unset color_prompt

###############################################################################
### Call some functions immediately
###############################################################################
setproxy

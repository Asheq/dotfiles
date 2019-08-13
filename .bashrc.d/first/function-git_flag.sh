function git_flag() {
  echo "  ${symbols_branch}$(__git_ps1)"
}

function git_branch_flag() {
  BRANCH=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
  if [ ! "${BRANCH}" == "" ]
  then
    echo "  ${symbols_branch} ${BRANCH}"
  else
    echo ""
  fi
}

function parse_git_dirty { # TODO: This is slow
  status=`git status 2>&1 | tee`
  dirty=`echo -n "${status}" 2> /dev/null | grep "modified:" &> /dev/null; echo "$?"`
  untracked=`echo -n "${status}" 2> /dev/null | grep "Untracked files" &> /dev/null; echo "$?"`
  ahead=`echo -n "${status}" 2> /dev/null | grep "Your branch is ahead of" &> /dev/null; echo "$?"`
  newfile=`echo -n "${status}" 2> /dev/null | grep "new file:" &> /dev/null; echo "$?"`
  renamed=`echo -n "${status}" 2> /dev/null | grep "renamed:" &> /dev/null; echo "$?"`
  deleted=`echo -n "${status}" 2> /dev/null | grep "deleted:" &> /dev/null; echo "$?"`
  bits=''
  if [ "${renamed}" == "0" ]; then
    bits="r${bits}"
  fi
  if [ "${ahead}" == "0" ]; then
    bits="a${bits}"
  fi
  if [ "${newfile}" == "0" ]; then
    bits="n${bits}"
  fi
  if [ "${untracked}" == "0" ]; then
    bits="u${bits}"
  fi
  if [ "${deleted}" == "0" ]; then
    bits="d${bits}"
  fi
  if [ "${dirty}" == "0" ]; then
    bits="m${bits}"
  fi
  if [ ! "${bits}" == "" ]; then
    echo " ${bits}"
  else
    echo ""
  fi
}

#  _               _
# | |__   __ _ ___| |__  _ __ ___
# | '_ \ / _` / __| '_ \| '__/ __|
# | |_) | (_| \__ \ | | | | | (__
# |_.__/ \__,_|___/_| |_|_|  \___|
#
# "The individual per-interactive-shell startup file"
#
# When bash is invoked as an interactive shell that is _not_ a login shell, it
# reads and executes commands from ~/.bashrc.

# ------------------------------------------------------------------------------
# Double-check that this bash is interactive before continuing
# ------------------------------------------------------------------------------
[[ "$-" != *i* ]] && return

# ------------------------------------------------------------------------------
# Show temporary prompt
# ------------------------------------------------------------------------------
echo -n '> '

# ------------------------------------------------------------------------------
# Source individual files
# ------------------------------------------------------------------------------
shopt -s globstar
bashrcd="${HOME}/.bashrc.d"
if [[ -d "${bashrcd}" ]] ; then
	for file in "${bashrcd}"/** ; do
		if [[ -f "${file}" ]] ; then
			source "${file}"
		fi
	done
	unset file
fi
unset bashrcd

# ------------------------------------------------------------------------------
# Finish
# ------------------------------------------------------------------------------
setproxy

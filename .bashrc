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
bashrcd="${HOME}/.bashrc.d"
if [[ -d "${bashrcd}" ]]; then
	# TODO: Deal with potential spaces in file names
	for file in $(find "${bashrcd}" -type f); do
		source "${file}"
	done
fi

# ------------------------------------------------------------------------------
# Finish
# ------------------------------------------------------------------------------
setproxy

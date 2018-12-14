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
function source_files_recursively() {
	local dir="$1"
	local file
	if [[ -d "${dir}" ]] ; then
		for file in "${dir}"/** ; do
			if [[ -f "${file}" ]] ; then
				source "${file}"
			fi
		done
	fi
}
source_files_recursively "${HOME}/.bashrc.d/first"
source_files_recursively "${HOME}/.bashrc.d/second"

# ------------------------------------------------------------------------------
# Finish
# ------------------------------------------------------------------------------
setproxy

# Prints git prompt symbols key
function gk() {
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

# Lists all git aliases
function ga() {
	git config --get-regexp alias
}

# Simple shell argument test.
#
# Prints each argument on a separate line, followed by the count of arguments.
# Useful for debugging.
function args() {
	local arg
	for arg in "$@"
	do
		echo "Argument: ${arg}"
	done
	echo "Count: $#"
}

# Simple terminal font test
function font_test() {
	echo -e "Normal"
	echo -e "\033[1mBold\033[22m"
	echo -e "\033[3mItalic\033[23m"
	echo -e "\033[3;1mBold Italic\033[0m"
	echo -e "\033[4mUnderline\033[24m"
	echo -e "\033[9mStrikethrough\033[29m"
	echo -e "\033[7mInverse\033[27m"
	echo -e "\033[2mDim\033[22m"
	echo -e "Ligatures: == === !== >= <= =>"
	echo -e "\033[31mRed\033[0m \033[32mGreen\033[0m \033[34mBlue\033[0m"
	echo -e "\033[41mBG Red\033[0m \033[42mBG Green\033[0m \033[44mBG Blue\033[0m"
	for i in {0..15}; do echo -en "\033[38;5;${i}m$i "; done; echo -e "\033[0m"
}

function nod() {
	if command -v node; then
		node
	else
		nvm use node
		node
	fi
}

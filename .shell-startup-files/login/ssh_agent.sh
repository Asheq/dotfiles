# Reuse existing ssh-agent if available, otherwise start a new one. NOTE: You
# still need to add keys to the agent using ssh-add.

export SSH_ENV=~/.ssh/agent_env

start_new_ssh_agent() {
	echo "Starting new ssh-agent..."
	eval "$(ssh-agent -s)" > /dev/null
	echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$SSH_ENV"
	echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$SSH_ENV"
	chmod 600 "$SSH_ENV"
}

# Load agent info if it exists, else start a new agent
if [ -f "$SSH_ENV" ]; then
	. "$SSH_ENV" > /dev/null
	# Check if agent is still running
	if ! kill -0 "$SSH_AGENT_PID" 2>/dev/null; then
		start_new_ssh_agent
	fi
else
	start_new_ssh_agent
fi

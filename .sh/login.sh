# NOTE: This file should be 100% POSIX-compliant

# Set other environment variables
# ==============================================================================

# For many programs
export EDITOR='nvim'
export VISUAL="$EDITOR"

# For man
export MANPAGER='nvim +Man!'

# For nvm
export NVM_DIR=~/.nvm

# Set PATH
# ==============================================================================

# Add user's private binaries
pathprepend ~/bin PATH
pathprepend ~/.local/bin PATH

# Add node binaries
pathprepend "$NVM_DIR"/versions/node/v24.11.1/bin PATH

# Add cargo binaries
pathprepend ~/.cargo/bin PATH

# Add python binaries
if command -v pyenv >/dev/null 2>&1; then
  eval "$(pyenv init --path)"
fi

# Add brew binaries
if command -v /opt/homebrew/bin/brew >/dev/null 2>&1; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Ensure current directory is not in PATH
pathremove . PATH
pathremove "" PATH

# Source login.private.sh
ssource ~/.sh/login.private.sh

# Reuse existing ssh-agent if available, otherwise start a new one.
# NOTE: You still need to add keys to the agent using ssh-add
# ==============================================================================
export SSH_ENV="$HOME/.ssh/agent_env"

function start_new_ssh_agent {
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
    if ! kill -0 $SSH_AGENT_PID 2>/dev/null; then
        start_new_ssh_agent
    fi
else
    start_new_ssh_agent
fi

#!/bin/sh

AGENT_ENV="$HOME/.ssh/agent_env"

ssh_agent_is_running() {
  [ -n "$SSH_AGENT_PID" ] && kill -0 "$SSH_AGENT_PID" 2>/dev/null
}

# Try to load existing agent environment ($SSH_AUTH_SOCK and $SSH_AGENT_PID)
if [ -f "$AGENT_ENV" ]; then
  . "$AGENT_ENV" > /dev/null
fi

# If agent is not running, start a new one
if ! ssh_agent_is_running; then
  echo "Starting new ssh-agent..."
  eval "$(ssh-agent -s)" > /dev/null

  # Save the new agent environment for future sessions
  echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$AGENT_ENV"
  echo "export SSH_AGENT_PID=$SSH_AGENT_PID" >> "$AGENT_ENV"
  chmod 600 "$AGENT_ENV"
fi

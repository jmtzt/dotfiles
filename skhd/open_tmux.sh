#!/usr/bin/env bash

# Detects if iTerm2 is running
if ! pgrep -f "iTerm" > /dev/null 2>&1; then
    # If iTerm is not running, open it with tmux
    open -a "/Applications/iTerm.app" --args tmux
else
    # Create a new window with tmux
    script='tell application "iTerm" to tell current session of current window to write text "tmux"'
    ! osascript -e "${script}" > /dev/null 2>&1 && {
        # If unable to create a new window, try to kill iTerm and restart with tmux
        while IFS="" read -r pid; do
            kill -15 "${pid}"
        done < <(pgrep -f "iTerm")
        # After killing iTerm, open it again with tmux command
        open -a "/Applications/iTerm.app" --args tmux
    }
fi


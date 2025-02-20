#!/bin/zsh

# Check if a tmux session exists
if tmux ls &> /dev/null; then
    # echo "Tmux session found. Attaching..."
    tmux attach
else
    # echo "No tmux session found. Starting a new session..."
    tmux
fi

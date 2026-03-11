#!/bin/bash

SESSION="sim_world"

# Check if session already exists
tmux has-session -t $SESSION 2>/dev/null

if [ $? != 0 ]; then
  # 1. Start a new session in detached mode (-d)
  tmux new-session -d -s $SESSION -n "multi_pane_window"

  # 2. Split the window horizontally (-h)
  tmux split-window -h -t $SESSION

  # 3. Split the right pane vertically (-v)
  tmux split-window -v -t $SESSION

  # # 4. Run commands in each pane
  # # Pane 0 (left)
  # tmux send-keys -t $SESSION:0.0 "gz sim shapes.sdf" C-m
  #
  # # Pane 1 (top right)
  # tmux send-keys -t $SESSION:0.1 "bash" C-m
  #
  # # Pane 2 (bottom right)
  # tmux send-keys -t $SESSION:0.2 "bash" C-m
fi

# 5. Attach to the session
tmux attach-session -t $SESSION

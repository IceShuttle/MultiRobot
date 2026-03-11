#!/bin/bash
USER_NAME=robot-sim

podman run --security-opt label=disable \
  --device=/dev/dri \
  -e XDG_RUNTIME_DIR=/tmp \
  -e DISPLAY \
  -e XAUTHORITY=$XAUTHORITY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -v ./environment:/environment \
  -v $HOME/.local/share/JetBrains/:/home/$USER_NAME/.local/share/JetBrains \
  -v $HOME/.config/JetBrains/:/home/$USER_NAME/.config/JetBrains \
  -v $HOME/.cache/JetBrains/:/home/$USER_NAME/.cache/JetBrains \
  -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
  -v $XDG_RUNTIME_DIR/$WAYLAND_DISPLAY:/tmp/$WAYLAND_DISPLAY:ro \
  --userns=keep-id \
  --net host \
  --rm \
  -it $IMG $CMD

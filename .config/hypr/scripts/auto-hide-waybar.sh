#!/bin/bash

SOCKET="$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock"
STATE_FILE="/tmp/waybar_visible"

# Show/hide helpers
show_waybar() {
    if [ ! -f "$STATE_FILE" ]; then
        killall -SIGUSR1 waybar
        touch "$STATE_FILE"
    fi
}

hide_waybar() {
    if [ -f "$STATE_FILE" ]; then
        killall -SIGUSR1 waybar
        rm "$STATE_FILE"
    fi
}

# Optimized window check with early exit
handle() {
    active_ws=$(hyprctl activeworkspace -j | jq '.id')

    hyprctl clients -j | jq -e --argjson ws "$active_ws" '
        .[] | select(.workspace.id == $ws)
    ' >/dev/null 2>&1

    if [ $? -eq 0 ]; then
        show_waybar  # No window found
    else
        hide_waybar  # Found a window in current workspace
    fi
}

# # Manual test usage
# check_windows_fast

socat - UNIX-CONNECT:"$SOCKET" | while read -r line; do
    # echo $line
   if [[ "$line" == "workspace>>"* || "$line" == "closewindow>>"* || "$line" == "activewindow>>"* ]]; then
        handle
    fi
done

#!/bin/bash

# Get battery level and status
# battery_level=$(cat /sys/class/power_supply/BAT*/capacity)
# status=$(cat /sys/class/power_supply/BAT*/status)

# # File to store last notification ID
# notify_id_file="/tmp/battery_notify_id"

# if [ "$status" = "Discharging" ] && [ "$battery_level" -le 40 ]; then
#     paplay /usr/share/sounds/freedesktop/stereo/message.oga &

#     # Read old notification ID if it exists
#     if [ -f "$notify_id_file" ]; then
#         notify_id=$(cat "$notify_id_file")
#     else
#         notify_id=0
#     fi

#     # Send the notification and capture the new ID
#     new_id=$(gdbus call --session \
#         --dest org.freedesktop.Notifications \
#         --object-path /org/freedesktop/Notifications \
#         --method org.freedesktop.Notifications.Notify \
#         "battery-watcher" "$notify_id" "" \
#         "Low Battery" "Battery is at ${battery_level}%" \
#         [] {} 3000 | awk '{print $2}' | tr -d ',')  # extract ID

#     echo "$new_id" > "$notify_id_file"
# fi

battery_level=$(cat /sys/class/power_supply/BAT*/capacity)
status=$(cat /sys/class/power_supply/BAT*/status)

# Only notify if battery is discharging and below threshold
if [ "$status" = "Discharging" ] && [ "$battery_level" -le 40 ]; then
    paplay /usr/share/sounds/freedesktop/stereo/message.oga &
    notify-send --expire-time=$((3*1000)) "Low Battery: ${battery_level}% remaining!"
fi

#!/bin/bash

# Ensure script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

#get latest camera script
cd /home/pi/uvc-gadget
git pull

NEW_CAM_SCRIPT_PATH="/home/pi/uvc-gadget/ov5467.sh"

# Check if the new startup script exists
if [ ! -f "$NEW_CAM_SCRIPT_PATH" ]; then
    echo "New startup script file not found at $NEW_CAM_SCRIPT_PATH" 1>&2
    exit 1
fi

# Copy the new startup script to home directory and make it executable
cp "$NEW_CAM_SCRIPT_PATH" /home/pi/.rpi-uvc-gadget.sh

reboot
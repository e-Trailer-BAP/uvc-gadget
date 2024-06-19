#!/bin/bash

# Ensure script is run as root
if [ "$(id -u)" != "0" ]; then
    echo "This script must be run as root" 1>&2
    exit 1
fi

# Update and upgrade the system
apt update && apt full-upgrade -y

# Install required packages
apt install -y git meson libcamera-dev libjpeg-dev

# Clone UVC gadget repository
cd /home/pi
git clone https://github.com/e-Trailer-BAP/uvc-gadget.git

# Define paths to the new config.txt and startup script
NEW_CONFIG_PATH="/home/pi/uvc-gadget/config.txt"
NEW_STARTUP_SCRIPT_PATH="/home/pi/uvc-gadget/ov5467.sh"

# Check if the new config file exists
if [ ! -f "$NEW_CONFIG_PATH" ]; then
    echo "New config.txt file not found at $NEW_CONFIG_PATH" 1>&2
    exit 1
fi

# Check if the new startup script exists
if [ ! -f "$NEW_STARTUP_SCRIPT_PATH" ]; then
    echo "New startup script file not found at $NEW_STARTUP_SCRIPT_PATH" 1>&2
    exit 1
fi

# Backup the existing config.txt
cp /boot/config.txt /boot/config.txt.bak

# Replace the existing config.txt with the new one
cp "$NEW_CONFIG_PATH" /boot/config.txt

# Build UVC gadget
cd /home/pi/uvc-gadget
make uvc-gadget
cd build
meson install
ldconfig

# Copy the new startup script to home directory and make it executable
cp "$NEW_STARTUP_SCRIPT_PATH" /home/pi/.rpi-uvc-gadget.sh
chmod +x /home/pi/.rpi-uvc-gadget.sh
chmod +x /home/pi/uvc-gadget/update_cam.sh


# Add the script to rc.local for execution at boot
sed -i '/exit 0/i /home/pi/.rpi-uvc-gadget.sh &' /etc/rc.local

# Final reboot to apply changes
reboot

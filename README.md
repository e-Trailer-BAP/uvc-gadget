
# uvcgadget - UVC Gadget C Library

The `uvcgadget` is a pure C library designed for handling UVC (USB Video Class) gadget functions on Raspberry Pi Zero 2 W devices. It facilitates the transformation of the Pi into a UVC-compatible device.

## How to use?


### Preparation

1. Download and install the [Raspberry Pi Imager](https://www.raspberrypi.com/software/).
2. Select 'Raspberry Pi Zero 2 W' as the target device.
3. Choose 'Raspberry Pi OS (Legacy) Lite: 64-bit Bullseye' as the operating system.
4. Select the correct MicroSD device and when prompted to adjust the settings, enable SSH and configure both network settings and the user account.
5. Flash the MicroSD card with the configured OS.

### Installation

1. SSH into your Pi using the previously configured settings:
   - You can use the terminal or command prompt with the command:
     ```
     ssh <user>@<host> -p <port> (default port is 22)
     ```
   - Alternatively, use an SSH client like [PuTTY](https://www.putty.org/).
2. After establishing an SSH connection, execute the following commands to install the `uvcgadget` library:
   ```bash
   sudo apt install -y git;
   sudo mkdir -p /home/pi;
   sudo cd /home/pi;
   sudo git clone https://github.com/e-Trailer-BAP/uvc-gadget.git;
   sudo chmod +x ./uvc-gadget/setup.sh;
   sudo ./uvc-gadget/setup.sh
   ```
  3. Once the installation completes, the device will reboot. Afterwards, connect a micro USB cable to the micro USB port labeled 'USB' on your Pi and connect the other end to your host device. The Pi will now function as a UVC device.

# To be Done

 - Implement Undistortion from [uvc-undistort](https://github.com/e-Trailer-BAP/uvc-undistort) before video is output.
- Implement first time calibration script to set intrinsic parameters

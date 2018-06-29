# Screen Setup

Lookup Device Drivers

    > sudo ubuntu-drivers devices

Install the found driver

    > sudo apt-get install nvidia-driver-390

Update nvidia settings.
Open the xdisplay and select "Force full Composition Pipeline" under the
advanced settings. (helps with vsync tearing). Once set, run 'save to xorg'
so the settings are persisted across reboot.

    > sudo nvidia-settings

Check the Arch Linux wiki for more config details
Update the mode line:

    > echo "options nvidia_390_drm modeset=1" > \
        /etc/modprobe.d/zz-nvidia-modeset.conf


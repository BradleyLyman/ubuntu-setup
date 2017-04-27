#!/bin/bash

echo " -> Modify System To Start In text Mode"
sudo systemctl set-default multi-user.target

echo " -> Uninstall ubuntu desktop environment"
sudo apt-get --purge remove ubuntu-desktop lightdm
sudo rm -rf /var/lightdm-data /var/lightdm

echo " -> Deleting old X-org crap"
sudo rm -r /etc/X11/*

echo " -> get xorg dependencies and other junk"
sudo apt-get install xserver-xorg xserver-xorg-core xinit

sudo chmod u+s /usr/lib/xorg/Xorg

echo " -> reconfigure xserver"
sudo dpkg-reconfigure xserver-xorg

echo " -> setup keyboard"
sudo dpkg-reconfigure keyboard-configuration

#!/bin/bash

echo " -> install xmonad"
sudo apt-get install xmonad ttf-dejavu

echo " -> create xmonad dir"
mkdir ~/.xmonad
echo " -> copy xmonad config"
cp ./xmonad/xmonad.hs ~/.xmonad/xmonad.hs

echo " -> recompile xmonad"
xmonad --recompile

echo " -> copy xinit"
cp ./xmonad/xinitrc ~/.xinitrc

echo " -> copy xresources"
cp ./XResources/xresources ~/.Xresources

echo " -> reload resources"
xrdb ~/.Xresources

echo " -> install urxvt"
sudo apt-get install rxvt-unicode-256color ttf-dejavu

./install_xresources.sh

echo " -> install rofi"
sudo apt-get install rofi

echo " -> install xcompmgr"
sudo apt-get install xcompmgr

echo " -> install feh"
sudo apt-get install feh

echo " -> copy background image"
cp ./background.jpg ~/.config/background.jpg

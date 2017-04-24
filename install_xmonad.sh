#!/bin/bash

echo "install xmonad"
sudo apt-get install xmonad ttf_dejavu

echo "create xmonad dir"
mkdir ~/.xmonad
echo "copy xmonad config"
cp ./xmonad/xmonad.hs ~/.xmonad/xmonad.hs

echo "recompile xmonad"
xmonad --recompile

echo "copy xinit"
cp ./xmonad/xinitrc ~/.xinitrc

echo "copy xresources"
cp ./XResources/xresources ~/.Xresources

echo "reload resources"
xrdb ~/.Xresources

echo "install urxvt"
sudo apt-get install rxvt-unicode-256color ttf-dejavu

echo "install resize-font extension"
git clone https://github.com/simmel/urxvt-resize-font

mkdir -p ~/.urxvt/ext
cp urxvt-resize-font/resize-font ~/.urxvt/ext

rm -rf urxvt-resize-font


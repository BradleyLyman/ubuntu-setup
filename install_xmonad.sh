#!/bin/bash

echo "install xmonad"
sudo apt-get install xmonad

echo "create xmonad dir"
mkdir ~/.xmonad
echo "copy xmonad config"
cp ./xmonad/xmonad.hs ~/.xmonad/xmonad.hs

xmonad --recompile

cp ./xmonad/xinitrc ~/.xinitrc

#!/bin/bash

echo "install resize-font extension"
git clone https://github.com/simmel/urxvt-resize-font

mkdir -p ~/.urxvt/ext
cp urxvt-resize-font/resize-font ~/.urxvt/ext

rm -rf urxvt-resize-font

cp ./XResources/xresources ~/.Xresources

read -p "enter monitor dpi: " dpi
echo "Xft.dpi: $dpi" >> ~/.Xresources

xrdb ~/.Xresources

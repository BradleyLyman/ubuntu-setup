#!/bin/bash

echo "install resize-font extension"
git clone https://github.com/simmel/urxvt-resize-font

mkdir -p ~/.urxvt/ext
cp urxvt-resize-font/resize-font ~/.urxvt/ext

rm -rf urxvt-resize-font


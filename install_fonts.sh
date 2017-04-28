#!/bin/bash

echo "  -> get powerline fonts"
git clone https://github.com/powerline/fonts

echo "  -> make fonts dir"
mkdir ~/.fonts

echo "  -> copy patched dejavu"
cp -r ./fonts/DejaVuSansMono ~/.fonts/

echo "  -> update font cache"
sudo fc-cache -vf

echo "  -> clean up font repo"
rm -rf ./fonts

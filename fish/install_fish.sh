#!/bin/bash

# Select root based on args
val=$@
if [ -n "${val}" ]
then
    RT=$val/fish
else
    RT="."
fi
echo " -> using root dir: $RT"

echo " -> install fish!"
sudo apt-get install fish

echo " -> update bashrc!"
cp $RT/bashrc ~/.bashrc

echo " -> make mybin if mising"
mkdir -p ~/.config/mybin

echo " -> make fish config dir if missing "
mkdir -p ~/.config/fish

echo " -> update fish config"
cp $RT/config.fish ~/.config/fish/config.fish


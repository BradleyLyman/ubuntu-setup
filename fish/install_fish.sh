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


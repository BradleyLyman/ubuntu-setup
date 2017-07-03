#!/bin/bash

echo " -> install chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install libappindicator1
sudo apt-get -f install
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo " -> install random bits and pieces"
sudo apt-get install htop cmake git

echo " -> install java"
sudo apt-get install openjdk-8-jdk

echo " -> install ctags"
sudo apt-get install exuberant-ctags

echo " -> install tmux"
sudo apt-get install tmux

echo " -> install inotify tools"
sudo apt-get install inotify-tools


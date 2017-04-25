#!/bin/bash

echo " -> install chrome"
#wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo apt-get install libappindicator1
sudo apt-get -f install
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb

echo " -> install random bits and pieces"
sudo apt-get install htop cmake git

echo " -> remove vim"
sudo apt-get remove --purge vim

echo " -> install neovim"
sudo apt-get install software-properties-common
sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt-get update
sudo apt-get install neovim
sudo apt-get install python-dev python-pip python3-dev python3-pip

sudo pip install --upgrade neovim
sudo pip3 install --upgrade neovim

sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60
sudo update-alternatives --config vi
sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60
sudo update-alternatives --config vim
sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60
sudo update-alternatives --config editor

echo " -> install vimrc"
mkdir -p ~/.config/nvim
cp -r ./nvim/* ~/.config/nvim/
ln -s ~/.config/nvim/init.vim
ln -s ~/.config/nvim ~/.vim

echo " -> install Vundle"
mkdir -p ~/.config/nvim/bundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

./fish/install_fish.sh `pwd`

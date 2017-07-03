#!/bin/bash

info() {
    # output message with blue text
    echo -e " ->\e[34m $1\e[39m"
}

info "Create mybin if missing"
mkdir ~/.config/mybin

info "install dot"
sudo apt-get install graphviz

info "copy files"
cp ./uml ~/.config/mybin/
cp ./notifier.sh ~/.config/mybin
cp ./plantuml.jar ~/.config/mybin
cp ./autouml ~/.config/mybin

info "done"



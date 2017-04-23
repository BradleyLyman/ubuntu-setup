#!/bin/bash

sudo apt-get install xmonad

cp -r ./xmonad/* ~/.xmonad

xmonad --recompile

#!/bin/bash

echo " -> download erlang solutions"
wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb

echo " -> install erlang solutions"
sudo dpkg -i erlang-solutions_1.0_all.deb

echo " -> update packages"
sudo apt-get update

echo " -> install erlang + otp platform"
sudo apt-get install esl-erlang

echo " -> install elixir"
sudo apt-get install elixir

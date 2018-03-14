#!/usr/bin/ruby

require_relative '../../ruby/brlyman/log.rb'

GIT_LINK="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

def install
    info "download vim-plug"
    system "curl #{GIT_LINK} -o plug.vim"

    info "move to destination"
    system "mkdir ~/.config/nvim/autoload"
    system "mv ./plug.vim ~/.config/nvim/autoload/plug.vim"
end

def uninstall
    info "delete plug.vim"
    system "rm ~/.config/nvim/autoload/plug.vim"
end

if ARGV.first == "-u"
    uninstall
else
    install
end


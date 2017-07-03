#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

if ARGV.first == "-u"
    info "remove fish config"
    system "rm -r ~/.config/fish/"

    info "uninstall fish"
    system "sudo apt-get remove --purge fish"
else
    info "install fish shell"
    system "sudo apt-get install fish"

    info "make fish config dir"
    system "mkdir -p ~/.config/fish"

    info "copy files"
    system "cp ./bashrc ~/.bashrc"
    system "cp ./config.fish ~/.config/fish/config.fish"
    system "cp -r ./functions ~/.config/fish/"
end

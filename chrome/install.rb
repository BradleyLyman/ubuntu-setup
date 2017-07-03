#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "install chrome"
    system "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
    system "sudo apt-get install libappindicator1"
    system "sudo apt-get -f install"
    system "sudo dpkg -i google-chrome-stable_current_amd64.deb"
    system "rm google-chrome-stable_current_amd64.deb"
end

def uninstall
    info "uninstall google chrome"
    system "sudo apt-get remove --purge google-chrome-stable"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

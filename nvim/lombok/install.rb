#!/usr/bin/ruby

require_relative '../../ruby/brlyman/log.rb'

INSTALL_DIR = "~/.config/mybin/lombok.jar"

def install
    info "install curl"
    system "sudo apt-get install curl"

    info "download lombok"
    system "curl https://projectlombok.org/downloads/lombok.jar > lombok.jar"

    info "move to mybin"
    system "mv ./lombok.jar #{INSTALL_DIR}"
end

def uninstall
    info "remove from mybin"
    system "rm #{INSTALL_DIR}"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "copy xresources"
    system "cp ./xresources ~/.Xresources"

    info "update xresources"
    system "xrdb ~/.Xresources"
end

def uninstall
    info "delete xresources"
    system "rm ~/.Xresources"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

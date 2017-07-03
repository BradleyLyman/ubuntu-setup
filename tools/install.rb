#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

$packages = "htop cmake git openjdk-8-jdk ctags tmux "\
            "exuberant-ctags inotify-tools"

def install
    info "install my tools"
    system "sudo apt-get install #{$packages}"
end

def uninstall
    info "remove my tools"
    system "sudo apt-get remove --purge #{$packages}"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

#!/usr/bin/ruby

require_relative '../../ruby/brlyman/log.rb'

def install
    info "install curl"
    system "sudo apt-get install curl"

    info "download lombok"
    system "curl https://projectlombok.org/downloads/lombok.jar > lombok.jar"

    info "install lombok"
    system "java -jar lombok.jar"

    info "delete files"
    system "rm lombok.jar"
end

def uninstall
    # nothing
end

if ARGV.first == "-u"
    uninstall
else
    install
end

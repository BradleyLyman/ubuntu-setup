#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info 'install ghc, and pandoc'
    system "sudo apt-get install ghc pandoc"
end

def uninstall
    info 'remove ghc'
    system "sudo apt-get remove --purge ghc pandoc"
end

if ARGV.first == "-u"
    uninstall
else
    install
end


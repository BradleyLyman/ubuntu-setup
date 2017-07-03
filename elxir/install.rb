#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "download erlang deb"
    system "wget https://packages.erlang-solutions.com/erlang-solutions_1.0_all.deb"

    info "install deb"
    system "sudo dpkg -i erlang-solutions_1.0_all.deb"

    info "clean up deb"
    system "rm ./erlang-solutions_1.0_all.deb"

    info "update packages"
    system "sudo apt-get update"

    info "install erlang/otp and elixir"
    system "sudo apt-get install esl-erlang elixir"
end

def uninstall
    info "uninstall elixir and erlang/otp"
    system "sudo apt-get remove --purge elixir esl-erlang"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

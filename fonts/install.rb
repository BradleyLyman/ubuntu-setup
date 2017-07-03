#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "get fonts"
    system "sudo apt-get install ttf-dejavu"
    system "git clone https://github.com/powerline/fonts"

    info "make font dir"
    system "mkdir -p ~/.fonts"

    info "copy patch dejavu"
    system "cp -r ./fonts/DejaVuSansMono ~/.fonts/"

    info "update font cache"
    system "sudo fc-cache -vf"

    info "remove temporary folder"
    system "rm -rf ./fonts"
end

def uninstall
    info "remove patched fonts"
    system "rm -rf ~/.fonts"

    info "remove installed fonts"
    system "sudo apt-get remove --purge ttf-dejavu"

    info "update cache"
    system "sudo fc-cache -vf"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "install dependencies"
    system "sudo apt-get install cmake pkg-config libfreetype6-dev"
    system "sudo apt-get install libfontconfig1-dev xclip"

    info "clone repo"
    system "git clone https://github.com/jwilm/alacritty"

    info "build cargo-deb"
    system "cd alacritty && cargo install cargo-deb"

    info "build alacritty package and install"
    system "cd alacritty && cargo deb --install"

    info "create configuration dir"
    system "mkdir -p ~/.config/alacritty"
end

def install_config
    info "copy configuration"
    system "cp ./alacritty.yml ~/.config/alacritty/alacritty.yml"
end

def uninstall
    info "uninstall alacritty"
    system "sudo apt-get remove alacritty --purge"
end

if ARGV.first == "-u"
    uninstall
elsif ARGV.first == "-c"
    install_config
else
    install
end

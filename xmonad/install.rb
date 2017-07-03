#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "install xmonad and friends"
    system "sudo apt-get install xmonad rofi xcompmgr feh xcape"

    info "copy xmonad configuration"
    system "mkdir -p ~/.xmonad"
    system "cp ./xmonad.hs ~/.xmonad/xmonad.hs"

    info "compile xmonad"
    system "xmonad --recompile"

    info "copy xinit"
    system "cp ./xinitrc ~/.xinitrc"

    info "copy keyboard initializer"
    system "cp ./set_custom_hypers.sh ~/.config/mybin/"

    info "copy background"
    system "cp ./background.jpg ~/.config/background.jpg"
end

def uninstall
    info "remove background"
    system "rm ~/.config/background.jpg"

    info "remove keyboard initializer"
    system "rm ~/.config/mybin/set_custom_hypers.sh"

    info "remove xinit"
    system "rm ~/.xinitrc"

    info "remove xmonad config"
    system "rm -r ~/.xmonad"

    info "uninstall xmonad and friends"
    system "sudo apt-get remove --purge xmonad rofi xcompmgr feh xcape"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

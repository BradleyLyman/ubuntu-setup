#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    log_block "resize_font_ext" do
        info "**BEGIN**"
        info "clone ext"
        system "git clone https://github.com/simmel/urxvt-resize-font"

        info "copy ext"
        system "mkdir -p ~/.urxvt/ext"
        system "cp urxvt-resize-font/resize-font ~/.urxvt/ext"

        info "remove temporary"
        system "rm -rf urxvt-resize-font"
        info "**DONE**"
    end

    info "copy xresources"
    system "cp ./xresources ~/.Xresources"

    info "update xresources"
    system "xrdb ~/.Xresources"
end

def uninstall
    info "remove urxvt extensions"
    system "rm -rf ~/.urxvt/ext"

    info "delete xresources"
    system "rm ~/.Xresources"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

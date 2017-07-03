#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
    info "install urxvt"
    system "sudo apt-get install rxvt-unicode-256color"

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
end

def uninstall
    info "remove urxvt extensions"
    system "rm -rf ~/.urxvt/ext"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

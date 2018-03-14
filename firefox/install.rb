#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

FIREFOX59 = "https://download-installer.cdn.mozilla.net/pub/firefox/releases/59.0/linux-x86_64/en-US/firefox-59.0.tar.bz2"
TAR = "firefox59.tar.bz2"
INSTALL_DIR = "~/.config/mybin/firefox.d"
BIN="~/.config/mybin/firefox"

def install
    info "remove firefox"
    system "sudo apt-get remove --purge firefox"

    info "install curl"
    system "sudo apt-get install curl"

    info "download firefox"
    system "curl #{FIREFOX59} -o #{TAR}"

    info "create install directory"
    system "mkdir -p #{INSTALL_DIR}"

    info "move tar"
    system "mv ./#{TAR} #{INSTALL_DIR}"

    info "extract"
    system "tar xvf #{INSTALL_DIR}/#{TAR} -C #{INSTALL_DIR}"

    info "symlink"
    system "ln -s #{INSTALL_DIR}/firefox/firefox #{BIN}"
end

def uninstall
    info "delete bin link"
    system "rm #{BIN}"

    info "delete install dir"
    system "rm -rf #{INSTALL_DIR}"
end

if ARGV.first == "-u"
    uninstall
else
    install
end

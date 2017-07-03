#!/usr/bin/ruby

require_relative './ruby/brlyman/log.rb'

info "install ruby-dev"
Process.wait Process.spawn "sudo apt-get -y install ruby-dev"

info "install rb-inotify"
Process.wait Process.spawn "sudo gem install rb-inotify"

info "install my ruby scripts"
Process.wait Process.spawn "mkdir -p ~/.config/mybin"
Process.wait Process.spawn "cp -r ./ruby/* ~/.config/mybin"

#!/usr/bin/ruby

require './log.rb'

info "install ruby-dev"
`sudo apt-get install ruby-dev`

info "install rb-inotify"
`sudo gem install rb-inotify`

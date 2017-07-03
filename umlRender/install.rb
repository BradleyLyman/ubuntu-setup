#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

if ARGV.first == "-u"
    log_block "remove uml" do
        system("rm ~/.config/mybin/uml")
        system("rm ~/.config/mybin/autouml")
        system("rm ~/.config/mybin/plantuml.jar")
    end
else
    log_block "install uml" do
        info "create mybin"
        system("mkdir -p ~/.config/mybin")

        info "install dot"
        system("sudo apt-get install graphviz")

        info "copy files"
        system("cp ./uml ~/.config/mybin")
        system("cp ./plantuml.jar ~/.config/mybin")
        system("cp ./autouml ~/.config/mybin")
    end
end

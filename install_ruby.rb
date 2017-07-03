#!/usr/bin/ruby

require_relative './ruby/brlyman/log.rb'

$default_logger = Logger.new "install_ruby"

$installrb = 'install.rb'
def each_subpackage
    Dir.glob("*/#{$installrb}").each do |package|
        log_block package do
            path = File.dirname(package)
            yield(path, package)
        end
    end
end

def install_subpackages
    info "install my other packages"
    each_subpackage do |path, package|
        info "execute '#{package}'"
        system "cd #{path}; ./#{$installrb}"
        info "done"
    end
end

def uninstall_subpackages
    info "uninstall my other packages"
    each_subpackage do |path, package|
        info "execute '#{package} -u'"
        system "cd #{path}; ./#{$installrb} -u"
        info "done"
    end
end

def install
    info "install ruby-dev"
    system "sudo apt-get -y install ruby-dev"

    info "install rb-inotify"
    system "sudo gem install rb-inotify"

    info "install my ruby scripts"
    system "mkdir -p ~/.config/mybin"
    system "cp -r ./ruby/* ~/.config/mybin"
end

if ARGV.first == "-u"
    uninstall_subpackages
else
    install
    install_subpackages
end

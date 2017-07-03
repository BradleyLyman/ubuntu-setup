#!/usr/bin/ruby

require_relative './ruby/brlyman/log.rb'

$default_logger = Logger.new "install_ruby"

def each_subpackage
    Dir.glob("*/install.rb").each do |package|
        info "---"
        info "---"
        path = File.dirname(package)
        log_block path do
            info "*- BEGIN -*"
            yield(path, package)
            info "*- DONE -*"
        end
    end
end

def invoke_subpackages
    info "install my other packages"
    each_subpackage do |path, package|
        Dir.chdir path do
            require_relative package
        end
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
    invoke_subpackages
else
    invoke_subpackages
end

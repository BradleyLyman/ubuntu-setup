#!/usr/bin/ruby

require_relative './ruby/brlyman/log.rb'

$default_logger = Logger.new "install"

def each_subpackage
    Dir.glob("**/install.rb").sort.reverse.each do |package|
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

if ARGV.first == "-u"
    invoke_subpackages
else
    info "make mybin"
    system "mkdir -p ~/.config/mybin"

    invoke_subpackages
end

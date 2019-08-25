#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install_config
    log_block "language server" do
        system "git clone https://github.com/sourcegraph/javascript-typescript-langserver"
        system "cd javascript-typescript-langserver && npm install"
        system "cd javascript-typescript-langserver && npm run build"
        system "sudo cp -r javascript-typescript-langserver/ /usr/lib/javascript-typescript-langserver/"
    end
end

def install
    info "install node"
    system "curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -"
    system "sudo apt-get install nodejs"

    install_config()
end

def uninstall
    system "sudo apt-get uninstall nodejs"
end

if ARGV.first == "-u"
    uninstall
elsif ARGV.first == "-c"
    install_config
else
    install
    install_config
end


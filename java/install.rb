#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install
  info "create jdt dir"
  system "mkdir jdt"

  if not File.exist? "./jdt-language-server.tar.gz"
    info "download lang server build"
    url = "http://download.eclipse.org/jdtls/milestones/0.9.0/jdt-language-server-0.9.0-201711302113.tar.gz"
    system "curl #{url} -o jdt-language-server.tar.gz"
  else
    info "lang server build already downloaded, skipping..."
  end

  info "copy tar into jdt dir"
  system "cp jdt-language-server.tar.gz jdt/"

  info "extract"
  system "cd jdt && tar xzvf ./jdt-language-server.tar.gz"

  info "copy run.sh"
  system "cp ./run_lang_server.sh jdt"

  info "download lombok"
  system "curl https://projectlombok.org/downloads/lombok.jar -o jdt/lombok.jar"

  install_config
end

def install_config
  info "make root dir"
  system "mkdir -p ~/.config/jdt"

  info "make workspace dir"
  system "mkdir ~/.config/jdt/workspace"

  info "copy to install location"
  system "cp -r jdt ~/.config/"
end

def uninstall
  info "delete server dir"
  system "sudo rm -rf ~/.config/jdt"
end

if ARGV.first == "-u"
    uninstall
elsif ARGV.first == "-c"
    install_config
else
    install
end

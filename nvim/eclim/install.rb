#!/usr/bin/ruby

require_relative '../../ruby/brlyman/log.rb'

def install
	log_block "eclipse" do
		info "download eclipse"
		system "curl http://mirror.csclub.uwaterloo.ca/eclipse/technology/epp/downloads/"\
			   "release/oxygen/R/eclipse-java-oxygen-R-linux-gtk-x86_64.tar.gz > eclipse.tar.gz"

		info "unpack eclipse"
		system "tar xvf eclipse.tar.gz"

		info "remove tar"
		system "rm eclipse.tar.gz"

		info "move folder to mybin"
		system "mv ./eclipse ~/.config/mybin/eclipse.d"
	end

	log_block "eclim" do
		info "download eclim"
		system "curl -L https://github.com/ervandew/eclim/releases/download/2.6.0/eclim_2.6.0.jar > eclim.jar"

        info "install eclim"
        system "java -Dvim.files=$HOME/.vim -Declipse.home=$HOME/.config/mybin/eclipse.d -jar eclim.jar install"

        info "clean up eclim"
        system "rm ./eclim.jar"
	end

    info "create symlink to eclim and eclipse binaries"
    system "ln -s ~/.config/mybin/eclipse.d/eclimd ~/.config/mybin/eclimd"
    system "ln -s ~/.config/mybin/eclipse.d/eclipse ~/.config/mybin/eclipse"
end

def uninstall
    info "delete ~/eclipse and config"
    system "rm -rf ~/.config/mybin/eclipse.d"
    system "rm -rf ~/.eclim"
    system "rm -rf ~/.eclipse"

    info "remove vim plugin"
    system "rm -r ~/.vim/eclim"
    system "rm  ~/.vim/plugin/eclim.vim"

    info "remove eclim symlink"
    system "rm ~/.config/mybin/eclimd"
    system "rm ~/.config/mybin/eclipse"

    info "remove eclipse workspace"
    system "rm ~/eclipse-workspace"
end

if ARGV.first == "-u"
    uninstall
else
    install
end


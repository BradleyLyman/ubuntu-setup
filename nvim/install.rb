#!/usr/bin/ruby

require_relative '../ruby/brlyman/log.rb'

def install_init_vim
    info "copy *.vim"
    system "cp ./*.vim ~/.config/nvim/"
end

def install
    info "remove vim"
    system "sudo apt-get remove --purge vim"

    info "symlink old .vim dir"
    system "mkdir -p ~/.config/nvim"
    system "ln -s ~/.config/nvim ~/.vim"

    log_block "install_neovim" do
        info "**START**"
        system "sudo apt-get install software-properties-common"
        system "sudo add-apt-repository ppa:neovim-ppa/stable"
        system "sudo apt-get update"
        system "sudo apt-get install neovim"
        system "sudo apt-get install python-dev python-pip python3-dev python3-pip"

        system "sudo pip install --upgrade neovim"
        system "sudo pip3 install --upgrade neovim"
        info "**DONE**"
    end

    log_block "update_alternatives" do
        info "**START**"
        system "sudo update-alternatives --install /usr/bin/vi vi /usr/bin/nvim 60"
        system "sudo update-alternatives --config vi"
        system "sudo update-alternatives --install /usr/bin/vim vim /usr/bin/nvim 60"
        system "sudo update-alternatives --config vim"
        system "sudo update-alternatives --install /usr/bin/editor editor /usr/bin/nvim 60"
        system "sudo update-alternatives --config editor"
        info "**DONE**"
    end

    log_block "supporting_tools" do
        info "install python-Levenshtein"
        system "pip3 install python-Levenshtein"
        system "pip install python-Levenshtein"
    end
end

def uninstall
    log_block "supporting_tools" do
        info "remove python-Leavenshtein"
        system "pip3 uninstall python-Levenshtein"
        system "pip uninstall python-Levenshtein"

        info "remove Vundle"
        system "rm -rf ~/.config/nvim/bundle"
    end

    log_block "remove nvim" do
        info "**START**"
        system "sudo pip uninstall neovim"
        system "sudo pip3 uninstall neovim"

        system "sudo apt-get remove neovim"
        system "sudo add-apt-repository --remove ppa:neovim-ppa/stable"
        system "sudo apt-get update"
        info "**DONE**"
    end

    log_block "update_alternatives" do
        info "**START**"
        system "sudo update-alternatives --config vi"
        system "sudo update-alternatives --config vim"
        system "sudo update-alternatives --config editor"
        info "**DONE**"
    end

    info "remove symlink to old .vim dir"
    system "rm .vim"

    info "remove init.vim"
    system "rm ~/.config/nvim/init.vim"
end

if ARGV.first == "-u"
    uninstall
elsif ARGV.first == "-c"
    install_init_vim
else
    install
    install_init_vim
end


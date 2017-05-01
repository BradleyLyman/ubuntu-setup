" --------------------- "
" --  Vundle Config  -- "
" --------------------- "
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'scrooloose/nerdtree'

    Plugin 'vim-airline/vim-airline'
    Plugin 'vim-airline/vim-airline-themes'

    Plugin 'vimwiki/vimwiki'

    Plugin 'epeli/slimux'
call vundle#end()
set nocompatible
syntax off
filetype plugin indent on

" --------------------------- "
" -- GENERAL CONFIGURATION -- "
" --------------------------- "
set mouse=v
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set shiftwidth=4
" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
set ruler
set shell=/bin/bash
set background=dark
let g:solarized_termtrans=1
colorscheme solarized
set numberwidth=2
set relativenumber

" -------------------- "
" --  Key Remapping -- "
" -------------------- "
let mapleader = ","
nmap <space> zz
noremap ; :

nnoremap <leader>w <C-w><C-w>

" mappings for eclim shortcuts
nnoremap <leader>i :JavaImport<CR>
nnoremap <leader>c :JavaCorrect<CR>

" mappings for tags
nnoremap <leader>f <C-]>
nnoremap <leader>t <C-t>

" mappings for file-explore
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>d : bdelete<CR>

" mappings for terminal mode
tnoremap <Esc> <C-\><C-n>

" -------------------- "
" -- Slimux Keymaps -- "
" -------------------- "

nnoremap <leader>s :SlimuxREPLSendLine<CR>
vnoremap <leader>s :SlimuxREPLSendSelection<CR>
nnoremap <leader>b :SlimuxREPLSendBuffer<CR>

" -------------------- "
" -- Airline Config -- "
" -------------------- "
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1

" ----------------------------------- "
" -- BEGIN JAVA PROJECT MANAGEMENT -- "
" ----------------------------------- "

let g:EclimCompletionMethod = 'omnifunc'

function CreateProject()
    let wd = system("pwd")[:-2]
    let project_name = system("projectName")[:-2]
    let cmd = "ProjectCreate " . wd . " -n java -p " . project_name
    exe cmd
endfunction

function DeleteProject()
    let project_name = system("projectName")[:-2]
    let cmd = "ProjectDelete " . project_name
    echo cmd
    exe cmd
endfunction



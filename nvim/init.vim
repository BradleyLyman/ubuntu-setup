set shell=/bin/bash

" --------------------- "
" --  Vundle Config  -- "
" --------------------- "
call plug#begin('~/.vim/plugged')
    Plug 'valloric/YouCompleteMe'
    Plug 'altercation/vim-colors-solarized'
    Plug 'scrooloose/nerdtree'
    Plug 'godlygeek/tabular'
    Plug 'rhysd/vim-clang-format'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'epeli/slimux'
    Plug 'slashmili/alchemist.vim'
    Plug 'elixir-editors/vim-elixir'
call plug#end()

" --------------------------- "
" -- GENERAL CONFIGURATION -- "
" --------------------------- "
filetype on
filetype plugin on
filetype indent off

set mouse=v
set clipboard+=unnamedplus
set expandtab
set tabstop=4
set shiftwidth=4
set autoindent
" remove trailing whitespace on save
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :retab
set ruler
set background=dark
colorscheme solarized
set colorcolumn=80
set autoread
set number
set relativenumber

hi ColorColumn ctermbg=11

" -------------------- "
" --  Key Remapping -- "
" -------------------- "
let mapleader = ","
nmap <space> zz
noremap ; :

nnoremap <leader>w <C-w>

" mappings for eclim shortcuts
nnoremap <leader>c :YcmCompleter FixIt<CR>
nnoremap <leader>doc :YcmCompleter GetDoc<CR>
nnoremap <leader>gt :YcmCompleter GoToDefinition<CR>

" mappings for tags
nnoremap <leader>f <C-]>
nnoremap <leader>t <C-t>

" mappings for file-explore
nnoremap <leader>n :bn<CR>
nnoremap <leader>d : bdelete<CR>

" mappings for marks
nnoremap <leader>m '

" mappings for terminal mode
tnoremap <Esc> <C-\><C-n>


" ---------------------- "
" -- tabular Mappings -- "
" ---------------------- "

nmap <Leader>a :Tabularize /:/<CR>
vmap <Leader>a :Tabularize /:/<CR>

" --------------------------- "
" -- NERDTreeConfiguration -- "
" --------------------------- "
nnoremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeWinSize=75


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


" ------------------------- "
" -- BEGIN YAML SETTINGS -- "
" ------------------------- "
augroup yamlgrpm
    autocmd!
    autocmd FileType yaml :set tabstop=2
    autocmd FileType yaml :set shiftwidth=2
    autocmd FileType yaml :set syntax=OFF
augroup END

" --------------------------- "
" -- BEGIN ELIXIR SETTINGS -- "
" --------------------------- "
augroup elixirgrp
    autocmd!
    autocmd FileType elixir :set tabstop=2
    autocmd FileType elixir :set shiftwidth=2
    autocmd FileType elixir :set syntax=OFF
    autocmd FileType elixir :set omnifunc
augroup END

" ---------------------------------- "
" -- BEGIN C++ PROJECT MANAGEMENT -- "
" ---------------------------------- "
let g:clang_format#detect_style_file = 1
let g:ycm_global_ycm_extra_conf = '/home/brlyman/.config/nvim/ycm_extra_conf.py'
augroup cpp
    autocmd!
    autocmd FileType c,cpp :set syntax=OFF
    autocmd FileType c,cpp :set tabstop=4
    autocmd FileType c,cpp :set shiftwidth=4
    autocmd FileType c,cpp ClangFormatAutoEnable
augroup END


" --------------------------------- "
" -- BEGIN RUST PROJECT SETTINGS -- "
" --------------------------------- "
let g:ycm_rust_src_path = '~/.cargo/rust/src'

augroup rustgrp
    autocmd!
    autocmd FileType rust :set syntax=OFF
    autocmd FileType rust vmap <Leader>f :'<,'>!rustfmt<CR>
augroup END


" ----------------------------------- "
" -- BEGIN JAVA PROJECT MANAGEMENT -- "
" ----------------------------------- "

augroup javagrp
    autocmd!
    autocmd FileType java :set syntax=OFF
    autocmd FileType java :iabbrev cc Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
    autocmd FileType java :iabbrev pc public class
    autocmd FileType java :iabbrev pv public void
    autocmd FileType java :iabbrev isat import static org.hamcrest.MatcherAssert.assertThat;
    autocmd FileType java :iabbrev ism import static org.hamcrest.Matchers
    autocmd FileType java :iabbrev hcr @RunWith(HierarchicalContextRunner.class)
augroup END

let home = system("echo ~")[:-2]
let lombok_path = home . "/.config/mybin/lombok.jar"
let java_agent = "-javaagent:" . lombok_path
let boot_cp = "-Xbootclasspath/p:" . lombok_path

let $JAVA_TOOL_OPTIONS = java_agent . " " . boot_cp

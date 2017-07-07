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

    Plugin 'epeli/slimux'
call vundle#end()
set nocompatible
filetype plugin indent on
syntax on

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
nnoremap <leader>n :bn<CR>
nnoremap <leader>d : bdelete<CR>

" mappings for terminal mode
tnoremap <Esc> <C-\><C-n>


" --------------------------- "
" -- NERDTreeConfiguration -- "
" --------------------------- "
nnoremap <leader>e :NERDTreeToggle<CR>
let g:NERDTreeWinSize=80


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


" ---------------------------------- "
" -- BEGIN C++ PROJECT MANAGEMENT -- "
" ---------------------------------- "
let g:ycm_global_ycm_extra_conf = '/home/brlyman/.config/nvim/ycm_extra_conf.py'


" ----------------------------------- "
" -- BEGIN JAVA PROJECT MANAGEMENT -- "
" ----------------------------------- "

augroup javagrp
    autocmd!
    autocmd FileType java :set syntax=OFF
    autocmd FileType java :iabbrev cc Copyright 2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
    autocmd FileType java :iabbrev pc public class
    autocmd FileType java :iabbrev pv public void
    autocmd FileType java :iabbrev hcr @RunWith(HierarchicalContextRunner.class)
augroup END

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



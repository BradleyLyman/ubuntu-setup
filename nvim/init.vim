set shell=/bin/bash

" --------------------- "
" --  Vundle Config  -- "
" --------------------- "
call plug#begin('~/.vim/plugged')
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'

    Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

    Plug 'altercation/vim-colors-solarized'
    Plug 'scrooloose/nerdtree'
    Plug 'godlygeek/tabular'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'epeli/slimux'
    Plug 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh',
        \ }
call plug#end()

let g:deoplete#enable_at_startup = 1

" --------------------------- "
" -- GENERAL CONFIGURATION -- "
" --------------------------- "
filetype on
filetype plugin on
filetype indent off

set hidden
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

hi ColorColumn ctermbg=black
hi LineNr ctermbg=black

" ---------------------- "
" -- Language Servers -- "
" ---------------------- "
let g:LanguageClient_serverCommands = {
    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
    \ 'ruby': ['solargraph', 'stdio'],
    \ 'sh': ['bash-language-server', 'start'],
    \ 'javascript': [
    \   'node',
    \   '/usr/lib/javascript-typescript-langserver/lib/language-server-stdio.js'
    \  ],
    \ 'java': ['~/.config/jdt/run_lang_server.sh']
    \ }

" -------------------- "
" --  Key Remapping -- "
" -------------------- "
let mapleader = ","
nmap <space> zz
noremap ; :

nnoremap <leader>w <C-w>

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

" DEOPLETE/LanguageClient Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
nnoremap <leader>c :call LanguageClient_contextMenu()<CR>
" Or map each action separately
nnoremap <leader>h :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>rn :call LanguageClient#textDocument_rename()<CR>


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
" -- BEGIN SH SETTINGS -- "
" ------------------------- "
augroup shgrp
    autocmd!
    autocmd FileType sh :set tabstop=2
    autocmd FileType sh :set shiftwidth=2
    autocmd FileType sh :set syntax=OFF
augroup END

" ------------------------- "
" -- BEGIN RUBY SETTINGS -- "
" ------------------------- "
augroup rubygrp
    autocmd!
    autocmd FileType ruby :set tabstop=2
    autocmd FileType ruby :set shiftwidth=2
    autocmd FileType ruby :set syntax=OFF
augroup END

" ------------------------- "
" -- BEGIN TS SETTINGS -- "
" ------------------------- "
augroup tsgrp
    autocmd!
    autocmd FileType typescript :set tabstop=2
    autocmd FileType typescript :set shiftwidth=2
    autocmd FileType typescript :set syntax=OFF
augroup END

" ------------------------- "
" -- BEGIN JS SETTINGS -- "
" ------------------------- "
augroup jsgrp
    autocmd!
    autocmd FileType javascript :set tabstop=2
    autocmd FileType javascript :set shiftwidth=2
    autocmd FileType javascript :set syntax=OFF
    autocmd FileType javascript :iabbrev cc /** Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved. */
    autocmd FileType javascript :iabbrev us "use strict";
augroup END

" ------------------------- "
" -- BEGIN JSON SETTINGS -- "
" ------------------------- "
augroup jsongrp
    autocmd!
    autocmd FileType json :set tabstop=2
    autocmd FileType json :set shiftwidth=2
    autocmd FileType json :set syntax=OFF
augroup END

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

" ------------------------------- "
" -- BEGIN POWERSHELL SETTINGS -- "
" ------------------------------- "
augroup pwshgrp
    autocmd!
    autocmd FileType powershell :set tabstop=2
    autocmd FileType powershell :set shiftwidth=2
    autocmd FileType powershell :set syntax=OFF
augroup END

" ----------------------------- "
" -- BEGIN XML/HTML SETTINGS -- "
" ----------------------------- "
augroup xmlhtml
    autocmd!
    autocmd FileType ant,xml,html :set tabstop=2
    autocmd FileType ant,xml,html :set shiftwidth=2
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
augroup rustgrp
    autocmd!
    autocmd FileType rust :set syntax=OFF
    autocmd FileType rust vmap <Leader>f :'<,'>!rustfmt<CR>
augroup END

" ------------------------------------- "
" -- BEGIN MAKEFILE PROJECT SETTINGS -- "
" ------------------------------------- "
augroup makefilegrp
    autocmd!
    autocmd FileType make :set noexpandtab
    autocmd FileType make :set tabstop=8
    autocmd FileType make :set shiftwidth=8
augroup END

" ----------------------------------- "
" -- BEGIN JAVA PROJECT MANAGEMENT -- "
" ----------------------------------- "
augroup javagrp
    autocmd!
    autocmd FileType java :set syntax=OFF
    autocmd FileType java :iabbrev cc Copyright 2019 Amazon.com, Inc. or its affiliates. All Rights Reserved.
    autocmd FileType java :iabbrev pc public class
    autocmd FileType java :iabbrev pv public void
    autocmd FileType java :iabbrev isat import static org.hamcrest.MatcherAssert.assertThat;
    autocmd FileType java :iabbrev ism import static org.hamcrest.Matchers
    autocmd FileType java :iabbrev hcr @RunWith(HierarchicalContextRunner.class)
augroup END

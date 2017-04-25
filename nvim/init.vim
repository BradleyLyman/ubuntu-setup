" --------------------- "
" --  Vundle Config  -- "
" --------------------- "
set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin()
    Plugin 'VundleVim/Vundle.vim'
    Plugin 'Valloric/YouCompleteMe'
    Plugin 'altercation/vim-colors-solarized'
    Plugin 'scrooloose/nerdtree'
call vundle#end()
syntax off
filetype plugin on

" --------------------------- "
" -- GENERAL CONFIGURATION -- "
" --------------------------- "
filetype off
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
colorscheme solarized

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
nnoremap <leader>b :buffers<CR>
nnoremap <leader>n :bn<CR>
nnoremap <leader>d : bdelete<CR>

" mappings for terminal mode
tnoremap <Esc> <C-\><C-n>

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



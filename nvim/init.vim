" set shell=pwsh.exe

call plug#begin("~/AppData/Local/nvim/plugged")
  Plug 'preservim/nerdtree'
  Plug 'altercation/vim-colors-solarized'
  Plug 'godlygeek/tabular'

  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'JuliaEditorSupport/julia-vim'
call plug#end()

filetype on
filetype plugin on
filetype indent off

set encoding=utf-8
scriptencoding utf-8
set hidden
set mouse=v
set clipboard+=unnamedplus
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
autocmd BufWritePre * :%s/\s\+$//e
autocmd BufWritePre * :retab
set ruler
set background=dark
set colorcolumn=80
set autoread
set number
set relativenumber
syntax enable
set signcolumn=number


set t_Co=16
let g:solarized_termcolors=16
colorscheme solarized

hi LineNr ctermbg=None
hi ColorColumn ctermbg=Black

let g:latex_to_unicode_tab = 0
let g:latex_to_unicode_auto = 0

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

" ------------------
" -- Key Mappings --
" ------------------

let mapleader = ","
nmap <space> zz
noremap ; :

" buffer controls
nnoremap <leader>w <C-w>

" file controls
nnoremap <leader>n :bn<CR>
nnoremap <leader>p :bp<CR>
nnoremap <leader>d :bdelete<CR>

" terminal escape
tnoremap <Esc> <C-\><C-n>

nnoremap <leader>e :NERDTreeToggle<CR>


" --------------------- "
" -- Nerdtree Config -- "
" --------------------- "

let g:NERDTreeWinSize=75
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" --------------
" -- augroups --
" --------------

augroup gitcommit
    autocmd!
    autocmd FileType gitcommit :set colorcolumn=72
augroup end

augroup julia
  autocmd!
  autocmd FileType julia :set syntax=OFF
  autocmd FileType julia :set tabstop=4
  autocmd FileType julia :set shiftwidth=4
augroup end

augroup rust
  autocmd!
  autocmd FileType rust :set syntax=OFF
  autocmd FileType rust :set tabstop=4
  autocmd FileType rust :set shiftwidth=4
augroup end

" ----------------
" -- COC CONFIG --
" ----------------

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

nnoremap <leader>gh :call <SID>show_documentation()<CR>
nnoremap <silent> K :call <SID>show_documentation()<CR>
nmap <leader>f  <Plug>(coc-fix-current)
nmap <leader>rn <Plug>(coc-rename)

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


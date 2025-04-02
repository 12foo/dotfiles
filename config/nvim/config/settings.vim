set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set completeopt=menu,menuone,longest,preview
set pumheight=30
set grepprg=grep\ -nH\ $*
set linebreak
set number
set conceallevel=2
set encoding=utf-8

nnoremap <Space> <Nop>
let maplocalleader="\<Space>"
let mapleader="\<Space>"
nnoremap <esc> :noh<return><esc>

filetype off

" bufeurs
set hidden
nnoremap <C-PageDown> :bn<CR>
nnoremap <C-PageUp> :bp<CR>
inoremap <C-PageDown> <Esc>:bn<CR>
inoremap <C-PageUp> <Esc>:bp<CR>
tnoremap <Esc> <C-\><C-n>

" highlight current line
set cursorline
hi cursorline guibg=#333333
hi CursorColumn guibg=#333333

" crap files
silent execute '!mkdir -p /tmp/vim-philipp'
set backup
set swapfile
set backupdir=/tmp/vim-philipp//
set directory=/tmp/vim-philipp//

" set hlsearch
set incsearch
set ignorecase
set smartcase

" faster esc
set timeoutlen=1000
set ttimeoutlen=50
" set noesckeys " (gone now?)

" ALWAYS HARDCORE
" noremap <Up> <nop>
" noremap <Down> <nop>
" noremap <Left> <nop>
" noremap <Right> <nop>
inoremap jj <Esc>

filetype plugin indent on
syntax on
set wildignore+=.*

set background=dark
let g:airline_theme = 'distinguished'


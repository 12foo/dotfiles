set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set completeopt=menuone,longest
set grepprg=grep\ -nH\ $*
set linebreak
let maplocalleader=","
set number
set pastetoggle=<F2>

let mapleader=","

filetype off

" bufeurs
set hidden
nnoremap <C-PageDown> :bn<CR>
nnoremap <C-PageUp> :bp<CR>
inoremap <C-PageDown> <Esc>:bn<CR>
inoremap <C-PageUp> <Esc>:bp<CR>

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
set noesckeys

filetype plugin indent on
syntax on
set wildignore+=.*

set background=dark
let g:jellybeans_term_italics = 1
colorscheme jellybeans
" set transparency AFTER airline has loaded or the colors get messed up
" (airline uses theme's colors to generate its own)
autocmd User AirlineAfterInit highlight Normal ctermbg=none
autocmd User AirlineAfterInit highlight NonText ctermbg=none


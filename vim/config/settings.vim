set tabstop=4
set shiftwidth=4
set expandtab
set autoindent
set backspace=indent,eol,start
set completeopt=menu
set grepprg=grep\ -nH\ $*
set linebreak
set t_Co=256
let maplocalleader=","
set number
set nobackup
set noswapfile
set pastetoggle=<F2>

let mapleader=","

filetype off

" bufeurs
set hidden
noremap <C-PageDown> :bn<CR>
noremap <C-PageUp> :bp<CR>

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
set ttimeoutlen=10
set noesckeys

" colorscheme etc
filetype plugin indent on
syntax on
set wildignore+=.*
set background=dark
colorscheme jellybeans


" repeatable mappings
Plug 'tpope/vim-repeat'

" zen coding
Plug 'mattn/emmet-vim', { 'for': 'html' }

" Powerline
set laststatus=2
set showtabline=2
set noshowmode

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" fugitive (git wrapper)
Plug 'tpope/vim-fugitive'

" syntastic (syntax checker)
Plug 'scrooloose/syntastic'

" indent guides
Plug 'nathanaelkane/vim-indent-guides', { 'for': 'clojure' }

" clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'vim-scripts/vim-niji', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }

" livescript
Plug 'gkz/vim-ls', { 'for': 'livescript' }

" go
Plug 'fatih/vim-go', { 'for': 'golang' }

" ctrlp
Plug 'kien/ctrlp.vim'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target'

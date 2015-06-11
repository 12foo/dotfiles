" tim pope: cool guy 
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

" zen coding
Plug 'mattn/emmet-vim', { 'for': 'html' }

" buffergator (<leader>b)
Plug 'jeetsukumaran/vim-buffergator'

" Powerline
set laststatus=2
set showtabline=2
set noshowmode

Plug 'bling/vim-airline'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'

" syntastic (syntax checker)
Plug 'scrooloose/syntastic'
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" indent guides
Plug 'nathanaelkane/vim-indent-guides', { 'for': 'clojure' }

" clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'venantius/vim-cljfmt', { 'for': 'clojure' }
Plug 'jebberjeb/grimoire.vim', { 'for': 'clojure' }
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" livescript
Plug 'gkz/vim-ls', { 'for': 'livescript' }

" go
Plug 'fatih/vim-go', { 'for': 'go' }

" less
Plug 'groenewege/vim-less'

" ctrlp
Plug 'kien/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" completion
Plug 'Valloric/YouCompleteMe'

" supertab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "\<c-x>\<c-o>"


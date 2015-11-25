" tim pope: cool guy 
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

" vim wiki
Plug 'vimwiki/vimwiki'
let g:vimwiki_list = [{'path': '~/ownCloud/research/wiki/', 'syntax': 'markdown', 'ext': '.md'}]

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
" let g:syntastic_mode_map = { 'passive_filetypes': ['go'] }
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" indent guides
Plug 'nathanaelkane/vim-indent-guides'

" pandoc & markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ['folding', 'spell']
au FileType pandoc nmap <Leader><Leader> :TOC<Enter>

" alignment
Plug 'godlygeek/tabular'

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

" vim-slime
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"

" livescript
Plug 'gkz/vim-ls', { 'for': 'ls' }
au BufNewFile,BufReadPost *.ls setl shiftwidth=2 expandtab

" coffeescript
Plug 'kchmck/vim-coffee-script', { 'for': 'coffee' }

" tagbar
Plug 'majutsushi/tagbar', { 'for': [ 'go', 'rust' ] }
au FileType go nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>

" rust
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'racer-rust/vim-racer', { 'for': 'rust' }
let g:racer_cmd = "/home/philipp/build/racer/target/release/racer"
let g:racer_experimental_completer = 1
let $RUST_SRC_PATH="/home/philipp/build/rust/src/"

" julia
Plug 'JuliaLang/julia-vim'

" go
Plug 'fatih/vim-go', { 'for': 'go' }
let g:go_fmt_fail_silently = 0
au FileType go nmap <Leader>D <Plug>(go-doc)
au FileType go nmap <Leader>d <Plug>(go-info)
au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1

" less
Plug 'groenewege/vim-less'

" ctrlp
Plug 'kien/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

" supertab
Plug 'ervandew/supertab'
let g:SuperTabDefaultCompletionType = "\<c-x>\<c-o>"


" remote plugins
Plug 'neovim/node-host', { 'do': 'npm install' }

" tim pope: cool guy 
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" zen coding
Plug 'mattn/emmet-vim', { 'for': 'html' }

" tabularize
Plug 'godlygeek/tabular'

" supertab
" Plug 'ervandew/supertab'
" let g:SuperTabDefaultCompletionType = "context"

" Powerline
set laststatus=2
set showtabline=2
set noshowmode

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
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

" autocompletion
Plug 'roxma/nvim-completion-manager'

" language clients
Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'nightly', 'rls']
    \ }
let g:LanguageClient_autoStart = 1
nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

" pandoc & markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ['folding', 'spell']
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#completion#bib#mode = 'citeproc'
au FileType pandoc nmap <Leader><Leader> :TOC<Enter>
au FileType pandoc let b:SuperTabContextTextMemberPatterns = ['@']

" alignment
Plug 'godlygeek/tabular'

" clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'luochen1990/rainbow', { 'for': 'clojure' }
Plug 'clojure-vim/async-clj-omni'
Plug 'clojure-vim/nvim-parinfer.js'
let g:rainbow_active = 1

" elixir
Plug 'elixir-lang/vim-elixir'

" stylus stylesheets
Plug 'wavded/vim-stylus'

" tagbar
Plug 'majutsushi/tagbar', { 'for': [ 'go', 'rust', 'cpp' ] }
au FileType go nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>
au FileType cpp nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>

" rust
Plug 'rust-lang/rust.vim'
let g:rustfmt_autosave = 1

" haskell
Plug 'eagletmt/neco-ghc'
Plug 'parsonsmatt/intero-neovim'
let g:haskell_tabular = 1
vmap a= :Tabularize /=<CR>
vmap a; :Tabularize /::<CR>
vmap a- :Tabularize /-><CR>
nnoremap <Leader>hio :InteroOpen<CR>
nnoremap <Leader>hik :InteroKill<CR>
nnoremap <Leader>hic :InteroHide<CR>
nnoremap <Leader>hil :InteroLoadCurrentModule<CR>
nnoremap <Leader>hie :InteroEval<CR>
nnoremap <Leader>hit :InteroGenericType<CR>
nnoremap <Leader>hiT :InteroType<CR>
nnoremap <Leader>hii :InteroInfo<CR>
nnoremap <Leader>hiI :InteroTypeInsert<CR>
nnoremap <Leader>hid :InteroGoToDef<CR>
nnoremap <Leader>hiu :InteroUses<CR>

" Reload the file in Intero after saving
autocmd! BufWritePost *.hs InteroReload

" go
Plug 'fatih/vim-go'
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1
let g:go_highlight_operators = 1
let g:go_highlight_build_constraints = 1
let g:go_fmt_fail_silently = 0
au FileType go nmap <Leader>D <Plug>(go-doc)
au FileType go nmap <Leader>d <Plug>(go-info)
au FileType go nmap <Leader>dv <Plug>(go-doc-vertical)
au FileType go nmap <Leader>s <Plug>(go-implements)
au FileType go nmap <Leader>e <Plug>(go-rename)
" au FileType go setlocal omnifunc=go#complete#Complete

" less
Plug 'groenewege/vim-less'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


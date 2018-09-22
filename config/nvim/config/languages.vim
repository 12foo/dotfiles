Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1

" rust
Plug 'rust-lang/rust.vim'

" nim
Plug 'zah/nim.vim'

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

" clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'luochen1990/rainbow'
Plug 'clojure-vim/acid.nvim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --manifest-path=cparinfer/Cargo.toml --release'}
let g:rainbow_active = 1

" elixir
Plug 'elixir-lang/vim-elixir'

" web crap
Plug 'wavded/vim-stylus'
Plug 'groenewege/vim-less'
Plug 'mattn/emmet-vim', { 'for': 'html' }

" the great autocomplete fiesta
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }
let g:LanguageClient_serverCommands = {
    \ 'rust': ['rustup', 'run', 'stable', 'rls'],
    \ 'python': ['pyls'],
    \ }

nnoremap <F5> :call LanguageClient_contextMenu()<CR>

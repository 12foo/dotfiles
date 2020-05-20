" rust
Plug 'rust-lang/rust.vim'

" clojure
Plug 'guns/vim-clojure-static'
Plug 'guns/vim-clojure-highlight'
" Plug 'guns/vim-sexp', { 'for': 'clojure' }
" Plug 'tpope/vim-sexp-mappings-for-regular-people'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-salve'
Plug 'luochen1990/rainbow'
" Plug 'clojure-vim/acid.nvim'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --manifest-path=cparinfer/Cargo.toml --release'}
let g:rainbow_active = 1

" elixir
Plug 'elixir-lang/vim-elixir'

" web crap
Plug 'wavded/vim-stylus'
Plug 'groenewege/vim-less'
Plug 'pangloss/vim-javascript'
Plug 'evanleck/vim-svelte'
Plug 'mattn/emmet-vim'

" go
" autocmd BufWritePre *.go :call LanguageClient#textDocument_formatting_sync()


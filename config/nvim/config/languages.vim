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

" go bro
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')


" web crap
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'

Plug 'evanleck/vim-svelte'
autocmd FileType svelte setlocal shiftwidth=2 tabstop=2

Plug 'posva/vim-vue'


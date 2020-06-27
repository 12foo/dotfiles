" rust
Plug 'rust-lang/rust.vim'

" clojure & lisps
Plug 'Olical/conjure'
Plug 'bakpakin/janet.vim'
Plug 'luochen1990/rainbow'
Plug 'eraserhd/parinfer-rust', {'do': 'cargo build --release'}
let g:rainbow_active = 1

" elixir
Plug 'elixir-lang/vim-elixir'

" go bro
autocmd BufWritePre *.go :call CocAction('runCommand', 'editor.action.organizeImport')

" web crap
Plug 'cakebaker/scss-syntax.vim'
Plug 'pangloss/vim-javascript'
Plug 'mattn/emmet-vim'

Plug 'leafgarland/typescript-vim'

Plug 'evanleck/vim-svelte'
autocmd FileType svelte setlocal shiftwidth=2 tabstop=2

Plug 'posva/vim-vue'


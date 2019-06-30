" rust
Plug 'rust-lang/rust.vim'

" nim
Plug 'zah/nim.vim'

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
Plug 'burner/vim-svelte'
Plug 'mattn/emmet-vim', { 'for': 'html' }

" Language Client
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
imap <c-space> <Plug>(asyncomplete_force_refresh)
inoremap <expr> <CR> pumvisible() ? asyncomplete#close_popup() : "\<CR>"

if executable('rls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'rls',
        \ 'cmd': {server_info->['rustup', 'run', 'stable', 'rls']},
        \ 'workspace_config': {'rust': {'clippy_preference': 'on'}},
        \ 'whitelist': ['rust'],
        \ })
endif

if executable('/home/philipp/go/bin/gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['/home/philipp/go/bin/gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go silent LspDocumentFormatSync
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python']
        \ })
endif

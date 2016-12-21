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
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
let g:deoplete#enable_at_startup = 1
if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
" let g:deoplete#disable_auto_complete = 1
autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
" no autocomplete for mail
au FileType mail let b:deoplete_disable_auto_complete = 1


" pandoc & markdown
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'
let g:pandoc#modules#disabled = ['folding', 'spell']
let g:pandoc#biblio#use_bibtool = 1
let g:pandoc#completion#bib#mode = 'citeproc'
au FileType pandoc nmap <Leader><Leader> :TOC<Enter>
au FileType pandoc let b:SuperTabContextTextMemberPatterns = ['@']
au FileType pandoc let b:deoplete_disable_auto_complete = 1

" alignment
Plug 'godlygeek/tabular'

" clojure
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
Plug 'guns/vim-sexp', { 'for': 'clojure' }
Plug 'tpope/vim-sexp-mappings-for-regular-people', { 'for': 'clojure' }
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
Plug 'guns/vim-clojure-highlight', { 'for': 'clojure' }
Plug 'jebberjeb/grimoire.vim', { 'for': 'clojure' }
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1

" vim-slime
Plug 'jpalardy/vim-slime'
let g:slime_target = "tmux"

" elixir
Plug 'elixir-lang/vim-elixir'

" stylus stylesheets
Plug 'wavded/vim-stylus'

" tagbar
Plug 'majutsushi/tagbar', { 'for': [ 'go', 'rust', 'cpp' ] }
au FileType go nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>
au FileType cpp nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>

" python
Plug 'zchee/deoplete-jedi'

" javascript
Plug 'carlitux/deoplete-ternjs'

" rust
Plug 'rust-lang/rust.vim'
Plug 'sebastianmarkow/deoplete-rust'
let g:rustfmt_autosave = 1
let g:deoplete#sources#rust#racer_binary = "/home/philipp/.cargo/bin/racer"
let g:deoplete#sources#rust#rust_source_path = systemlist("rustc --print sysroot")[0] . "/lib/rustlib/src/rust/src"

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
Plug 'zchee/deoplete-go', { 'do': 'make' }
let g:deoplete#sources#go#gocode_binary = "~/coding/go/bin/gocode"

" clang completion
Plug 'Rip-Rip/clang_complete'
let g:syntastic_cpp_compiler = 'clang++'
let g:clang_complete_auto = 0
let g:clang_complete_copen = 1

" less
Plug 'groenewege/vim-less'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']


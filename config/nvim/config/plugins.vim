" remote plugins
" Plug 'neovim/node-host', { 'do': 'npm install' }

" float like a butterfly
Plug 'justinmk/vim-sneak'
Plug 'liuchengxu/vista.vim'
let g:vista_icon_indent = ["▸ ", ""]
map <F9> :Vista!!<CR>
map <F10> :Vista finder<CR>

" tim pope: cool guy 
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-unimpaired'

Plug 'justinmk/vim-dirvish'
let g:dirvish_mode = ':sort ,^.*[\/],'

" editorconfig
Plug 'editorconfig/editorconfig-vim'

" ctrlp
Plug 'ctrlpvim/ctrlp.vim'
if executable('rg')
    set grepprg=rg\ -H\ --no-heading\ --vimgrep
    set grepformat=%f:%l:%c:%m
    let g:ctrlp_user_command = 'rg %s --files --color never -g "!.git" -g "!node_modules"'
    let g:ctrlp_use_caching = 0
endif

" ripgrep integration
Plug 'jremmen/vim-ripgrep'
let g:rg_derive_root = 1
let g:rg_root_types = ['.git', '.fslckout']

" vimwiki
Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

" tabularize
Plug 'godlygeek/tabular'

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

" indent guides
Plug 'nathanaelkane/vim-indent-guides'

" tagbar
Plug 'majutsushi/tagbar', { 'for': [ 'go', 'rust', 'cpp' ] }
au FileType go nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>
au FileType cpp nmap <Leader><Leader> :TagbarOpenAutoClose<Enter>

" the greatest power
Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-compe'


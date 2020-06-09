" remote plugins
" Plug 'neovim/node-host', { 'do': 'npm install' }

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
let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']

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


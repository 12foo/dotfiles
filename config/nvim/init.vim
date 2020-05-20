set shell=/bin/bash
set nocompatible

set encoding=utf-8
set showcmd

runtime config/settings.vim

" PLUGINS START HERE
call plug#begin('~/.vim/plugged')
runtime config/plugins.vim
runtime config/languages.vim
runtime config/completion.vim
call plug#end()

runtime config/after_plug.vim
runtime config/aliases.vim

colorscheme apprentice
hi Normal guibg=NONE ctermbg=NONE

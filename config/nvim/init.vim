set shell=/bin/bash
set nocompatible

set encoding=utf-8
set showcmd

runtime config/settings.vim

" PLUGINS START HERE
call plug#begin('~/.vim/plugged')
runtime config/plugins.vim
call plug#end()

runtime config/aliases.vim

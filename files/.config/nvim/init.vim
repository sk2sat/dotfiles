set tabstop=4
set shiftwidth=4
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

set clipboard+=unnamedplus

set helplang=ja

tnoremap <silent> <ESC> <C-\><C-n>
set shell=fish

noremap : ;
noremap ; :

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/sksat/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/home/sksat/.cache/dein')
  call dein#begin('/home/sksat/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('/home/sksat/.cache/dein/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/deol.nvim', { 'rev': 'a1b5108fd' })

  call dein#add('qnighy/satysfi.vim')

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------


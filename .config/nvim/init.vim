"""""""""""""""""""""""""""""""""""""""
"  _ __   ___  _____   ___ _ __ ___   "
" | '_ \ / _ \/ _ \ \ / / | '_ ` _ \  "
" | | | |  __/ (_) \ V /| | | | | | | "
" |_| |_|\___|\___/ \_/ |_|_| |_| |_| "
"                                     "
" https://github.com/kelvins/dotfiles "
"                                     "
"""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""
" Plugins                             "
"""""""""""""""""""""""""""""""""""""""

" Plugin Manager (VimPlug)
call plug#begin('~/.config/nvim/plugins')

" File Explorer Tree
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Plugin Settings                     "
"""""""""""""""""""""""""""""""""""""""

lua require("nvim-tree-config")

"""""""""""""""""""""""""""""""""""""""
" Basic Settings                      "
"""""""""""""""""""""""""""""""""""""""

set number relativenumber

"""""""""""""""""""""""""""""""
" Commands                    "
"""""""""""""""""""""""""""""""

command WQ wq
command Wq wq
command W w
command Q q

" Format JSON
:command JSONFormatter %!python -m json.tool

"""""""""""""""""""""""""""""""""""""""
" Mappings                            "
"""""""""""""""""""""""""""""""""""""""

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" (CTRL-O) Open Nvim Tree
nnoremap <C-o> <ESC>:NvimTreeToggle<CR>

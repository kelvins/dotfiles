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

" Colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }

" File Explorer Tree
Plug 'kyazdani42/nvim-tree.lua'
Plug 'kyazdani42/nvim-web-devicons'

" Statusline
Plug 'nvim-lualine/lualine.nvim'

" Fuzzy Finder
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }

" Linter
Plug 'dense-analysis/ale'

" Commenting helper
Plug 'preservim/nerdcommenter'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Dashboard
Plug 'goolord/alpha-nvim'

" Resize windows
Plug 'roman/golden-ratio'

Plug 'scalameta/nvim-metals'

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Plugins Settings                    "
"""""""""""""""""""""""""""""""""""""""

lua require('nvim-tree-config')
lua require('lualine-config')
lua require('telescope-config')
lua require('alpha').setup(require('alpha.themes.startify').config)

"""""""""""""""""""""""""""""""""""""""
" Ale Settings                        "
"""""""""""""""""""""""""""""""""""""""

let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale#statusline#Count = 1

"""""""""""""""""""""""""""""""""""""""
" Nerd Commenter Settings             "
"""""""""""""""""""""""""""""""""""""""

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

"""""""""""""""""""""""""""""""""""""""
" Basic Settings                      "
"""""""""""""""""""""""""""""""""""""""

syntax enable

filetype plugin on

" Set the shell path
set shell=/bin/zsh

set number

" Colorscheme
set termguicolors
set background=dark
colorscheme dracula

" Spell Check
set spell spelllang=en_us
set spellfile=~/.config/nvim/spell/en.utf-8.add
hi clear SpellBad
hi SpellBad ctermbg=52

"""""""""""""""""""""""""""""""""""""""
" Commands                            "
"""""""""""""""""""""""""""""""""""""""

command WQ wq
command Wq wq
command W w
command Q q

" Format JSON
:command JSONFormatter %!python -m json.tool

" Automatically close Nvim Tree if it is the last window in the tab
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

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

" (CTRL-F) Find files using Telescope
nnoremap <C-f> <ESC>:Telescope find_files<CR>

"""""""""""""""""""""""""""""""
" Python Settings             "
"""""""""""""""""""""""""""""""

" Color Column
autocmd FileType python set colorcolumn=80

"""""""""""""""""""""""""""""""
" __   _____ __  __ ___  ___  "
" \ \ / /_ _|  \/  | _ \/ __| "
"  \ V / | || |\/| |   / (__  "
"   \_/ |___|_|  |_|_|_\\___| "
"                             "
" github.com/kelvins/dotfiles "
"                             "
"""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""
" Plugins                     "
"""""""""""""""""""""""""""""""

" VimPlug
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'dracula/vim', { 'as': 'dracula' }

" Status line
Plug 'itchyny/lightline.vim'

" Navigation
Plug 'preservim/nerdtree'

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" Linter
Plug 'w0rp/ale'

" Tests
Plug 'vim-test/vim-test'

" Golden-ratio
Plug 'roman/golden-ratio'

" NERD commenter
Plug 'preservim/nerdcommenter'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

" Clipboard copy and paste
Plug 'christoomey/vim-system-copy'

" Start screen
Plug 'mhinz/vim-startify'

" Fuzzy finder
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Rust
Plug 'rust-lang/rust.vim'

" Vim GPT
Plug 'kelvins/vim-gpt'

call plug#end()

"""""""""""""""""""""""""""""""
" Basic Settings              "
"""""""""""""""""""""""""""""""

" Set the shell path
set shell=/bin/zsh

" Set UTF-8 as standard encoding
set encoding=utf-8
set fileencoding=utf-8

" Fix backspace indent
set backspace=indent,eol,start

" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Linebreak on 500 characters
set lbr
set tw=500

" Searching
set hlsearch
set incsearch
set ic
set smartcase

set fileformats=unix,dos,mac
set belloff=all

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"""""""""""""""""""""""""""""""
" Visual Settings             "
"""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax on
syntax enable
set ruler
set number

" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

" Status bar
set laststatus=2

" Use modeline overrides
set modeline
set modelines=10

" Colorscheme
set t_Co=16
set background=dark
colorscheme dracula

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

" Spell Check
set spelllang=en
set spellfile=~/.vim/spell/en.utf-8.add
hi clear SpellBad
hi SpellBad ctermbg=52
set spell

"""""""""""""""""""""""""""""""
" Commands                    "
"""""""""""""""""""""""""""""""

command WQ wq
command Wq wq
command W w
command Q q

" Format JSON
:command JSONFormatter %!python -m json.tool

"""""""""""""""""""""""""""""""
" Mappings                    "
"""""""""""""""""""""""""""""""

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" (CTRL-F) open Fuzzy Finder
nnoremap <C-f> <ESC>:Files<CR>

" (CTRL-O) open Nerd Tree
nnoremap <C-o> <ESC>:NERDTreeToggle<CR>

" (CTRL-G) open GPT
nnoremap <C-g> <ESC>:GPT<CR>

"""""""""""""""""""""""""""""""
" Plugins Settings            "
"""""""""""""""""""""""""""""""

" Automatically run the fixers Ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale#statusline#Count = 1
let g:ale_enabled = 0

" Lightline
let g:lightline = {
      \ 'colorscheme': 'dracula',
      \ }

" Set test runners and options
let test#go#runner = 'gotest'
let test#python#runner = 'pytest'
let test#clojure#runner = 'fireplacetest'
let test#python#pytest#options = '--verbose'

" NERDTree settings
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.DS_Store', '\.pyc$', '\.sw[^\.]*', '\.git$[[dir]]', '.ipynb_checkpoints$[[dir]]', '__pycache__[[dir]]', '.tox', '.pytest_cache', '.egg-info', 'venv', 'dist', '.mypy_cache', '.bsp', 'target']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeQuitOnOpen = 1

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set font for dev-icons
set guifont=DroidSansMono\ Nerd\ Font\ 11

" Fuzzy Finder
let g:fzf_colors = {
  \ 'fg':         ['fg', 'Normal'],
  \ 'bg':         ['bg', 'Normal'],
  \ 'preview-bg': ['bg', 'NormalFloat'],
  \ 'hl':         ['fg', 'Comment'],
  \ 'fg+':        ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':        ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':        ['fg', 'Statement'],
  \ 'info':       ['fg', 'PreProc'],
  \ 'border':     ['fg', 'Comment'],
  \ 'prompt':     ['fg', 'Comment'],
  \ 'pointer':    ['fg', 'Exception'],
  \ 'marker':     ['fg', 'Keyword'],
  \ 'spinner':    ['fg', 'Label'],
  \ 'header':     ['fg', 'Comment']
  \ }

"""""""""""""""""""""""""""""""
" Python Settings             "
"""""""""""""""""""""""""""""""

" Column
highlight ColorColumn ctermbg=235
autocmd FileType python set colorcolumn=80

"""""""""""""""""""""""""""""""
" Go Settings                 "
"""""""""""""""""""""""""""""""

" Format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

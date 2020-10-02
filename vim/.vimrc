"*****************************************************************************
"" Vim Settings
"*****************************************************************************

"*****************************************************************************
"" Plugins
"*****************************************************************************

call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'micha/vim-colors-solarized'

" Beautiful statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Navigation
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'

" Go development plugin
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" Linter
Plug 'w0rp/ale'

" Tests
Plug 'janko-m/vim-test'

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

call plug#end()

""*****************************************************************************
""" Basic Settings
""*****************************************************************************

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

set number relativenumber

" Enable relative number only for the tab on focus
augroup numbertoggle
  autocmd!
  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
augroup END

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

""*****************************************************************************
""" Visual Settings
""*****************************************************************************

" Enable syntax highlighting
syntax on
syntax enable
set ruler
set number

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

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
let g:solarized_termtrans=1
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

" Spell Check
set spelllang=en,pt-br
set spellfile=~/.vim/spell/en.utf-8.add
hi clear SpellBad
hi SpellBad ctermbg=52
set spell

""*****************************************************************************
""" Commands
""*****************************************************************************

command WQ wq
command Wq wq
command W w
command Q q

" Format JSON
:command JSONFormatter %!python -m json.tool

" https://vim.fandom.com/wiki/In_line_copy_and_paste_to_system_clipboard
" The reason for the double-command on <C-c> is due to some weirdness with the X clipboard system.
vmap <C-S-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-S-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

"*****************************************************************************
""" Mappings
""*****************************************************************************

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" Quick Save
nnoremap <S-s> :w<CR>

" (CTRL-O) open Nerd Tree
nnoremap <C-o> <ESC>:NERDTreeToggle<CR>

"*****************************************************************************
"" Plugins Settings
"*****************************************************************************

" Automatically run the fixers Ale
let g:ale_fix_on_save = 1
let g:ale_fixers = {'*': ['remove_trailing_lines', 'trim_whitespace']}
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
let g:ale#statusline#Count = 1

" Airline
let g:airline_theme = 'solarized'
let g:airline#extensions#virtualenv#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Set test runners and options
let test#go#runner = 'gotest'
let test#python#runner = 'pytest'
let test#clojure#runner = 'fireplacetest'
let test#python#pytest#options = '--verbose'

" NERDTree settings
let g:NERDTreeChDirMode = 2
let g:NERDTreeIgnore = ['\.DS_Store', '\.pyc$', '\.sw[^\.]*', '\.git$[[dir]]', '.ipynb_checkpoints$[[dir]]', '__pycache__[[dir]]', '.tox', '.pytest_cache', '.egg-info', 'venv', 'dist', '.mypy_cache']
let g:NERDTreeSortOrder = ['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks = 1
let g:nerdtree_tabs_focus_on_files = 1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 40
let g:NERDTreeShowHidden = 1
let g:NERDTreeShowLineNumbers = 0
let g:NERDTreeQuitOnOpen = 1

let g:polyglot_disabled = ['go']

" Disable relative number when enter the NERDTree buffer
autocmd BufEnter NERD_* setlocal norelativenumber

" Open NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set font for dev-icons
set guifont=DroidSansMono\ Nerd\ Font\ 11

if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

" Unicode Symbols
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_symbols.linenr = '␤'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" Airline Symbols
if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
endif

""*****************************************************************************
""" Python Settings
""*****************************************************************************

" Column
autocmd FileType python set colorcolumn=80

""*****************************************************************************
""" Go Settings
""*****************************************************************************

" Format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

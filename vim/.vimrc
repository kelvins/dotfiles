" Vim configurations

" IMPORTANT:
" Make sure we are using Python3 as the default version (to work with black).
" pip install flake8
" pip install isort
" pip install yapf
" pip install jedi
" pip install black

"*****************************************************************************
"" Vim-Plug core
"*****************************************************************************

let vimplug_exists=expand('~/.vim/autoload/plug.vim')

if !filereadable(vimplug_exists)
  if !executable("curl")
    echoerr "You have to install curl or first install vim-plug yourself!"
    execute "q!"
  endif
  echo "Installing Vim-Plug..."
  echo ""
  silent exec "!\curl -fLo " . vimplug_exists . " --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
  let g:not_finish_vimplug = "yes"

  autocmd VimEnter * PlugInstall
endif

"*****************************************************************************
"" Plugins
"*****************************************************************************

call plug#begin('~/.vim/plugged')

" Syntax highlight
Plug 'sheerun/vim-polyglot'

" Lint: ALE + flake8 + isort + yapf
Plug 'w0rp/ale'

" Code Completion
Plug 'maralla/completor.vim'

" Code navigation
Plug 'davidhalter/jedi-vim'

" Navigate through files
Plug 'ctrlpvim/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Tests
Plug 'janko-m/vim-test'

" https://github.com/fatih/vim-go
Plug 'fatih/vim-go'

" docker-syntax
Plug 'ekalinin/Dockerfile.vim'

" Beautiful statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Black code formatter
"Plug 'ambv/black'

" Colorscheme
Plug 'micha/vim-colors-solarized'

" Golden-ratio
Plug 'roman/golden-ratio'

" NERD commenter
Plug 'scrooloose/nerdcommenter'

" Auto pairs
Plug 'jiangmiao/auto-pairs'

" Git
Plug 'tpope/vim-fugitive'

" Devicons
Plug 'ryanoasis/vim-devicons'

" Markdown Preview
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() } }

call plug#end()

"*****************************************************************************
"" Plugins Settings
"*****************************************************************************

" Automatically run the fixers
" We can also call :ALEFix to run it
let g:ale_fix_on_save = 1
let g:ale_fixers = {'python': ['isort', 'remove_trailing_lines', 'trim_whitespace']}

" jedi-vim
" To not conflict with completor
let g:jedi#completions_enabled = 0
let g:jedi#popup_on_dot = 0
let g:jedi#documentation_command = "K"
let g:jedi#show_call_signatures = "0"
let g:jedi#smart_auto_mappings = 0

" Airline theme
let g:airline_theme='solarized'
let g:airline#extensions#virtualenv#enabled = 1

" Use pytest as runner
" :TestNearest, :TestFile, :TestSuite, :TestLast e :TestVisit
let test#python#runner = 'pytest'
let test#python#pytest#options = '--verbose'

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['\.DS_Store', '\.pyc$', '\.sw[^\.]*', '\.git$[[dir]]', '.ipynb_checkpoints$[[dir]]', '__pycache__[[dir]]' ]
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden=1

" Disable golden ratio for nerdtree
"let g:golden_ratio_exclude_nonmodifiable = 1
"let b:golden_ratio_resizing_ignored = 1

" open a NERDTree automatically when vim starts up if no files were specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set font for dev-icons
set guifont=DroidSansMono\ Nerd\ Font\ 11

"*****************************************************************************
"" Mappings
"*****************************************************************************

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <C-n> :NERDTreeToggle<CR>
" nnoremap <silent> <F3> :NERDTreeToggle<CR>

" insert and remove comments in visual and normal mode
map ,ic :s/^/# /g<CR>:let @/ = ""<CR>
map ,rc :s/^# //g<CR>:let @/ = ""<CR>

"" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

"*****************************************************************************
"" Basic Settings
"*****************************************************************************

" IMPORTANT: we need to set the zsh path here
set shell=/bin/zsh

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencoding=utf-8
set fileencodings=utf-8

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

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" My commands
"*****************************************************************************

com! FormatJSON %!python -m json.tool

" https://vim.fandom.com/wiki/In_line_copy_and_paste_to_system_clipboard
" On ubuntu (running Vim in gnome-terminal)
" The reason for the double-command on <C-c> is due to some weirdness with the X clipboard system.
vmap <C-c> y:call system("xclip -i -selection clipboard", getreg("\""))<CR>:call system("xclip -i", getreg("\""))<CR>
nmap <C-v> :call setreg("\"",system("xclip -o -selection clipboard"))<CR>p

"*****************************************************************************
"" Python Basic Settings
"*****************************************************************************

" Column
autocmd FileType python set colorcolumn=80
"autocmd BufWritePre *.py execute ':Black'
"let g:black_skip_string_normalization = 1
"let g:black_line_length = 80

" Python debugger on macro -> p
let @p="Oimport pdb; pdb.set_trace()"

"*****************************************************************************
"" Go Basic Settings
"*****************************************************************************

" format with goimports instead of gofmt
let g:go_fmt_command = "goimports"

"*****************************************************************************
"" Visual Settings
"*****************************************************************************

" Enable syntax highlighting
syntax on
set ruler
set number

" Enable 256 colors palette in Gnome Terminal
if $COLORTERM == 'gnome-terminal'
    set t_Co=256
endif

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar
set laststatus=2

"" Use modeline overrides
set modeline
set modelines=10

" set statusline=%r%h%w%=(line\ %l\/%L,\ col\ %c)

" Colorscheme
set t_Co=16
syntax enable
let g:solarized_termtrans=1
let g:solarized_termcolors=16
set background=dark
colorscheme solarized

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" NERDTree
let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'

" vim-airline
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif

if !exists('g:airline_powerline_fonts')
  let g:airline#extensions#tabline#left_sep = ''
  let g:airline#extensions#tabline#left_alt_sep = ''

  " powerline symbols
  let g:airline_left_sep = ''
  let g:airline_left_alt_sep = ''
  let g:airline_right_sep = ''
  let g:airline_right_alt_sep = ''
  let g:airline_symbols.branch = ''
  let g:airline_symbols.readonly = ''
  let g:airline_symbols.linenr = ''
endif


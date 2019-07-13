" Vim configurations

" IMPORTANT:
" pip install flake8 isort yapf
" pip install jedi

"*****************************************************************************
"" Vim-PLug core
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
Plug 'scrooloose/nerdtree' | Plug 'Xuyuanp/nerdtree-git-plugin'

" Tests
Plug 'janko-m/vim-test'

" https://github.com/fatih/vim-go
Plug 'fatih/vim-go'

"docker-syntax
Plug 'ekalinin/Dockerfile.vim'

call plug#end()

" Automatically run the fixers
" We can also call :ALEFix to run it
let g:ale_fix_on_save = 1
let g:ale_fixers = {
\   'python': [
\       'isort',
\       'yapf',
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ]
\}

" To not conflict with completor
let g:jedi#completions_enabled = 0

" Use pytest as runner
" :TestNearest, :TestFile, :TestSuite, :TestLast e :TestVisit
let test#python#runner = 'pytest'

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore = ['\.pyc$', '\.sw[^\.]*', '\.git$[[dir]]', '.ipynb_checkpoints$[[dir]]', '__pycache__[[dir]]' ]
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 50

nnoremap <silent> <F2> :NERDTreeFind<CR>
nnoremap <silent> <F3> :NERDTreeToggle<CR>

"*****************************************************************************
"" Basic Settings 
"*****************************************************************************

" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8
set fileencoding=utf-8
set fileencodings=utf-8

"" Fix backspace indent
set backspace=indent,eol,start

"" Tabs. May be overridden by autocmd rules
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab

" Linebreak on 500 characters
set lbr
set tw=500

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

set fileformats=unix,dos,mac

if exists('$SHELL')
    set shell=$SHELL
else
    set shell=/bin/sh
endif

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

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

set statusline=%r%h%w%=(line\ %l\/%L,\ col\ %c)

try
    colorscheme desert
catch
endtry

set background=dark

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

" Completion
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-vsnip'
Plug 'hrsh7th/vim-vsnip'

" Scala Metals
Plug 'scalameta/nvim-metals'
Plug 'nvim-lua/plenary.nvim'

call plug#end()

"""""""""""""""""""""""""""""""""""""""
" Plugins Settings                    "
"""""""""""""""""""""""""""""""""""""""

lua require('nvim-tree-config')
lua require('lualine-config')
lua require('telescope-config')
lua require('alpha').setup(require('alpha.themes.startify').config)
lua require('cmp-config')

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
" Nvim Tree Settings                  "
"""""""""""""""""""""""""""""""""""""""

" Automatically close Nvim Tree if it is the last window in the tab
autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif

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

command SBT %:split | terminal sbt

" Format JSON
command JSONFormatter %!python -m json.tool

"""""""""""""""""""""""""""""""""""""""
" Mappings                            "
"""""""""""""""""""""""""""""""""""""""

" (CTRL+T) Create new tab
nnoremap <C-t> :tabnew<CR>

" Switching windows
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h

" (CTRL-O) Open Nvim Tree
nnoremap <C-o> <ESC>:NvimTreeToggle<CR>

" (CTRL-F) Find files using Telescope
nnoremap <C-f> <ESC>:Telescope find_files<CR>

" LSP
nnoremap <silent> gd          <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K           <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gi          <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> gr          <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gds         <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gws         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <leader>rn  <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <leader>f   <cmd>lua vim.lsp.buf.formatting()<CR>
nnoremap <silent> <leader>ca  <cmd>lua vim.lsp.buf.code_action()<CR>
nnoremap <silent> <leader>ws  <cmd>lua require'metals'.worksheet_hover()<CR>
nnoremap <silent> <leader>a   <cmd>lua require'metals'.open_all_diagnostics()<CR>
nnoremap <silent> <space>d    <cmd>lua vim.lsp.diagnostic.set_loclist()<CR>
nnoremap <silent> [c          <cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>
nnoremap <silent> ]c          <cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>

"""""""""""""""""""""""""""""""
" Python Settings             "
"""""""""""""""""""""""""""""""

" Color Column
autocmd FileType python set colorcolumn=80

"""""""""""""""""""""""""""""""
" Scala Settings              "
"""""""""""""""""""""""""""""""

" Color Column
autocmd FileType scala set colorcolumn=120

" Require metals for scala or sbt files
autocmd FileType scala,sbt lua require('metals-config')

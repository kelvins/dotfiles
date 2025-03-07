-- General Settings
vim.opt.mouse = 'a'                   -- Enable mouse support
vim.opt.clipboard = 'unnamedplus'     -- Use system clipboard

-- Interface Settings
vim.opt.number = true                 -- Show line numbers
vim.opt.relativenumber = false        -- Show relative line numbers
vim.opt.cursorline = true             -- Highlight current line
vim.opt.showcmd = true                -- Show command in bottom bar
vim.opt.showmode = false              -- Don’t show mode since it’s already in statusline

vim.cmd([[
  highlight CursorLine cterm=NONE ctermbg=DarkGray guibg=#3c3c3c
]])

-- Tabs and Indentation
vim.opt.expandtab = true              -- Use spaces instead of tabs
vim.opt.shiftwidth = 4                -- Shift 4 spaces when tab
vim.opt.tabstop = 4                   -- 1 tab == 4 spaces
vim.opt.smartindent = true            -- Auto-indent new lines

-- Search Settings
vim.opt.ignorecase = true             -- Ignore case when searching
vim.opt.smartcase = true              -- Use smart case

-- Performance
vim.opt.lazyredraw = true             -- Faster scrolling
vim.opt.synmaxcol = 240               -- Max column for syntax highlighting

-- Splits
vim.opt.splitright = true             -- Vertical split to the right
vim.opt.splitbelow = true             -- Horizontal split to the bottom

-- Timeouts
vim.opt.timeoutlen = 500              -- Time to wait for mapped sequence completion (in milliseconds)

-- Wrap
vim.opt.wrap = false                  -- Disable line wrapping

-- Backup and Swap Files
vim.opt.swapfile = false              -- Don't use swapfile
vim.opt.backup = false                -- Prevent editing backup files
vim.opt.undofile = true               -- Enable persistent undo

-- Scroll Offsets
vim.opt.scrolloff = 8                 -- Keep 8 lines visible above/below the cursor
vim.opt.sidescrolloff = 8             -- Keep 8 columns visible to the left/right of the cursor

-- Wild Menu
vim.opt.wildmenu = true                -- Visual autocomplete for command menu
vim.opt.wildmode = 'longest:full,full' -- Command-line completion mode

-- Enable true color support
vim.opt.termguicolors = true

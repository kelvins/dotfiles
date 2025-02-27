-- <leader> is a space now
local map = vim.keymap.set

-- NvimTree
map("n", "<C-o>", ":NvimTreeToggle<CR>", { desc = "Toggle NvimTree sidebar" })

map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true }) -- Left
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true }) -- Down
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true }) -- Up
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true }) -- Right

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep,  { desc = 'Telescope live grep'  })

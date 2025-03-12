-- <leader> is a space now
local map = vim.keymap.set

-- NvimTree
map('n', '<C-o>', ':NvimTreeToggle<CR>', { desc = 'Toggle NvimTree sidebar' })

map('n', '<C-h>', '<C-w>h', { noremap = true, silent = true }) -- Left
map('n', '<C-j>', '<C-w>j', { noremap = true, silent = true }) -- Down
map('n', '<C-k>', '<C-w>k', { noremap = true, silent = true }) -- Up
map('n', '<C-l>', '<C-w>l', { noremap = true, silent = true }) -- Right

local builtin = require('telescope.builtin')
map('n', '<leader>ff', builtin.find_files, { desc = 'Telescope find files' })
map('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })


-- This is where you enable features that only work if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = { buffer = event.buf }

    map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
    map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    map('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    map('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    map('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    map({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    map('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
  end,
})

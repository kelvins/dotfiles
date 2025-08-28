-- Define autocommands with Lua APIs
-- See: h:api-autocmd, h:augroup
local augroup = vim.api.nvim_create_augroup -- Create/get autocommand group
local autocmd = vim.api.nvim_create_autocmd -- Create autocommand

autocmd('Filetype', {
  pattern = { 'xml', 'html', 'xhtml', 'css', 'scss', 'javascript', 'typescript', 'yaml', 'lua' },
  command = 'setlocal shiftwidth=2 tabstop=2'
})

-- Set colorcolumn
autocmd('Filetype', {
  pattern = { 'python', 'rst', 'c', 'cpp' },
  command = 'set colorcolumn=80'
})

autocmd('Filetype', {
  pattern = { 'gitcommit', 'markdown', 'text' },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

--autocmd('QuitPre', {
--  callback = function() vim.cmd('NvimTreeClose') end,
--})

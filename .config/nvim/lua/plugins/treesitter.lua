local parsers = { 'c', 'lua', 'vim', 'python', 'query', 'clojure', 'go', 'rust', 'html', 'scala' }

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  config = function ()
    require('nvim-treesitter').install(parsers)

    vim.api.nvim_create_autocmd('FileType', {
      pattern = parsers,
      callback = function()
        vim.treesitter.start()
      end,
    })
  end
 }

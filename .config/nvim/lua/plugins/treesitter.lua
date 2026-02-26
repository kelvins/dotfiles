return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  config = function () 
    local configs = require('nvim-treesitter.config')

    configs.setup({
        ensure_installed = { 'c', 'lua', 'vim', 'python', 'query', 'clojure', 'go', 'rust', 'html', 'scala' },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },  
      })
  end
 }

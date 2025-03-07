return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.ruff.setup {}
    lspconfig.gopls.setup {}
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT'
          },
          diagnostics = {
            globals = { 'vim', 'require' }
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true)
          },
          telemetry = {
            enable = false
          }
        }
      }
    }
    lspconfig.metals.setup {}
    lspconfig.pyright.setup {}
    lspconfig.clojure_lsp.setup {}
    lspconfig.rust_analyzer.setup {}
  end,
}

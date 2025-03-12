return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    -- Python
    lspconfig.ruff.setup {}
    -- Go
    lspconfig.gopls.setup {}
    -- Lua
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
    -- Scala
    lspconfig.metals.setup {}
    -- Clojure
    lspconfig.clojure_lsp.setup {}
    -- Rust
    lspconfig.rust_analyzer.setup {}
  end,
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    local lspconfig = require('lspconfig')
    -- Python
    vim.lsp.config('ruff', {})
    --lspconfig.pylsp.setup {}
    -- Go
    vim.lsp.config('gopls', {})
    -- Lua
    vim.lsp.config('lua_ls', {
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
    })
    -- Scala
    vim.lsp.config('metals', {})
    -- Clojure
    vim.lsp.config('clojure_lsp', {})
    -- Rust
    vim.lsp.config('rust_analyzer', {})
  end,
}

return {
  'neovim/nvim-lspconfig',
  config = function()
    -- Use Neovim 0.11+ API (see :help lspconfig-nvim-0.11)

    -- Python
    vim.lsp.enable('ruff')
    -- If you also use pylsp, enable it similarly:
    -- vim.lsp.enable('pylsp')

    -- Go
    vim.lsp.enable('gopls')

    -- Lua (keep the custom settings)
    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim', 'require' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
          },
          telemetry = {
            enable = false,
          },
        },
      },
    })
    vim.lsp.enable('lua_ls')

    -- Scala
    vim.lsp.enable('metals')

    -- Clojure
    vim.lsp.enable('clojure_lsp')

    -- Rust
    vim.lsp.enable('rust_analyzer')
  end,
}

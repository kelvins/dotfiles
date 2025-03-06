return {
  "neovim/nvim-lspconfig",
  config = function()
    local lspconfig = require('lspconfig')
    lspconfig.ruff.setup {}
    lspconfig.gopls.setup {}
    lspconfig.lua_ls.setup {}
    lspconfig.metals.setup {}
    lspconfig.pyright.setup {}
    lspconfig.clojure_lsp.setup {}
    lspconfig.rust_analyzer.setup {}
  end,
}

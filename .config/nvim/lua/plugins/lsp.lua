return {
  "neovim/nvim-lspconfig",
  config = function()
    require("lspconfig").ruff.setup {}
    require("lspconfig").gopls.setup {}
    require("lspconfig").lua_ls.setup {}
    require("lspconfig").metals.setup {}
    require("lspconfig").pyright.setup {}
    require("lspconfig").clojure_lsp.setup {}
    require("lspconfig").rust_analyzer.setup {}
  end,
}

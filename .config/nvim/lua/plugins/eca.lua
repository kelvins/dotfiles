return {
  "editor-code-assistant/eca-nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "nvim-lua/plenary.nvim",
  },
  keys = {
    { "<leader>ec", "<cmd>EcaChat<cr>", desc = "Open ECA chat" },
    { "<leader>ef", "<cmd>EcaFocus<cr>", desc = "Focus ECA sidebar" },
    { "<leader>et", "<cmd>EcaToggle<cr>", desc = "Toggle ECA sidebar" },
  },
  opts = {
    debug = false,
    behaviour = {
      auto_set_keymaps = true,
      auto_focus_sidebar = true,
    },
  }
}

vim.g.loaded = 1
vim.g.loaded_netrwPlugin = 1

require("nvim-tree").setup({
  open_on_setup = true,
  open_on_setup_file = false,
  sort_by = "case_sensitive",
  hijack_cursor = true,
  update_focused_file = {
    enable = true,
  },
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
    custom = {
      "^\\.git",
      "^\\.DS_Store",
      "^\\.pyc$",
      "^\\.mypy_cache",
    },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

local header = {
  '',
  ' ███╗   ██╗ ███████╗ ██████╗  ██╗   ██╗ ██╗ ███╗   ███╗',
  ' ████╗  ██║ ██╔════╝██╔═══██╗ ██║   ██║ ██║ ████╗ ████║',
  ' ██╔██╗ ██║ █████╗  ██║   ██║ ██║   ██║ ██║ ██╔████╔██║',
  ' ██║╚██╗██║ ██╔══╝  ██║   ██║ ╚██╗ ██╔╝ ██║ ██║╚██╔╝██║',
  ' ██║ ╚████║ ███████╗╚██████╔╝  ╚████╔╝  ██║ ██║ ╚═╝ ██║',
  ' ╚═╝  ╚═══╝ ╚══════╝ ╚═════╝    ╚═══╝   ╚═╝ ╚═╝     ╚═╝',
  '',
}

return {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      theme = 'hyper',
      config = {
        header = header,
        shortcut = {
          {
            key = 'u',
            desc = 'Update',
            group = 'DiagnosticWarn',
            action = 'Lazy update'
          },
          {
            key = 'f',
            desc = 'Files',
            group = 'DiagnosticInfo',
            action = 'Telescope find_files'
          },
          {
            key = 'e',
            desc = 'Explorer',
            group = 'DiagnosticInfo',
            action = 'NvimTreeToggle'
          },
          {
            key = 'p',
            desc = 'Projects',
            group = 'DiagnosticInfo',
            action = 'Telescope projects'
          },
          {
            key = 'c',
            desc = 'Eca',
            group = 'DiagnosticHint',
            action = 'EcaChat'
          },
          {
            key = 'q',
            desc = 'Quit',
            group = 'DiagnosticError',
            action = 'quit'
          }
        },
        project = {
          enable = true,
          limit = 5,
          label = 'Recent Projects',
          action = 'Telescope find_files cwd=',
        },
        mru = {
          limit = 10,
          label = 'Recent Files',
          action = 'Telescope oldfiles',
        },
        packages = { enable = false },
        footer = function()
          local stats = require('lazy').stats()
          local ms = math.ceil(math.floor(stats.startuptime * 100 + 0.5) / 100)
          return { '', '⚡ Neovim loaded ' .. stats.loaded .. '/' .. stats.count .. ' plugins in ' .. ms .. ' ms' }
        end,
      }
    }
    vim.api.nvim_set_hl(0, 'DashboardFooter', { fg = '#6272a4' })
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

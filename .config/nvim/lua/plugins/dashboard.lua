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
            group = '@property',
            action = 'Lazy update'
          },
          {
            key = 'f',
            desc = 'Files',
            group = '@property',
            action = 'Telescope find_files'
          },
          {
            key = 'q',
            desc = 'Quit',
            group = '@property',
            action = 'quit'
          }
        },
        project = {
          enable = false,
          limit = 10,
          label = 'Projects',
          action = 'Telescope projects',
        },
        mru = {
          limit = 10,
          label = 'Recent Files',
          action = 'Telescope oldfiles',
        },
        footer = {}
      }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
}

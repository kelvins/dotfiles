return {
  'ahmedkhalf/project.nvim',
  event = 'VimEnter',
  dependencies = { 'nvim-telescope/telescope.nvim' },
  config = function()
    require('project_nvim').setup {
      -- match on well-known project markers first, fall back to LSP root
      detection_methods = { 'pattern', 'lsp' },
      patterns = {
        '.git',
        'go.mod',
        'Cargo.toml',
        'pyproject.toml',
        'deps.edn',
        'project.clj',
        'build.sbt',
      },
      silent_chdir = false,
    }
    require('telescope').load_extension('projects')

    -- dashboard-nvim's own "Recent Projects" widget only records a project
    -- when the dashboard buffer itself was shown that session (it doesn't
    -- trigger for `nvim .`), so its cache almost never fills in. Mirror
    -- project.nvim's history into dashboard's cache file on quit instead.
    vim.api.nvim_create_autocmd('VimLeavePre', {
      callback = function()
        local projects = require('project_nvim.utils.history').get_recent_projects()
        local dir = vim.fn.stdpath('cache') .. '/dashboard'
        vim.fn.mkdir(dir, 'p')
        local fd = io.open(dir .. '/cache', 'w')
        if fd then
          fd:write('return ' .. vim.inspect(projects))
          fd:close()
        end
      end,
    })
  end,
}

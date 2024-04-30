return {
  'stevearc/oil.nvim',
  --dependencies = { 'nvim-tree/nvim-web-devicons' },
  priority = 999,
  config = function()
    local oil = require 'oil'
    oil.setup {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      float = {
        padding = 4,
        max_width = 60,
        max_height = 30,
      },
      keymaps = {
        ['<C-v>'] = 'actions.select_vsplit',
        ['<C-x>'] = 'actions.select_split',
        ['<CR>'] = 'actions.select',
        ['-'] = 'actions.parent',
      },
      use_default_keymaps = false,
    }
    vim.keymap.set('n', '<leader>pe', function() oil.toggle_float() end, { desc = '[p]roject [e]dit / view' })
  end,
}

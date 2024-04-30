return {
  'theprimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = {
    'nvim-lua/plenary.nvim',
  },
  keys = function()
    local harpoon = require 'harpoon'
    harpoon:setup()
    vim.keymap.set('n', '<leader>h', function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, { desc = '[H]arpoon open' })
    vim.keymap.set('n', '<leader>a', function() print '🔱' harpoon:list():add() end, { desc = "[A]dd Harpoon"})
  end,
}

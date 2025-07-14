local plugins = {
  {
    'tpope/vim-dadbod',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod',                     lazy = true },
      { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
      'DBUI',
      'DBUIToggle',
      'DBUIAddConnection',
      'DBUIFindBuffer',
    },
  },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'LspAttach' },
    opts = {},
  },
  {
    'nvim-focus/focus.nvim',
    event = { 'VeryLazy' },
    version = '*',
    opts = {
      enable = true,
      autoresize = {
        minheight = 10,
        minwidth = 30,
      },
      ui = {
        signcolumn = false,
        cursorline = false,
      },
    },
  },
  {
    -- TABLE OF CONTENTS:
    -- PERF:
    -- HACK:
    -- TODO:
    -- NOTE:
    -- FIX:
    -- WARNING:
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}

return plugins

local plugins = {
  -- {
  --   'tpope/vim-dadbod',
  -- },
  -- {
  --   'kristijanhusak/vim-dadbod-ui',
  --   dependencies = {
  --     { 'tpope/vim-dadbod',                     lazy = true },
  --     { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
  --   },
  --   cmd = {
  --     'DBUI',
  --     'DBUIToggle',
  --     'DBUIAddConnection',
  --     'DBUIFindBuffer',
  --   },
  -- },
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
    opts = {
      enable_check_bracket_line = true,
      ignored_next_char = '[%w%.%{%(%[]',
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = { 'LspAttach' },
    opts = {},
  },
  {
    'nvim-focus/focus.nvim',
    -- event = { 'VeryLazy' },
    version = '*',
    -- cmd = { 'Split', 'Vsplit' },
    opts = {
      enable = true,
      autoresize = {
        minheight = 10,
        minwidth = 40,
      },
      ui = {
        signcolumn = false,
        cursorline = false,
      },
    },
  },
  {
    -- :TodoQuickFix
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

local plugins = {
  {
    'tpope/vim-dadbod',
  },
  {
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
      { 'tpope/vim-dadbod', lazy = true },
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
  { 'windwp/nvim-ts-autotag', event = { 'LspAttach' }, opts = {} },
  { 'chentoast/marks.nvim', opts = {}, keys = 'm' },
  {
    'kkoomen/vim-doge',
    event = 'VeryLazy',
    build = ':call doge#install()',
    config = function()
      vim.g.doge_mapping_comment_jump_forward = '<C-n>'
      vim.g.doge_mapping_comment_jump_backward = '<C-p>'
    end,
  },
  {
    'nvim-focus/focus.nvim',
    -- TABLE OF CONTENTS:
    -- PERF:
    -- HACK:
    -- TODO:
    -- NOTE:
    -- FIX:
    -- WARNING:
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
      },
    },
  },
  {
    'folke/todo-comments.nvim',
    event = 'VeryLazy',
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = { signs = false },
  },
}

return plugins

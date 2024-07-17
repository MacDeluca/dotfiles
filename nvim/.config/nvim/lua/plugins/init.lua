local plugins = {
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
    event = { 'VeryLazy' },
    version = '*',
    opts = {
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

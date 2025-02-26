return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = { enabled = true },
    picker = {
      prompt = '🔮 ',
      formatters = {
        file = {
          truncate = 60,
        },
      },
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
          },
        },
      },
    },
  },
  keys = function()
    Snacks = require('snacks')

    -- stylua: ignore start
    vim.keymap.set('n', 'gv', ":vsplit | lua Snacks.picker.lsp_definitions()<CR>", { noremap = true, silent = true })

    return {
      -- Find files
      { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { '<leader>pf', function() Snacks.picker.files({ hidden = true }) end, desc = 'Find Files' },
      { '<leader>ph', function() Snacks.picker.recent() end, desc = 'Recent' },
      {'<leader>n', function() Snacks.picker.files({ dirs = { "~/notes" }}) end, desc = 'Notes'},
      {'<leader>ns', function() Snacks.picker.grep({ dirs = { "~/notes" }}) end, desc = 'Notes'},

      -- Search in files and buffers
      { '<leader>ps', function() Snacks.picker.grep({ hidden = true }) end, desc = 'Grep' },
      { '<leader>pb', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>pw', function() Snacks.picker.grep_word() end, desc = 'Visual selection or word', mode = { 'n', 'x' } },

      -- Git actions
      { '<leader>gb', function() Snacks.picker.git_branches() end, desc = '[G]it [B]ranches' },
      { "<leader>gu", function() Snacks.picker.git_status() end, desc = "[G]it [S]tatus" },

      -- LSP
      { 'gd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
      { 'gr', function() Snacks.picker.lsp_references() end, nowait = true, desc = '[G]oto [R]eferences' },
      { 'gt', function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto [T]ype Definition' },

      -- I can't spell
      { '<leader>sp', function() Snacks.picker.spelling() end, desc = '[S]pelling' },
    }
  end,
}

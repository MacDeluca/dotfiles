return {
  'nvim-telescope/telescope.nvim',
  event = { 'VeryLazy' },
  branch = '0.1.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'theprimeagen/harpoon',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function() return vim.fn.executable('make') == 1 end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local builtin = require('telescope.builtin')
    local actions = require('telescope.actions')
    local conf = require('telescope.config').values

    require('telescope').setup({
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_cursor(),
        },
      },
      defaults = {
        path_display = { 'smart' },
        mappings = {
          i = {
            ['<esc>'] = actions.close,
            ['<C-k>'] = 'move_selection_previous',
            ['<C-j>'] = 'move_selection_next',
          },
        },
      },
      pickers = {
        live_grep = {
          file_ignore_patterns = { 'node_modules', 'package-lock.json' },
          vimgrep_arguments = table.insert(conf.vimgrep_arguments, '--fixed-strings'),
          additional_args = function(_) return { '--hidden' } end,
        },
        find_files = {
          file_ignore_patterns = { 'node_modules', '.git' },
          hidden = true,
        },
        oldfiles = {
          cwd_only = true,
        },
      },
    })

    -- Enable telescope extensions, if they are installed
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'ui-select')

    -- project actions
    vim.keymap.set('n', '<leader>pf', builtin.find_files, { desc = '[P]roject [F]iles' })
    vim.keymap.set('n', '<leader>ps', builtin.live_grep, { desc = '[P]roject [S]earch string' })
    vim.keymap.set('n', '<leader>pw', builtin.grep_string, { desc = '[P]roject [W]ord search' })
    vim.keymap.set('n', '<leader>pg', builtin.git_files, { desc = '[P]roject [G]it files' })
    vim.keymap.set('n', '<leader>pk', builtin.keymaps, { desc = '[P]roject [K]ey maps' })
    vim.keymap.set('n', '<leader><space>', builtin.buffers, { desc = '[ ] Buffers' })

    -- <C-s>: Switch
    -- <C-y>: Merge
    -- <C-a>: Create
    -- <CR>: Checkout
    -- <C-d>: Delete
    vim.keymap.set('n', '<leader>gb', builtin.git_branches, { desc = '[G]it [B]ranches' })
    vim.keymap.set(
      'n',
      '<leader>ph',
      function() builtin.oldfiles({ prompt_title = 'History' }) end,
      { desc = '[P]roject [H]istory' }
    )

    -- Slightly advanced example of overriding default behavior and theme
    vim.keymap.set('n', '<leader>/', function()
      -- You can pass additional configuration to telescope to change theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require('telescope.themes').get_ivy({
        previewer = true,
      }))
    end, { desc = '[/] Fuzzily search in current buffer' })
  end,
}

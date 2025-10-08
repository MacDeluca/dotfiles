vim.g.mapleader = vim.keycode("<Space>") -- Set <Space> as the leader key (used for custom shortcuts)
vim.o.relativenumber = true              -- Show relative line numbers for easier navigation
vim.o.shiftwidth = 2                     -- Indent by 2 spaces when shifting text
vim.o.smartcase = true                   -- Search is case-insensitive unless uppercase letters are used
vim.opt.ignorecase = true                -- Ignore case in search patterns by default
vim.o.wrap = false                       -- Disable line wrapping (keep long lines on one line)
vim.o.signcolumn = "yes"                 -- Always show the sign column to avoid text shifting
vim.o.swapfile = false                   -- Disable swapfile creation (.swp files)
vim.o.timeoutlen = 300                   -- Set key sequence timeout to 300ms
vim.o.splitright = true                  -- Open new vertical splits to the right
vim.o.splitbelow = true                  -- Open new horizontal splits below
vim.o.clipboard = "unnamedplus"          -- Use the system clipboard for all yank/paste operations
vim.o.winborder = "single"               -- Use a single-line border for floating windows

local packages = {
  { src = "https://github.com/catppuccin/nvim.git" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
  { src = "https://github.com/neovim/nvim-lspconfig.git" },
  { src = "https://tpope.io/vim/fugitive.git" },
  { src = "https://github.com/stevearc/oil.nvim.git" },
  { src = "https://github.com/christoomey/vim-tmux-navigator.git" },
  { src = "https://github.com/folke/snacks.nvim.git" },
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1.*") },
}
vim.pack.add(packages)

require("catppuccin").setup({ float = { transparent = true, solid = true }})
vim.cmd.colorscheme("catppuccin")

require("nvim-treesitter.configs").setup({})

require("blink.cmp").setup({ completion = { documentation = { auto_show = true } } })

require("oil").setup({
  view_options = { show_hidden = true },
  float = { max_width = 0.3, max_height = 0.6 },
  keymaps = {
    ['<C-v>'] = 'actions.select_vsplit',
    ['<C-x>'] = 'actions.select_split',
    ['<CR>'] = 'actions.select',
    ['-'] = 'actions.parent',
  },
  use_default_keymaps = false
})

local Snacks = require("snacks")
Snacks.setup({
  bigfile = { enabled = true },
  picker = { enabled = true }
})

-- General
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>o', '<C-w>o', { desc = 'close [o]ther windows' })
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
-- LSP
vim.keymap.set('n', '<leader>k', vim.lsp.buf.code_action)
vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename)
vim.keymap.set('n', '<leader>f', vim.lsp.buf.format)
-- Oil
vim.keymap.set('n', '<leader>pe', require("oil").toggle_float)
-- Tmux navigator
vim.keymap.set('n', '<c-h>', '<cmd>TmuxNavigateLeft<cr>')
vim.keymap.set('n', '<c-j>', '<cmd>TmuxNavigateDown<cr>')
vim.keymap.set('n', '<c-k>', '<cmd>TmuxNavigateUp<cr>')
vim.keymap.set('n', '<c-l>', '<cmd>TmuxNavigateRight<cr>')
-- Fugitive (Git)
vim.keymap.set('n', '<leader>gs', vim.cmd.Git)
vim.keymap.set('n', '<leader>gc', ":Git commit -n -s -m ''<Left>")
-- Snacks picker
vim.keymap.set('n', '<leader>ph', Snacks.picker.recent)
vim.keymap.set('n', '<leader>pf', function() Snacks.picker.files({ hidden = true }) end)
vim.keymap.set('n', '<leader>ps', function() Snacks.picker.grep({ hidden = true }) end)
vim.keymap.set('n', '<leader>gb', function() Snacks.picker.git_branches() end)
vim.keymap.set('n', '<leader>gd', function() Snacks.picker.lsp_definitions() end)

-- :checkhealth vim.lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config('ts_ls', {
  cmd = { 'typescript-language-server', '--stdio' },
  filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
  capabilities = capabilities,
  root_dir = vim.fs.root(0, {
    'tsconfig.json',
    'package.json',
  }),
  settings = {
    diagnostics = {
      -- Disable the JSDoc type hint
      ignoredCodes = { 80004 },
    },
  },
})

vim.lsp.config("lua_ls", {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" }, -- Or "5.1", "5.2", "5.3", "5.4" },
      diagnostics = { globals = { 'vim' } },
      workspace = {
	checkThirdParty = false,
	library = {
	  vim.env.VIMRUNTIME,
	  vim.fn.stdpath("config"),
	},
      },
    }
  }
})

vim.lsp.enable({ "lua_ls" })

vim.api.nvim_create_user_command("UpdatePackages", function()
  -- TODO: Get all the packages and remove the ones that are not in the "packages" list
  vim.pack.update({ "nvim-treesitter", "nvim-lspconfig", "fugitive", "oil.nvim", "snacks.nvim", "blink.cmp" })
  vim.cmd("TSUpdate") -- Update treesitter
end, {})

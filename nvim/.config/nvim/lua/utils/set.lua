-- Set to true if you have a Nerd Font installed
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true

-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.opt.clipboard = 'unnamedplus'

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true
vim.opt.undodir = os.getenv('HOME') .. '/.vim/undodir'

-- Case-insensitive searching UNLESS \C or capital in search
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Default update time :help updatetime
vim.opt.updatetime = 4000

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- -- Show which line your cursor is on
--
vim.opt.cursorline = false

-- Minimal number of screen lines to keep above and below the cursor.

vim.opt.scrolloff = 10

-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Disables line wrapping when switching between windows
-- preventing text from bouncing around
vim.opt.wrap = false

-- Better tab settings
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- Enables single statusline at bottom of scren
vim.opt.laststatus = 3

-- -- Minimal status line
-- function StatusLine()
--   local branch = vim.fn.FugitiveHead()
--
--   local fileDiagnostics = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
--   local right = '%= %l:%c '
--   local left = '🔮 %t %m' --✿
--   local diagnostics = ''
--
--   if branch and #branch > 0 then
--     branch = '  ' .. branch .. ' '
--   end
--
--   if fileDiagnostics > 0 then
--     diagnostics = diagnostics .. '   ' .. fileDiagnostics
--   end
--
--   return branch .. left .. diagnostics .. right
-- end
--
-- vim.opt.statusline = [[%!luaeval('StatusLine()')]]

-- Specify how the floating borders look
local border = {
  { '╭', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╮', 'FloatBorder' },
  { '│', 'FloatBorder' },
  { '╯', 'FloatBorder' },
  { '─', 'FloatBorder' },
  { '╰', 'FloatBorder' },
  { '│', 'FloatBorder' },
}

-- Override the default open_floating_preview to use the border
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
---@diagnostic disable-next-line: duplicate-set-field
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end

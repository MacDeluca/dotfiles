-- Install nightly: brew install --cask cognominal/neovim-nightly.fork/neovim-nightly
-- LSP Configs: https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
--
-- Wezterm: Alt + Enter -> Toggle Fullscreen
-- :checkhealth vim.lsp
-- :Undotree

-- Basic Settings
vim.g.mapleader = vim.keycode("<Space>") -- Set <Space> as the leader key (used for custom shortcuts)
vim.opt.relativenumber = true -- Show relative line numbers for easier navigation
vim.opt.number = true -- Show absolute line numbers
vim.opt.shiftwidth = 2 -- Indent by 2 spaces when shifting text
vim.opt.tabstop = 2 -- Number of spaces a <Tab> counts for
vim.opt.smartcase = true -- Search is case-insensitive unless uppercase letters are used
vim.opt.ignorecase = true -- Ignore case in search patterns by default
vim.opt.wrap = false -- Disable line wrapping (keep long lines on one line)
vim.opt.signcolumn = "yes" -- Always show the sign column to avoid text shifting
vim.opt.swapfile = false -- Disable swapfile creation (.swp files)
vim.opt.timeoutlen = 300 -- Set key sequence timeout to 300ms
vim.opt.splitright = true -- Open new vertical splits to the right
vim.opt.splitbelow = true -- Open new horizontal splits below
vim.opt.clipboard = "unnamedplus" -- Use the system clipboard for all yank/paste operations
vim.opt.winborder = "single" -- Use a single-line border for floating windows
vim.opt.undofile = true -- Enable persistent undo across sessions
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory to store undo history files
vim.opt.laststatus = 3 -- Always show a single global statusline

-- Package Management
local packages = {
  { src = "https://tpope.io/vim/fugitive.git", name = "fugitive" },
  { src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
  { src = "https://github.com/nvim-tree/nvim-web-devicons", name = "nvim-web-devicons" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter.git", version = "main", name = "nvim-treesitter" },
  { src = "https://github.com/stevearc/oil.nvim.git", name = "oil" },
  { src = "https://github.com/christoomey/vim-tmux-navigator.git", name = "vim-tmux-navigator" },
  { src = "https://github.com/folke/snacks.nvim.git", name = "snacks" },
  { src = "https://github.com/saghen/blink.cmp", name = "blink" },
  { src = "https://github.com/neovim/nvim-lspconfig", name = "nvim-lspconfig" },
  { src = "https://github.com/stevearc/conform.nvim", name = "conform" },
  { src = "https://github.com/zbirenbaum/copilot.lua", name = "copilot" },
  { src = "https://github.com/mason-org/mason.nvim", name = "mason" },
}
vim.pack.add(packages)
vim.cmd.packadd("nvim.undotree") -- :Undotree

local function hl(hl_group, text) return "%#" .. hl_group .. "#" .. text .. "%#StatusLine#" end

function StatusLine()
  local num_errors = #vim.diagnostic.get(vim.api.nvim_get_current_buf(), { min = vim.diagnostic.severity.ERROR })
  local err = num_errors > 0 and (" " .. num_errors) or ""
  return " %f %m " .. hl("SLError", err) .. " %=" .. hl("SLBranch", " " .. vim.fn.FugitiveHead()) .. " %l:%c "
end

vim.opt.statusline = [[%!luaeval("StatusLine()")]]

local palette = require("catppuccin.palettes").get_palette("mocha")

require("catppuccin").setup({
  float = {
    transparent = true,
    solid = false,
  },
})
vim.cmd.colorscheme("catppuccin")
vim.api.nvim_set_hl(0, "SLBranch", { fg = palette.green, bold = true })
vim.api.nvim_set_hl(0, "SLError", { fg = palette.red })
vim.api.nvim_set_hl(0, "BlinkCmpMenu", { bg = palette.surface0 })
vim.api.nvim_set_hl(0, "WinSeparator", { fg = palette.mauve })
vim.api.nvim_set_hl(0, "FloatBorder", { fg = palette.lavender })

require("mason").setup()

require("blink.cmp").setup({
  completion = {
    menu = { border = "none" },
  },
  fuzzy = {
    prebuilt_binaries = {
      force_version = "v1.7.0",
    },
  },
})

local languages = { "lua", "typescript", "tsx", "jsx", "json", "html", "css", "bash", "markdown", "jsdoc", "yaml" }
require("nvim-treesitter").install(languages)

vim.api.nvim_create_autocmd("FileType", {
  pattern = "*",
  callback = function() pcall(vim.treesitter.start) end,
})

require("oil").setup({
  view_options = { show_hidden = true },
  float = { max_width = 0.6, max_height = 0.8 },
  keymaps = {
    ["<C-v>"] = "actions.select_vsplit",
    ["<C-x>"] = "actions.select_split",
    ["<CR>"] = "actions.select",
    ["-"] = "actions.parent",
  },
  use_default_keymaps = false,
})

require("snacks").setup({
  styles = { float = { backdrop = 100 } },
  bigfile = { enabled = true },
  picker = { enabled = true },
})

require("conform").setup({
  formatters_by_ft = {
    lua = { "stylua" },
    javascript = { "prettierd", "eslint" },
    javascriptreact = { "prettierd", "eslint" },
    typescript = { "prettierd", "eslint" },
    typescriptreact = { "prettierd", "eslint" },
    cs = { "csharpier" },
    kt = {},
  },
  default_format_opts = {
    lsp_format = "format",
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_format = "fallback",
  },
  notify_on_error = true,
  notify_no_formatters = true,
})

require("copilot").setup({
  copilot_node_command = vim.fn.expand("$HOME") .. "/.nvm/versions/node/v22.19.0/bin/node",
  suggestion = {
    enabled = true,
    auto_trigger = true,
    debounce = 25,
    keymap = {
      accept = "<C-g>",
      next = "<M-n>",
      prev = "<M-p>",
    },
  },
  filetypes = {
    yaml = true,
    markdown = true,
  },
})

-- stylua: ignore start
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>o", "<C-w>o", { desc = "close [o]ther windows" })
vim.keymap.set("n", "<leader>k", vim.lsp.buf.code_action)
vim.keymap.set("n", "<leader>vd", vim.diagnostic.open_float)
vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename)
vim.keymap.set("n", "<leader>pe", require("oil").toggle_float)
vim.keymap.set("n", "<c-h>", "<cmd>TmuxNavigateLeft<cr>")
vim.keymap.set("n", "<c-j>", "<cmd>TmuxNavigateDown<cr>")
vim.keymap.set("n", "<c-k>", "<cmd>TmuxNavigateUp<cr>")
vim.keymap.set("n", "<c-l>", "<cmd>TmuxNavigateRight<cr>")
vim.keymap.set("n", "<leader>j", "<cmd>diffget //3<CR>")
vim.keymap.set("n", "<leader>f", "<cmd>diffget //2<CR>")
vim.keymap.set("n", "<leader>gs", function() vim.cmd("Git | normal! 4j") end)
vim.keymap.set("n", "<leader>gc", ":Git commit -n -s -m ''<Left>")
vim.keymap.set("n", "<leader>gb", function() require("snacks").picker.git_branches() end)
vim.keymap.set("n", "<leader>ph", function() require("snacks").picker.recent() end)
vim.keymap.set("n", "<leader>pf", function() require("snacks").picker.smart({ hidden = true }) end)
vim.keymap.set("n", "<leader>ps", function() require("snacks").picker.grep({ hidden = true }) end)
vim.keymap.set("n", "<leader>pb", function() require("snacks").picker.buffers() end)
vim.keymap.set("n", "<leader>pw", function() require("snacks").picker.grep_word() end)
vim.keymap.set("n", "gd", function() require("snacks").picker.lsp_definitions() end)
vim.keymap.set("n", "gv", ":vsplit | lua Snacks.picker.lsp_definitions()<CR>", { noremap = true, silent = true })
vim.keymap.set("v", "y", "ygv<Esc>", { desc = "better cusor position on yank" })
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")
-- stylua: ignore end

vim.lsp.config("*", { capabilities = require("blink.cmp").get_lsp_capabilities() })

vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" }, -- Or "5.1", "5.2", "5.3", "5.4" },
      diagnostics = { globals = { "vim" } },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          vim.fn.stdpath("config"),
        },
      },
    },
  },
})

vim.lsp.config("ts_ls", {
  settings = {
    diagnostics = {
      ignoredCodes = { 80004 },
    },
  },
})

vim.lsp.config("eslint", {
  settings = {
    nodePath = vim.fn.getcwd() .. "/node_modules",
  },
})

-- vim.lsp.config("kotlin_language_server", {
--   filetypes = { "kotlin" },
--   cmd = { "kotlin-language-server" },
-- })

vim.lsp.config("sourcekit", {
  filetypes = { "swift" },
  cmd = { "sourcekit-lsp" },
})

vim.lsp.enable({ "lua_ls", "ts_ls", "eslint", "sourcekit", "kotlin_language_server" })

vim.api.nvim_create_user_command("UpdatePackages", function()
  local package_names = {}
  for index, pkg in ipairs(packages) do
    package_names[index] = pkg.name
  end
  vim.pack.update(package_names)
  vim.cmd("TSUpdate") -- Update treesitter
end, {})

vim.api.nvim_create_user_command(
  "Config",
  function() vim.cmd("vsplit " .. vim.fn.stdpath("config") .. "/init.lua") end,
  {}
)

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("HighlightYankGroup", { clear = true }),
  desc = "quickly highlights yanked text",
  pattern = "*",
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 50,
    })
  end,
})

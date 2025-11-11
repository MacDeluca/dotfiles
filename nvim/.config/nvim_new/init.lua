-- SETTINGS
vim.g.mapleader = vim.keycode("<Space>") -- Set <Space> as the leader key (used for custom shortcuts)
vim.o.relativenumber = true -- Show relative line numbers for easier navigation
vim.opt.number = true
vim.o.shiftwidth = 2 -- Indent by 2 spaces when shifting text
vim.opt.tabstop = 2
vim.o.smartcase = true -- Search is case-insensitive unless uppercase letters are used
vim.o.ignorecase = true -- Ignore case in search patterns by default
vim.o.wrap = false -- Disable line wrapping (keep long lines on one line)
vim.o.signcolumn = "yes" -- Always show the sign column to avoid text shifting
vim.o.swapfile = false -- Disable swapfile creation (.swp files)
vim.o.timeoutlen = 300 -- Set key sequence timeout to 300ms
vim.o.splitright = true -- Open new vertical splits to the right
vim.o.splitbelow = true -- Open new horizontal splits below
vim.o.clipboard = "unnamedplus" -- Use the system clipboard for all yank/paste operations
vim.o.winborder = "single" -- Use a single-line border for floating windows
vim.opt.undofile = true
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"

function StatusLine()
	local errors = #vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.ERROR })
	local warnings = #vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = vim.diagnostic.severity.WARN })
	local diagnostics = errors + warnings > 0 and (" E" .. errors .. " W" .. warnings) or ""

	return " %f " .. diagnostics .. "%m %=  " .. vim.fn.FugitiveHead() .. " %l:%c "
end

vim.opt.statusline = [[%!luaeval('StatusLine()')]]

-- PACKAGES
vim.pack.add({
	{ src = "https://tpope.io/vim/fugitive.git" },
	{ src = "https://github.com/catppuccin/nvim.git", name = "catppuccin" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter.git" },
	{ src = "https://github.com/stevearc/oil.nvim.git" },
	{ src = "https://github.com/christoomey/vim-tmux-navigator.git" },
	{ src = "https://github.com/folke/snacks.nvim.git" },
	{ src = "https://github.com/saghen/blink.cmp" }, -- version = vim.version.range("1.*")
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{ src = "https://github.com/stevearc/conform.nvim" },
})

vim.cmd.packadd("nvim.undotree") -- :Undotree

require("catppuccin").setup({
	-- transparent_background = true,
	float = { transparent = true, solid = true },
})
vim.cmd.colorscheme("catppuccin")

require("blink.cmp").setup({
	completion = {
		documentation = { auto_show = true },
	},
})

require("nvim-treesitter.configs").setup({
	ensure_installed = { "lua", "typescript", "javascript", "json", "html", "css", "bash", "markdown" },
	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false,
	},
})

require("oil").setup({
	view_options = { show_hidden = true },
	float = { max_width = 0.3, max_height = 0.6 },
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
		javascript = "prettierd",
		typescript = "prettierd",
		javascriptreact = "prettierd",
		typescriptreact = "prettierd",
		cs = { "csharpier" },
		kt = {},
	},
	-- default_format_opts = {
	-- 	lsp_format = "format",
	-- },
	format_on_save = {
		timeout_ms = 500,
		-- lsp_format = "fallback",
	},
	notify_on_error = true,
	notify_no_formatters = true,
})

-- KEYMAPS
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

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
vim.keymap.set("n", "<leader>gc", ":Git commit -n -s -m ''<Left>")

vim.keymap.set("n", "<leader>ph", function()
	require("snacks").picker.recent()
end)
vim.keymap.set("n", "<leader>pf", function()
	require("snacks").picker.files({ hidden = true })
end)
vim.keymap.set("n", "<leader>ps", function()
	require("snacks").picker.grep({ hidden = true })
end)
vim.keymap.set("n", "<leader>gb", function()
	require("snacks").picker.git_branches()
end)
vim.keymap.set("n", "<leader>gd", function()
	require("snacks").picker.lsp_definitions()
end)

-- AUTOCOMMANDS
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

-- :checkhealth vim.lsp
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
local capabilities = require("blink.cmp").get_lsp_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

-- Lua Language Server
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

-- TypeScript Language Server
vim.lsp.config("ts_ls", {
	settings = {
		diagnostics = {
			ignoredCodes = { 80004 }, -- Disable the JSDoc type hint
		},
	},
})

vim.lsp.enable({ "lua_ls", "ts_ls" })

vim.api.nvim_create_user_command("UpdatePackages", function()
	vim.pack.update({ "nvim-treesitter", "fugitive", "oil.nvim", "snacks.nvim", "blink.cmp" })
	vim.cmd("TSUpdate") -- Update treesitter
end, {})

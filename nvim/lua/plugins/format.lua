return {
  'stevearc/conform.nvim',
  event = 'InsertEnter',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black', 'isort' },
      javascript = { { 'prettierd', 'prettier' } },
      typescript = { { 'prettierd', 'prettier' } },
      javascriptreact = { { 'prettierd', 'prettier' } },
      typescriptreact = { { 'prettierd', 'prettier' } },
      bash = { 'shellcheck' },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    notify_on_error = false,
  },
}

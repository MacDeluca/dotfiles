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
      cs = { 'omnisharp', 'csharpier' },
    },
    format_on_save = {
      timeout_ms = 1000,
      lsp_fallback = true,
    },
    notify_on_error = false,
  },
}

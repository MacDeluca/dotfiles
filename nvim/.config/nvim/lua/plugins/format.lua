return {
  'stevearc/conform.nvim',
  event = 'InsertEnter',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black', 'isort' },
      javascript = { { 'prettierd' } },
      typescript = { { 'prettierd' } },
      javascriptreact = { { 'prettierd' } },
      typescriptreact = { { 'prettierd' } },
      bash = { 'shellcheck' },
      cs = { 'csharpier', 'omnisharp' },
    },
    default_format_opts = {
      lsp_format = 'format',
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = 'fallback',
    },
    notify_on_error = true,
    notify_no_formatters = true,
  },
}

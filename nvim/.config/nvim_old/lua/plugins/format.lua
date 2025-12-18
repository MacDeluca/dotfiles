local function getNodeFormatter()
  local prettierConfig = vim.fn.getcwd() .. '/.prettierrc'

  -- If prettier config file exists, use prettierrc
  if vim.fn.filereadable(prettierConfig) == 1 then
    return { 'prettierd' }
  end

  -- If no config file, use eslint_d
  return { 'prettierd', 'eslint_d' }
end

return {
  'stevearc/conform.nvim',
  event = 'InsertEnter',
  opts = {
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black' },
      javascript = getNodeFormatter(),
      typescript = getNodeFormatter(),
      javascriptreact = getNodeFormatter(),
      typescriptreact = getNodeFormatter(),
      bash = { 'shellcheck' },
      cs = { 'csharpier' },
      kt = {},
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

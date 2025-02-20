return {
  'pmizio/typescript-tools.nvim',
  dependencies = { 'nvim-lua/plenary.nvim', 'neovim/nvim-lspconfig' },
  config = function()
    local api = require('typescript-tools.api')

    require('typescript-tools').setup({
      handlers = {
        ['textDocument/publishDiagnostics'] = api.filter_diagnostics(
          -- Disable JSDoc type hint
          { 80004 }
        ),
      },
      settings = {
        tsserver_file_preferences = {
          includeInlayParameterNameHints = 'all',
        },
      },
    })
  end,
}

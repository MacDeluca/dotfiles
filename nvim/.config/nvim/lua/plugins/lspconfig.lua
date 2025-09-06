-- LSP
return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'saghen/blink.cmp' },
  },
  init = function()
    -- Reserve a space in the gutter
    -- This will avoid an annoying layout shift in the screen
    vim.opt.signcolumn = 'yes'
  end,
  config = function()
    -- if there is a language server active in the file
    vim.api.nvim_create_autocmd('LspAttach', {
      desc = 'LSP actions',
      callback = function(event)
        local opts = { buffer = event.buf }

        -- Hover
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        -- Code actions
        vim.keymap.set('n', '<leader>k', vim.lsp.buf.code_action, opts)
        -- View diagnostics
        vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
        -- Rename
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, opts)
      end,
    })

    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Swift Language Server
    vim.lsp.config('sourcekit', {
      cmd = { 'sourcekit-lsp' },
      file_types = { 'swift' },
      capabilities = capabilities,
    })

    vim.lsp.enable('sourcekit')

    -- Typescript Language Server
    vim.lsp.config('ts_ls', {
      cmd = { 'typescript-language-server', '--stdio' },
      capabilities = capabilities,
      file_types = { 'ts', 'tsx' },
      -- root_markers = lspconfig.util.root_pattern('tsconfig.json', 'package.json'),
      settings = {
        diagnostics = {
          -- Disable the JSDoc type hint
          ignoredCodes = { 80004 },
        },
      },
    })

    vim.lsp.enable('ts_ls')

    -- ESLint Language Server
    vim.lsp.config('eslint', {
      capabilities = capabilities,
    })

    vim.lsp.enable('eslint')

    -- Helm Language Server
    vim.lsp.config('helm_ls', {
      capabilities = capabilities,
    })

    vim.lsp.enable('helm_ls')

    -- Kotlin Language Server
    vim.lsp.config('kotlin_ls', {
      file_types = { 'kt' },
      capabilities = capabilities,
    })

    vim.lsp.enable('kotlin_ls')

    -- Lua Language Server
    -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
    vim.lsp.config('lua_ls', {
      capabilities = capabilities,
      cmd = { 'lua-language-server' },
    })

    vim.lsp.enable('lua_ls')
  end,
}

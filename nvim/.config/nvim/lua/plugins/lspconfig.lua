-- LSP
return {
  {
    'folke/lazydev.nvim',
    ft = 'lua', -- only load on lua files
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
      },
    },
  },
  {

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

      local util = require('lspconfig.util')

      -- Helper function to setup and enable a language server
      local setup_lsp = function(name, config)
        vim.lsp.config(name, config)
        vim.lsp.enable(name)
      end

      local get_mason_bin = function(bin) return vim.fn.stdpath('data') .. '/mason/bin/' .. bin end

      vim.lsp.config('*', {
        root_markers = { '.git' },
      })

      -- Swift Language Server
      setup_lsp('sourcekit', {
        cmd = { 'sourcekit-lsp' }, -- installed manually
        filetypes = { 'swift' },
        capabilities = capabilities,
      })

      -- Lua Language Server
      -- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#lua_ls
      setup_lsp('lua_ls', {
        cmd = { 'lua-language-server' }, -- installed with plugin
        filetypes = { 'lua' },
        capabilities = capabilities,
      })

      -- TypeScript Language Server
      setup_lsp('ts_ls', {
        cmd = { get_mason_bin('typescript-language-server'), '--stdio' },
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

      -- ESLint Language Server (for JavaScript and TypeScript)
      -- Manually installed via: `npm i -g vscode-langservers-extracted`
      local base_on_attach = vim.lsp.config.eslint.on_attach
      setup_lsp('eslint', {
        capabilities = capabilities,
        settings = {
          nodePath = vim.fn.getcwd() .. '/node_modules',
        },
        -- root_dir = vim.fs.root(0, {
        --   '.eslintrc',
        --   '.eslintrc.mjs',
        --   '.eslintrc.cjs',
        --   '.eslintrc.json',
        --   'eslint.config.mjs',
        --   'eslint.config.cjs',
        --   'eslint.config.js',
        -- }),
        on_attach = function(client, bufnr)
          if not base_on_attach then
            return
          end

          base_on_attach(client, bufnr)
          vim.api.nvim_create_autocmd('BufWritePre', {
            buffer = bufnr,
            command = 'LspEslintFixAll',
          })
        end,
      })

      -- Helm Language Server
      setup_lsp('helm_ls', {
        -- TODO: add cmd, filetypes etc
        capabilities = capabilities,
      })

      -- Kotlin Language Server
      setup_lsp('kotlin_ls', {
        cmd = { 'kotlin-language-server' },
        filetypes = { 'kotlin' },
        capabilities = capabilities,
      })
    end,
  },
}

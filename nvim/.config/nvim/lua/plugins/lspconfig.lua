-- LSP
return {
  'neovim/nvim-lspconfig',
  cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'saghen/blink.cmp' },
    -- { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
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
    local lspconfig = require('lspconfig')

    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'ts_ls', 'eslint' },
      handlers = {
        -- this first function is the "default handler"
        -- it applies to every language server without a "custom handler"
        function(server_name) lspconfig[server_name].setup({ capabilities = capabilities }) end,

        ---                 ---
        --- CUSTOM HANDLERS ---
        ---                 ---

        -- ESLINT
        eslint = function() lspconfig.eslint.setup({ capabilities = capabilities }) end,

        -- TYPESCRIPT
        ts_ls = function()
          print('Running TypeScript Language Server')
          lspconfig.ts_ls.setup({
            cmd = { 'typescript-language-server', '--stdio', '--' },
            capabilities = capabilities,
            root_dir = lspconfig.util.root_pattern('tsconfig.json', 'package.json'),
            settings = {
              diagnostics = {
                -- Disable the JSDoc type hint
                ignoredCodes = { 80004 }
              },
            },
          })
        end,

        -- HELM
        helm_ls = function()
          lspconfig.helm_ls.setup({
            capabilities = capabilities,
          })
        end,

        -- LUA
        lua_ls = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                telemetry = {
                  enable = false,
                },
              },
            },
            on_init = function(client)
              local join = vim.fs.joinpath
              local path = client.workspace_folders[1].name

              -- Don't do anything if there is project local config
              if vim.uv.fs_stat(join(path, '.luarc.json')) or vim.uv.fs_stat(join(path, '.luarc.jsonc')) then
                return
              end

              -- Apply neovim specific settings
              local runtime_path = vim.split(package.path, ';')
              table.insert(runtime_path, join('lua', '?.lua'))
              table.insert(runtime_path, join('lua', '?', 'init.lua'))

              local nvim_settings = {
                runtime = {
                  -- Tell the language server which version of Lua you're using
                  version = 'LuaJIT',
                  path = runtime_path,
                },
                diagnostics = {
                  -- Get the language server to recognize the `vim` global
                  globals = { 'vim' },
                },
                workspace = {
                  checkThirdParty = false,
                  library = {
                    -- Make the server aware of Neovim runtime files
                    vim.env.VIMRUNTIME,
                    vim.fn.stdpath('config'),
                  },
                },
              }

              client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, nvim_settings)
            end,
          })
        end,
      },
    })
  end,
}

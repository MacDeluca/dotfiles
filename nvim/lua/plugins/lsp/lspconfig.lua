return {
  'neovim/nvim-lspconfig',
  event = { 'VeryLazy' },
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    -- This is where all the LSP shenanigans will live
    local lsp_zero = require 'lsp-zero'
    lsp_zero.extend_lspconfig()

    lsp_zero.on_attach(function(client, bufnr)
      -- see :help lsp-zero-keybindings
      -- to learn the available actions
      --lsp_zero.default_keymaps({ buffer = bufnr })
      --local opts = { noremap = true, silent = true, buffer = bufnr }

      local map = function(keys, func, desc)
        vim.keymap.set('n', keys, func, { noremap = true, buffer = bufnr, silent = true, desc = 'LSP: ' .. desc })
      end
      -- Jump to the definition of the word under your cursor.
      --  This is where a variable was first declared, or where a function is defined, etc.
      --  To jump back, press <C-t>.
      map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      map(
        'gv',
        function() require('telescope.builtin').lsp_definitions { jump_type = 'vsplit' } end,
        '[G]oto Definition in [V]ertical Split'
      )
      map(
        'gx',
        function() require('telescope.builtin').lsp_definitions { jump_type = 'xsplit' } end,
        '[G]oto Definition in Horizontal Split'
      )

      -- Find references for the word under your cursor.
      map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

      -- Jump to the implementation of the word under your cursor.
      --  Useful when your language has ways of declaring types without an actual implementation.
      --map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      -- Jump to the type of the word under your cursor.
      --  Useful when you're not sure what type a variable is and you want to see
      --  the definition of its *type*, not where it was *defined*.
      map('T', require('telescope.builtin').lsp_type_definitions, '[T]ype definition')

      -- Fuzzy find all the symbols in your current document.
      --  Symbols are things like variables, functions, types, etc.
      map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

      -- Fuzzy find all the symbols in your current workspace
      --  Similar to document symbols, except searches over your whole project.
      --map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

      -- Rename the variable under your cursor
      --  Most Language Servers support renaming across files, etc.
      map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

      -- Execute a code action, usually your cursor needs to be on top of an error
      -- or a suggestion from your LSP for this to activate.
      map('<leader>k', vim.lsp.buf.code_action, '[C]ode [A]ction')

      -- Opens a popup that displays documentation about the word under your cursor
      --  See `:help K` for why this keymap
      map('K', vim.lsp.buf.hover, 'Hover Documentation')

      map('<leader>vd', function() vim.diagnostic.open_float() end, '[V]iew [D]iagnostics')
    end)

    require('mason-lspconfig').setup {
      ensure_installed = { 'tsserver', 'lua_ls' },
      handlers = {
        lsp_zero.default_setup,
        lua_ls = function()
          -- (Optional) Configure lua language server for neovim
          --local lua_opts = lsp_zero.nvim_lua_ls()
          require('lspconfig').lua_ls.setup {
            settings = {
              Lua = {
                runtime = { version = 'LuaJIT' },
                workspace = {
                  checkThirdParty = false,
                  -- Tells lua_ls where to find all the Lua files that you have loaded
                  -- for your neovim configuration.
                  library = {
                    '${3rd}/luv/library',
                    unpack(vim.api.nvim_get_runtime_file('', true)),
                  },
                  -- If lua_ls is really slow on your computer, you can try this instead:
                  -- library = { vim.env.VIMRUNTIME },
                },
                completion = {
                  callSnippet = 'Replace',
                },
                -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                -- diagnostics = { disable = { 'missing-fields' } },
              },
            },
          }
        end,
        tsserver = function()
          local lspconfig = require 'lspconfig'
          lspconfig.tsserver.setup {
            cmd = { 'typescript-language-server', '--stdio' },
            root_dir = lspconfig.util.root_pattern '.git',
            settings = {
              -- Disable the JSDoc type hint
              diagnostics = { ignoredCodes = { 80004 } },
            },
          }
        end,
      },
    }
  end,
}

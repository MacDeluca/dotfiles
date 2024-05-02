return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/cmp-path' },
    { 'saadparwaiz1/cmp_luasnip' },
    {
      'L3MON4D3/LuaSnip',
      config = function()
        require('luasnip.loaders.from_snipmate').lazy_load()
        require('luasnip').filetype_extend('typescriptreact', { 'typescript' })
      end,
    },
  },
  config = function()
    -- Here is where you configure the autocompletion settings.
    local lsp_zero = require 'lsp-zero'

    lsp_zero.extend_cmp()

    -- And you can configure cmp even more, if you want to.

    local cmp = require 'cmp'
    local cmp_action = lsp_zero.cmp_action()

    cmp.setup {
      formatting = lsp_zero.cmp_format(),
      snippet = {
        expand = function(args) require('luasnip').lsp_expand(args.body) end,
      },
      experimental = {
        ghost_text = true,
      },
      mapping = cmp.mapping.preset.insert {
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<C-k>'] = cmp.mapping.select_prev_item(), -- previous suggestion
        ['<C-j>'] = cmp.mapping.select_next_item(), -- next suggestion
        ['<C-l>'] = cmp_action.luasnip_jump_forward(),
        ['<C-h>'] = cmp_action.luasnip_jump_backward(),
      },
      sources = cmp.config.sources {
        { name = 'luasnip' },
        { name = 'nvim_lsp' },
        { name = 'buffer' },
        { name = 'path' },
      },
    }
  end,
}

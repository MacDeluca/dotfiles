return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
    keymap = { preset = 'enter' },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    cmdline = { enabled = false },
    -- sources = {
    --   min_keyword_length = function(ctx)
    --     -- only applies when typing a command, doesn't apply to arguments
    --     if ctx.mode == 'cmdline' and string.find(ctx.line, ' ') == nil then
    --       return 3
    --     end
    --     return 0
    --   end,
    -- },
    completion = {
      menu = {
        border = 'single',
      },
      documentation = { window = { border = 'single' } },
    },
    signature = { window = { border = 'single' } },
  },
}

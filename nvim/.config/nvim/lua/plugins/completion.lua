return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  event = 'InsertEnter',
  opts = {
    sources = {
      default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        lazydev = {
          name = 'LazyDev',
          module = 'lazydev.integrations.blink',
          -- make lazydev completions top priority (see `:h blink.cmp`)
          score_offset = 100,
        },
      },
    },
    keymap = {
      preset = 'enter',
    },
    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },
    cmdline = {
      enabled = false,
    },
    completion = {
      menu = {
        -- border = 'rounded',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 750,
        window = {
          -- border = 'rounded',
        },
      },
    },
    signature = {
      enabled = false,
      -- window = {
      --   show_documentation = false,
      --   max_height = 1,
      --   -- border = 'rounded',
      -- },
    },
  },
}

-- TODO: Add completion for vim-dadbod / check if working already
return {
  'saghen/blink.cmp',
  dependencies = 'rafamadriz/friendly-snippets',
  version = '*',
  opts = {
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
        border = 'single',
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 1000,
        window = {
          border = 'single',
        },
      },
    },
    signature = {
      enabled = true,
      window = {
        border = 'single',
      },
    },
  },
}

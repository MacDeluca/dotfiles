return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      transparent_background = true,
      custom_highlights = function(colours)
        return {
          -- blink higlights
          BlinkCmpMenu = { bg = colours.surface0 },
          BlinkCmpDoc = { bg = colours.mantle },
          -- Maybe not needed (currently disabled)
          -- BlinkCmpSignatureHelp = { bg = colours.surface0 },
          --
          -- statusline highlights
          StatusLine = { bg = colours.surface0 },
          StatusBranch = { fg = colours.green },
          StatusLineNormal = { fg = colours.blue },
          StatusLineInsert = { fg = colours.green },
          StatusLineVisual = { fg = colours.mauve },
          -- -- StatusFile = { fg = colours.mauve },
          StatusError = { fg = colours.red },
        }
      end,
      integrations = {
        treesitter = true,
        blink_cmp = true,
        snacks = { enabled = true },
        mason = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { 'italic' },
            hints = { 'italic' },
            warnings = { 'italic' },
            information = { 'italic' },
            ok = { 'italic' },
          },
          underlines = {
            errors = { 'underline' },
            hints = { 'underline' },
            warnings = { 'underline' },
            information = { 'underline' },

            ok = { 'underline' },
          },
          inlay_hints = {
            background = true,
          },
        },
      },
    })

    vim.cmd.colorscheme('catppuccin')
  end,
}

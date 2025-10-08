return {
  'catppuccin/nvim',
  name = 'catppuccin',
  commit = '931a129463ca09c8805d564a28b3d0090e536e1d',
  priority = 1000,
  lazy = false,
  config = function()
    require('catppuccin').setup({
      flavour = 'mocha',
      -- transparent_background = false,
      float = {
        transparent = true,
      },
      custom_highlights = function(colours)
        return {
          WinSeparator = { fg = colours.blue },
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
          StatusLineCommand = { fg = colours.yellow },
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

return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  opts = {
    transparent_background = true,
    custom_highlights = function(colours)
      return {
        -- --TelescopeMatching = { fg = colours.green },
        -- -- This disables the cursorline highlight when using telescope
        -- CursorLine = { bg = colours.none },
        FloatBorder = { fg = colours.grey },
      }
    end,
  },
  init = function() vim.cmd.colorscheme('catppuccin') end,
}

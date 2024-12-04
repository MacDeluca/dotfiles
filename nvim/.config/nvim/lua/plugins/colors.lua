return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  lazy = false,
  opts = {
    custom_highlights = function(colours)
      return {
        TelescopeMatching = { fg = colours.green },
        -- This disables the cursorline highlight when using telescope
        CursorLine = { bg = colours.none },
      }
    end,
  },
  init = function()
    vim.cmd.colorscheme('catppuccin')
    vim.api.nvim_set_hl(0, 'NormalFloat', { bg = 'none' })
  end,
}

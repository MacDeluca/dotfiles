-- To start auth workflow run:
-- :Copilot auth
return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  enabled = true,
  config = function()
    require('copilot').setup({
      copilot_node_command = vim.fn.expand('$HOME') .. '/.nvm/versions/node/v22.19.0/bin/node',
      suggestion = {
        enabled = true,
        auto_trigger = true,
        debounce = 25,
        keymap = {
          accept = '<C-Y>',
          next = '<C-N>',
          prev = '<C-P>',
        },
      },
      filetypes = {
        yaml = true,
        markdown = true,
      },
    })
  end,
}

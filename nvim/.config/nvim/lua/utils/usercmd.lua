local user_cmd = vim.api.nvim_create_user_command

user_cmd('Vimconfig', function() vim.cmd('vs ~/.config/nvim/lua/plugins/init.lua') end, { bang = true })

user_cmd('MergeStart', function()
  vim.cmd(':FocusDisable')
  vim.cmd(':Git mergetool')
  vim.cmd(':Gvdiffsplit!')
  ----
end, {})

user_cmd('MergeEnd', function() vim.cmd(':FocusEnable') end, {})

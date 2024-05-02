local user_cmd = vim.api.nvim_create_user_command

user_cmd('Vimconfig', function() vim.cmd 'vs ~/.config/nvim/lua/plugins/init.lua' end, { bang = true })

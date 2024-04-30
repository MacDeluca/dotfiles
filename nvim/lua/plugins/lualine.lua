--This removes the duplicated --INSERT-- status
vim.opt.showmode = false
local gstatus = { ahead = 0, behind = 0 }
local function update_gstatus()
  local Job = require 'plenary.job'

  Job:new({
    command = 'git',
    args = { 'rev-list', '--left-right', '--count', 'HEAD...@{upstream}' },

    on_exit = function(job, _)
      local res = job:result()[1]
      if type(res) ~= 'string' then
        gstatus = { ahead = 0, behind = 0 }
        return
      end
      local ok, ahead, behind = pcall(string.match, res, '(%d+)%s*(%d+)')
      if not ok then
        ahead, behind = 0, 0
      end
      gstatus = { ahead = ahead, behind = behind }
    end,
  }):start()
end

if _G.Gstatus_timer == nil then
  _G.Gstatus_timer = vim.loop.new_timer()
else
  _G.Gstatus_timer:stop()
end
_G.Gstatus_timer:start(0, 2000, vim.schedule_wrap(update_gstatus))

return {
  'nvim-lualine/lualine.nvim',
  --dependencies = { { 'nvim-tree/nvim-web-devicons', opt = true } },
  enabled = true,
  opts = {
    options = {
      icons_enabled = true,
      section_separators = { left = '', right = '' },
      component_separators = { left = '|', right = '|' },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = {
        'FugitiveHead',
        'diff',
        function() return gstatus.ahead .. ' ' .. gstatus.behind .. '' end,
      },
      lualine_x = { 'filetype' },
    },
    inactive_sections = {},
    extensions = { 'fugitive' },
  },
}

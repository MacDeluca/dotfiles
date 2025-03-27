local nvim_modes = {
  ['n'] = 'NORMAL',
  ['no'] = 'NORMAL',
  ['v'] = 'VISUAL',
  ['V'] = 'VISUAL LINE',
  [''] = 'VISUAL BLOCK',
  ['s'] = 'SELECT',
  ['S'] = 'SELECT LINE',
  [''] = 'SELECT BLOCK',
  ['i'] = 'INSERT',
  ['ic'] = 'INSERT',
  ['R'] = 'REPLACE',
  ['Rv'] = 'VISUAL REPLACE',
  ['c'] = 'COMMAND',
  ['cv'] = 'VIM EX',
  ['ce'] = 'EX',
  ['r'] = 'PROMPT',
  ['rm'] = 'MOAR',
  ['r?'] = 'CONFIRM',
  ['!'] = 'SHELL',
  ['t'] = 'TERMINAL',
}

-- Get the current mode
local function mode()
  local current_mode = nvim_modes[vim.api.nvim_get_mode().mode]:upper()

  return current_mode
end

-- Get the current git branch info
local function git()
  local branch = vim.fn.FugitiveHead()

  -- If there is no branch, return nothing
  if not branch or #branch == 0 then
    return ''
  end

  return ' ' .. branch
end

-- Get the current file info
local function file()
  -- If the file is readonly, display a lock icon
  if vim.bo.readonly then
    return '%t '
  end

  return '%t %m'
end

-- Get the current file's diagnostic info
local function diagnostic()
  local errors = #vim.diagnostic.get(vim.api.nvim_get_current_buf(), { severity = 'ERROR' })

  if errors == 0 then
    return ''
  end

  return ' ' .. errors
end

-- Get the current line and column info
local function line() return '%= %l:%c ' end

local function inject_hl(hl_group, text) return '%#' .. hl_group .. '#' .. text .. '%#StatusLine#' end

-- Configure the statusline components
function StatusLine()
  return table.concat({
    '│',
    mode(),
    '│',
    inject_hl('StatusBranch', git()),
    '│',
    file(),
    inject_hl('StatusError', diagnostic()),
    line(),
  }, ' ')
end

vim.opt.statusline = [[%!luaeval('StatusLine()')]]

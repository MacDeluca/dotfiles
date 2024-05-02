local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

autocmd('TextYankPost', {
  group = augroup('HighlightYankGroup', { clear = true }),
  desc = 'quickly highlights yanked text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank {
      higroup = 'IncSearch',
      timeout = 50,
    }
  end,
})

autocmd({ 'BufWritePre' }, {
  group = augroup('StripWhiteSpaceGroup', { clear = true }),
  pattern = '*',
  command = [[%s/\s\+$//e]],
})

autocmd({ 'InsertEnter' }, {
  group = augroup('InsertEnter', { clear = true }),
  pattern = '*',
  command = 'silent! normal! ma',
})

autocmd({ 'BufWinEnter' }, {
  group = augroup('BetterYankPositionGroup', { clear = true }),
  desc = 'return cursor to where it was last time closing the file',
  pattern = '*',
  command = 'silent! normal! g`"zv zz',
})

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

-- Highlights yanked text for a short period of time
autocmd('TextYankPost', {
  group = augroup('HighlightYankGroup', { clear = true }),
  desc = 'quickly highlights yanked text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})

-- Strip whitespace on save
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

-- Set commentstring for sql files
autocmd({ 'FileType' }, {
  group = augroup('SQLCommentString', { clear = true }),
  pattern = 'sql',
  callback = function(event) vim.bo[event.buf].commentstring = '-- %s' end,
})

-- Split help buffers to the right
autocmd('FileType', {
  desc = 'Automatically Split help Buffers to the right',
  pattern = 'help',
  command = 'wincmd L',
})

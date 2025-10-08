-- Highlights yanked text for a short period of time
vim.api.nvim_create_autocmd('TextYankPost', {
  group = vim.api.nvim_create_augroup('HighlightYankGroup', { clear = true }),
  desc = 'quickly highlights yanked text',
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 50,
    })
  end,
})
-- -- Strip whitespace on save
-- autocmd({ 'BufWritePre' }, {
--   group = augroup('StripWhiteSpaceGroup', { clear = true }),
--   pattern = '*',
--   command = [[%s/\s\+$//e]],
-- })
--
-- autocmd({ 'InsertEnter' }, {
--   group = augroup('InsertEnter', { clear = true }),
--   pattern = '*',
--   command = 'silent! normal! ma',
-- })

-- -- Set commentstring for sql files
-- autocmd({ 'FileType' }, {
--   group = augroup('SQLCommentString', { clear = true }),
--   pattern = 'sql',
--   callback = function(event) vim.bo[event.buf].commentstring = '-- %s' end,
-- })

-- Split help buffers to the right
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Automatically Split help Buffers to the right',
  pattern = 'help',
  command = 'wincmd L',
})

for i = 1, 5 do
  vim.api.nvim_create_user_command('L' .. i, function(opts)
    -- local tmux_pane = table.remove(opts.fargs, 1)
    local tmux_command = table.concat(opts.fargs, ' ')
    vim.fn.system(string.format("tmux send-keys -t %s '%s' Enter", i, tmux_command))
  end, { nargs = '*' })
end

vim.api.nvim_create_user_command('L', function(opts)
  local tmux_pane = table.remove(opts.fargs, 1)
  local tmux_command = table.concat(opts.fargs, ' ')
  vim.fn.system(string.format("tmux send-keys -t %s '%s' Enter", tmux_pane, tmux_command))
end, { nargs = '*' })

-- vim.api.nvim_create_autocmd({ 'BufLeave', 'WinLeave' }, {
--   callback = function()
--     vim.lsp.
--     vim.lsp.util.close_floating_preview() end,
-- })

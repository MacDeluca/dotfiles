local notes = {}

-- sets the default text for the new note file
notes.set_note_text = function()
  local format_date = os.date '%A, %m %B %Y'
  local note_text = { '# Daily Note', format_date, '---', '', '## Todos', '' }
  vim.api.nvim_buf_set_lines(0, 0, 0, false, note_text)
end

-- creates a new buffer with the defualt note header text
notes.new_note = function()
  local route = '~/notes/'
  local dt = os.date '*t'
  local file_name = route .. dt.day .. '-' .. dt.month .. '-' .. dt.year .. '.md'
  local is_new_note = vim.fn.filereadable(vim.fn.expand(file_name)) == 0
  vim.cmd('vs ' .. file_name)
  if is_new_note then
    notes.set_note_text()
  end
end

notes.open_scratch = function() vim.cmd 'vs ~/notes/scratch.md' end

vim.keymap.set('n', '<leader>dn', function() notes.new_note() end, { desc = '[d]aily [n]ote' })

vim.keymap.set('n', '<leader>n', function() notes.open_scratch() end, { desc = '[n]ote' })

return notes

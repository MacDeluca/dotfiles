local helpers = {}

helpers.create_temp_buffer = function(bufr_fn, filetype)
  vim.cmd 'vnew'
  vim.cmd 'set buftype=nofile'
  vim.cmd 'set bufhidden=delete'
  if filetype ~= nil then
    vim.cmd('set filetype=' .. filetype)
  end
  if bufr_fn ~= nil then
    bufr_fn()
  end
end

helpers.curl_to_temp_buffer = function(curl, filetype)
  local temp_buffer_callback = function() vim.cmd('read !' .. curl) end
  helpers.create_temp_buffer(temp_buffer_callback, filetype)
end

helpers.print_table = function(_table) print(table.concat(_table, ', ')) end

helpers.get_word_under_cursor = function() return vim.fn.expand '<cword>' end

return helpers

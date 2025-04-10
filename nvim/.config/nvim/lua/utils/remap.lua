--closes all other windows
vim.keymap.set('n', '<leader>o', '<C-w>o', { desc = 'close [o]ther windows' })

--moves selected text
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'move selected text down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'move selected text up' })

--on yank keeps the cursor position
vim.keymap.set('v', 'y', 'ygv<Esc>', { desc = 'better cusor position on yank' })

--down/up half page and centers cursor
vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')

--search and replace word in file
vim.keymap.set('n', '<leader>r', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- search and replace word in quickfix list
vim.keymap.set(
  'n',
  '<leader>rq',
  [[:cdo s/\<<C-r><C-w>\>/<C-r><C-w>/gI | update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>]]
)

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.get_next, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.get_prev, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', function()
  vim.diagnostic.reset()
  vim.Cmd('LspRestart')
end, { desc = '[D]iagnostic [R]eset' })

--traverse found searches up / down
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')

vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<Space>', '<Nop>', { silent = true })

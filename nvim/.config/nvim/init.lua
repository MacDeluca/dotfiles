vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.termguicolors = true

require('utils.statusline')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
  -- { import = 'plugins.lsp' },
}, {
  dev = {
    path = '~/nvim_plugins',
  },
  disabled_plugins = {
    'netrwPlugin',
  },
})

require('utils.set')
require('utils.remap')
require('utils.autocmd')

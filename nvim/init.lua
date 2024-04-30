vim.g.mapleader = ' '
vim.o.termguicolors = true

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
  { import = 'plugins' },
  { import = 'plugins.lsp' },
}, {
  dev = {
    path = '~/nvim_plugins',
  },
  disabled_plugins = {
    'netrwPlugin',
  },
})

require 'utils.set'
require 'utils.remap'
require 'utils.autocmd'
require 'utils.usercmd'
require 'utils.helpers'
require 'custom-plugins.notes'

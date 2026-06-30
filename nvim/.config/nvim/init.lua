-- Leader
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Core config
require('config.options')
require('config.keymaps')
require('config.filetype')
require('config.folds')
require('config.autocmds')
require('config.commands')

local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    'git', 'clone', '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({ import = 'plugins' }, {
  change_detection = { notify = false },
  ui = { border = 'rounded' },
})

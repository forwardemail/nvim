--[[
  Modern Neovim Configuration
  Migrated from classic Vim setup with Pathogen

  Features:
  - lazy.nvim plugin manager with lazy loading
  - Smart autoformatter with config detection
  - Modern LSP, completion, and treesitter
  - 1:1 feature parity with original Vim config

  Structure:
  - lua/config/    - Core configuration (options, keymaps, autocmds)
  - lua/plugins/   - Plugin specifications for lazy.nvim
  - lua/utils/     - Utility functions
  - tests/         - Automated tests
]]

-- Set leader key BEFORE loading plugins
-- Leader: comma (,)
vim.g.mapleader = ','
vim.g.maplocalleader = ','

-- Bootstrap lazy.nvim plugin manager
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Add current config directory to runtimepath
local config_path = vim.fn.stdpath('config')
vim.opt.rtp:prepend(config_path)

-- Load core configuration
require('config.options')
require('config.keymaps')
require('config.autocmds')

-- Load plugins with lazy.nvim
require('lazy').setup('plugins', {
  defaults = {
    lazy = true, -- Lazy load by default
  },
  install = {
    colorscheme = { 'ir_black' },
  },
  checker = {
    enabled = true, -- Check for plugin updates
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        'gzip',
        'matchit',
        'matchparen',
        'netrwPlugin',
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})

-- Load project-specific config (if exists)
-- Uses vim.secure for security (similar to original 'set secure')
local project_config = vim.fn.findfile('.nvim.lua', '.;')
if project_config ~= '' then
  vim.secure.read(project_config)
end

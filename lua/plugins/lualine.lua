--[[
  Lualine - Status Line
  
  Replaces vim-powerline with modern Lua status line
]]

return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = { 'dashboard', 'alpha', 'starter' },
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'diff', 'diagnostics' },
      lualine_c = {
        {
          'filename',
          path = 1, -- Relative path
          symbols = {
            modified = ' ●',
            readonly = ' ',
            unnamed = '[No Name]',
          },
        },
      },
      lualine_x = {
        {
          'encoding',
          cond = function()
            return vim.opt.encoding:get() ~= 'utf-8'
          end,
        },
        'fileformat',
        'filetype',
      },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { 'neo-tree', 'lazy', 'mason', 'quickfix' },
  },
}

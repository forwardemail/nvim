--[[
  Colorscheme

  Using IR Black theme (pure black background)
]]

return {
  -- IR Black is loaded from colors/ir_black.lua
  -- No plugin needed, just set the colorscheme
  {
    'folke/tokyonight.nvim',
    enabled = false, -- Disable tokyonight
  },
  {
    'nvim-treesitter/nvim-treesitter',
    optional = true,
    opts = function()
      -- Load IR Black colorscheme after treesitter
      vim.cmd('colorscheme ir_black')
    end,
  },
}

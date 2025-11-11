--[[
  Colorscheme
  
  Replaces vim-irblack with modern dark theme
  Using tokyonight-night for terminal (similar to ir_black aesthetic)
]]

return {
  'folke/tokyonight.nvim',
  lazy = false, -- Load immediately
  priority = 1000, -- Load before other plugins
  opts = {
    style = 'night', -- night, storm, day, moon
    transparent = false,
    terminal_colors = true,
    styles = {
      comments = { italic = true },
      keywords = { italic = true },
      functions = {},
      variables = {},
      sidebars = 'dark',
      floats = 'dark',
    },
    sidebars = { 'qf', 'help', 'terminal', 'packer' },
    day_brightness = 0.3,
    hide_inactive_statusline = false,
    dim_inactive = false,
    lualine_bold = false,
    on_colors = function(colors)
      -- Customize colors to be closer to ir_black if desired
    end,
    on_highlights = function(highlights, colors)
      -- Customize highlights
    end,
  },
  config = function(_, opts)
    require('tokyonight').setup(opts)
    vim.cmd('colorscheme tokyonight-night')
  end,
}

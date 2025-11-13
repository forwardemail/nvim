--[[
  Telescope - Fuzzy Finder

  Modern addition (not in original config)
  Provides powerful fuzzy finding for files, grep, buffers, etc.
]]

return {
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  version = false,
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable('make') == 1
      end,
    },
  },
  keys = {
    { '<leader>ff', '<cmd>Telescope find_files<cr>', desc = 'Find files' },
    { '<leader>fg', '<cmd>Telescope live_grep<cr>', desc = 'Live grep' },
    { '<leader>fb', '<cmd>Telescope buffers<cr>', desc = 'Find buffers' },
    { '<leader>fh', '<cmd>Telescope help_tags<cr>', desc = 'Help tags' },
    { '<leader>fr', '<cmd>Telescope oldfiles<cr>', desc = 'Recent files' },
    { '<leader>fc', '<cmd>Telescope commands<cr>', desc = 'Commands' },
    { '<leader>fk', '<cmd>Telescope keymaps<cr>', desc = 'Keymaps' },
  },
  opts = {
    defaults = {
      prompt_prefix = ' ',
      selection_caret = ' ',
      path_display = { 'truncate' },
      sorting_strategy = 'ascending',
      layout_config = {
        horizontal = {
          prompt_position = 'top',
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      mappings = {
        i = {
          ['<C-n>'] = 'move_selection_next',
          ['<C-p>'] = 'move_selection_previous',
          ['<C-c>'] = 'close',
          ['<C-j>'] = 'move_selection_next',
          ['<C-k>'] = 'move_selection_previous',
          ['<C-q>'] = 'send_to_qflist',
          ['<C-l>'] = 'complete_tag',
          ['<C-_>'] = 'which_key',
        },
        n = {
          ['<esc>'] = 'close',
          ['<CR>'] = 'select_default',
          ['<C-x>'] = 'select_horizontal',
          ['<C-v>'] = 'select_vertical',
          ['<C-t>'] = 'select_tab',
          ['<C-q>'] = 'send_to_qflist',
          ['j'] = 'move_selection_next',
          ['k'] = 'move_selection_previous',
          ['H'] = 'move_to_top',
          ['M'] = 'move_to_middle',
          ['L'] = 'move_to_bottom',
          ['gg'] = 'move_to_top',
          ['G'] = 'move_to_bottom',
          ['<C-u>'] = 'preview_scrolling_up',
          ['<C-d>'] = 'preview_scrolling_down',
          ['?'] = 'which_key',
        },
      },
    },
    pickers = {
      find_files = {
        find_command = { 'rg', '--files', '--hidden', '--glob', '!**/.git/*' },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = 'smart_case',
      },
    },
  },
  config = function(_, opts)
    local telescope = require('telescope')
    telescope.setup(opts)
    telescope.load_extension('fzf')
  end,
}

--[[
  Miscellaneous Plugins

  Collection of smaller plugins that don't need dedicated files
]]

return {
  -- vim-surround replacement (Lua version)
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  -- vim-repeat (still works as-is)
  {
    'tpope/vim-repeat',
    event = 'VeryLazy',
  },

  -- vim-unimpaired (still works, provides bracket mappings and line bubbling)
  {
    'tpope/vim-unimpaired',
    event = 'VeryLazy',
  },

  -- Comment.nvim (replaces tcomment_vim)
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {
      padding = true,
      sticky = true,
      ignore = nil,
      toggler = {
        line = 'gcc',
        block = 'gbc',
      },
      opleader = {
        line = 'gc',
        block = 'gb',
      },
      extra = {
        above = 'gcO',
        below = 'gco',
        eol = 'gcA',
      },
      mappings = {
        basic = true,
        extra = true,
      },
    },
  },

  -- EditorConfig support
  {
    'editorconfig/editorconfig-vim',
    event = 'VeryLazy',
  },

  -- vim-pasta (context-aware pasting)
  {
    'sickill/vim-pasta',
    event = 'VeryLazy',
  },

  -- vim-ragtag (HTML/XML tag helpers)
  {
    'tpope/vim-ragtag',
    ft = { 'html', 'xml', 'jsx', 'tsx' },
  },

  -- vim-fetch (open files with line numbers)
  {
    'wsdjeg/vim-fetch',
    event = 'VeryLazy',
  },

  -- Tabular (text alignment)
  {
    'godlygeek/tabular',
    cmd = 'Tabularize',
  },

  -- Auto-pairs (auto-close brackets)
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      check_ts = true,
      ts_config = {
        lua = { 'string' },
        javascript = { 'template_string' },
      },
      disable_filetype = { 'TelescopePrompt', 'vim' },
      fast_wrap = {
        map = '<M-e>',
        chars = { '{', '[', '(', '"', "'" },
        pattern = [=[[%'%"%>%]%)%}%,]]=],
        end_key = '$',
        keys = 'qwertyuiopzxcvbnmasdfghjkl',
        check_comma = true,
        highlight = 'Search',
        highlight_grey = 'Comment',
      },
    },
  },

  -- Indent guides
  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
        tab_char = '│',
      },
      scope = { enabled = false },
      exclude = {
        filetypes = {
          'help',
          'alpha',
          'dashboard',
          'neo-tree',
          'Trouble',
          'trouble',
          'lazy',
          'mason',
          'notify',
          'toggleterm',
          'lazyterm',
        },
      },
    },
  },

  -- Which-key (key binding helper)
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      preset = 'classic',
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 20,
        },
        presets = {
          operators = true,
          motions = true,
          text_objects = true,
          windows = true,
          nav = true,
          z = true,
          g = true,
        },
      },
      win = {
        border = 'rounded',
        padding = { 1, 2 },
      },
      layout = {
        width = { min = 20 },
        spacing = 3,
      },
      -- Use spec for v3 API instead of register
      spec = {
        { '<leader>f', group = 'find/format' },
        { '<leader>s', group = 'spell' },
        { '<leader>b', group = 'buffer' },
        { '<leader>h', group = 'git' },
      },
    },
  },

  -- Markdown preview (replaces vim-livedown)
  {
    'iamcco/markdown-preview.nvim',
    cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
    ft = { 'markdown' },
    build = 'cd app && npx --yes yarn install',
    keys = {
      { 'gm', ':MarkdownPreview<CR>', desc = 'Markdown preview' },
    },
    config = function()
      vim.g.mkdp_port = '8337' -- Same as original livedown config
      vim.g.mkdp_auto_close = 0
    end,
  },


}

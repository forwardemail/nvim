--[[
  LSP Configuration
  
  Uses native Neovim 0.11+ vim.lsp.config API
  No longer requires nvim-lspconfig plugin
  
  NOTE: For XO and Prettier projects:
  - ESLint LSP is enabled below and will work with XO (XO uses ESLint under the hood)
  - Prettier formatting is handled by conform.nvim (see lua/plugins/conform.lua)
  - TypeScript LSP is DISABLED by default (ts_ls is commented out)
]]

return {
  -- Mason (LSP/formatter/linter installer)
  {
    'williamboman/mason.nvim',
    cmd = 'Mason',
    build = ':MasonUpdate',
    opts = {
      ensure_installed = {
        -- LSP servers
        'lua-language-server',
        -- 'typescript-language-server', -- DISABLED: Not needed for JavaScript-only projects
        'eslint-lsp', -- Works with XO (XO uses ESLint)
        'pyright',
        'bash-language-server',
        'json-lsp',
        'yaml-language-server',
        'html-lsp',
        'css-lsp',
        -- Formatters
        'stylua',
        'prettier', -- Used by conform.nvim for formatting
        -- Linters
        'eslint_d', -- Works with XO
        'shellcheck',
      },
      ui = {
        border = 'rounded',
        icons = {
          package_installed = '✓',
          package_pending = '➜',
          package_uninstalled = '✗',
        },
      },
    },
    config = function(_, opts)
      require('mason').setup(opts)
      local mr = require('mason-registry')
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then
            p:install()
          end
        end
      end
      if mr.refresh then
        mr.refresh(ensure_installed)
      else
        ensure_installed()
      end
    end,
  },

  -- Native LSP configuration (Neovim 0.11+)
  {
    'neovim/nvim-lspconfig',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'mason.nvim',
    },
    config = function()
      -- Setup diagnostics
      vim.diagnostic.config({
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 4,
          source = 'if_many',
          prefix = '●',
        },
        severity_sort = true,
      })

      -- LSP attach callback
      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('UserLspConfig', {}),
        callback = function(ev)
          local bufnr = ev.buf
          local client = vim.lsp.get_client_by_id(ev.data.client_id)

          -- Enable completion
          vim.bo[bufnr].omnifunc = 'v:lua.vim.lsp.omnifunc'

          -- LSP keymaps
          local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
          end

          -- Navigation
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to declaration')
          map('n', 'gd', vim.lsp.buf.definition, 'Go to definition')
          map('n', 'K', vim.lsp.buf.hover, 'Hover documentation')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to implementation')
          map('n', '<C-k>', vim.lsp.buf.signature_help, 'Signature help')
          map('n', 'gr', vim.lsp.buf.references, 'References')
          
          -- Workspace
          map('n', '<leader>wa', vim.lsp.buf.add_workspace_folder, 'Add workspace folder')
          map('n', '<leader>wr', vim.lsp.buf.remove_workspace_folder, 'Remove workspace folder')
          map('n', '<leader>wl', function()
            print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
          end, 'List workspace folders')
          
          -- Code actions
          map('n', '<leader>D', vim.lsp.buf.type_definition, 'Type definition')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename')
          map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code action')
          
          -- Diagnostics
          map('n', '<leader>d', vim.diagnostic.open_float, 'Show diagnostic')
          map('n', '[d', vim.diagnostic.goto_prev, 'Previous diagnostic')
          map('n', ']d', vim.diagnostic.goto_next, 'Next diagnostic')
          map('n', '<leader>dl', vim.diagnostic.setloclist, 'Diagnostic list')
        end,
      })

      -- Get capabilities from nvim-cmp
      local has_cmp, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
      local capabilities = has_cmp and cmp_nvim_lsp.default_capabilities() or {}

      -- LSP server configurations
      local servers = {
        {
          'lua_ls',
          {
            settings = {
              Lua = {
                workspace = {
                  checkThirdParty = false,
                },
                codeLens = {
                  enable = true,
                },
                completion = {
                  callSnippet = 'Replace',
                },
                diagnostics = {
                  globals = { 'vim' },
                },
              },
            },
          },
        },
        -- TypeScript LSP is DISABLED - uncomment the line below to enable it
        -- { 'ts_ls' },
        { 'eslint' }, -- Works with XO (XO uses ESLint under the hood)
        { 'pyright' },
        { 'bashls' },
        { 'jsonls' },
        { 'yamlls' },
        { 'html' },
        { 'cssls' },
      }

      -- Explicitly prevent TypeScript LSP from auto-starting
      -- This stops ts_ls even if it's installed via Mason
      vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        callback = function()
          -- Stop ts_ls if it tries to attach
          vim.schedule(function()
            for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
              if client.name == 'ts_ls' or client.name == 'tsserver' then
                vim.lsp.stop_client(client.id)
              end
            end
          end)
        end,
      })
      
      -- Configure and enable each server using native API
      for _, server in ipairs(servers) do
        local name = server[1]
        local config = server[2] or {}
        
        -- Add capabilities to config
        config.capabilities = capabilities
        
        -- Use vim.lsp.config for configuration (if config exists)
        if next(config) ~= nil then
          vim.lsp.config(name, config)
        end
        
        -- Enable the server
        vim.lsp.enable(name)
      end
    end,
  },

  -- Completion engine
  {
    'hrsh7th/nvim-cmp',
    version = false,
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    },
    opts = function()
      local cmp = require('cmp')
      local luasnip = require('luasnip')

      return {
        completion = {
          completeopt = 'menu,menuone,noinsert',
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-n>'] = cmp.mapping.select_next_item(),
          ['<C-p>'] = cmp.mapping.select_prev_item(),
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'path' },
        }, {
          { name = 'buffer' },
        }),
        formatting = {
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = '[LSP]',
              luasnip = '[Snippet]',
              buffer = '[Buffer]',
              path = '[Path]',
            })[entry.source.name]
            return vim_item
          end,
        },
        experimental = {
          ghost_text = true,
        },
      }
    end,
  },
}

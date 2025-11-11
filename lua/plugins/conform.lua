--[[
  Conform.nvim - Smart Formatter
  
  Simplified configuration that avoids ERR_MODULE_NOT_FOUND errors
  Uses only built-in formatters (prettier, stylua, black, etc.)
  
  Features:
  - Format on save with timeout
  - :Autoformat command for manual formatting
  - Trim trailing whitespace
]]

return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo', 'Autoformat' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format({ async = true, lsp_format = 'fallback' })
      end,
      mode = '',
      desc = 'Format buffer',
    },
  },
  config = function()
    local conform = require('conform')
    
    conform.setup({
      -- Formatters by filetype
      formatters_by_ft = {
        -- JavaScript/TypeScript - prettier only (built-in, always works)
        javascript = { 'prettier' },
        typescript = { 'prettier' },
        javascriptreact = { 'prettier' },
        typescriptreact = { 'prettier' },
        
        -- Lua
        lua = { 'stylua' },
        
        -- Python
        python = { 'ruff_format', 'black' },
        
        -- Web
        html = { 'prettier' },
        css = { 'prettier' },
        scss = { 'prettier' },
        less = { 'prettier' },
        json = { 'prettier' },
        jsonc = { 'prettier' },
        yaml = { 'prettier' },
        
        -- Markdown
        markdown = { 'prettier' },
        
        -- Shell
        sh = { 'shfmt' },
        bash = { 'shfmt' },
        
        -- Trim whitespace for all files
        ['*'] = { 'trim_whitespace' },
      },
      
      -- Format on save DISABLED - only format manually with :Autoformat or gA
      format_on_save = nil,
      
      -- Formatter configurations
      formatters = {
        -- Trim whitespace (replaces vim-better-whitespace)
        trim_whitespace = {
          format = function(self, ctx, lines, callback)
            local new_lines = {}
            for _, line in ipairs(lines) do
              -- gsub returns (string, count), we only want the string
              local trimmed = line:gsub('%s+$', '')
              table.insert(new_lines, trimmed)
            end
            callback(nil, new_lines)
          end,
        },
      },
    })
    
    -- Create :Autoformat command for compatibility
    vim.api.nvim_create_user_command('Autoformat', function()
      conform.format({ async = false, lsp_format = 'fallback' })
    end, { desc = 'Format buffer with conform.nvim' })
  end,
}

--[[
  nvim-lint - Linting
  
  Replaces syntastic with modern async linter
  Configured for eslint_d, yamllint, markdownlint, pug-lint
]]

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    linters_by_ft = {
      javascript = { 'eslint_d' },
      typescript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      python = { 'pylint' },
      markdown = { 'markdownlint' },
      yaml = { 'yamllint' },
      pug = { 'puglint' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
    },
    linters = {},  -- Use built-in linters only
  },
  config = function(_, opts)
    local lint = require('lint')

    -- Set linters
    lint.linters_by_ft = opts.linters_by_ft

    -- Configure custom linters
    for name, config in pairs(opts.linters or {}) do
      lint.linters[name] = config
    end

    -- Helper function to check if eslint config exists
    local function has_eslint_config()
      local config_files = {
        '.eslintrc',
        '.eslintrc.js',
        '.eslintrc.cjs',
        '.eslintrc.yaml',
        '.eslintrc.yml',
        '.eslintrc.json',
        'eslint.config.js',
        'eslint.config.mjs',
        'eslint.config.cjs',
      }
      
      local found = vim.fs.find(config_files, {
        upward = true,
        stop = vim.env.HOME,
        path = vim.fn.expand('%:p:h'),
      })
      
      if #found > 0 then
        return true
      end
      
      -- Check for eslintConfig in package.json
      local package_json = vim.fs.find('package.json', {
        upward = true,
        stop = vim.env.HOME,
        path = vim.fn.expand('%:p:h'),
      })[1]
      
      if package_json then
        local ok, content = pcall(vim.fn.readfile, package_json)
        if ok then
          local json_str = table.concat(content, '\n')
          if json_str:match('"eslintConfig"') then
            return true
          end
        end
      end
      
      return false
    end

    -- Lint on save and other events
    local lint_augroup = vim.api.nvim_create_augroup('Lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        local linters = lint.linters_by_ft[ft]
        
        if not linters then
          return
        end
        
        -- For JavaScript/TypeScript, only lint if eslint config exists
        if vim.tbl_contains({ 'javascript', 'typescript', 'javascriptreact', 'typescriptreact' }, ft) then
          if not has_eslint_config() then
            -- Show tip once per session
            local tip_key = 'lint_tip_eslint_config'
            if not vim.g[tip_key] then
              vim.g[tip_key] = true
              vim.notify(
                'Tip: Create .eslintrc or eslint.config.js for JavaScript linting',
                vim.log.levels.INFO
              )
            end
            return  -- Don't run linter without config
          end
        end
        
        -- Check if linter is installed
        local has_linter = false
        local missing_linters = {}
        for _, linter_name in ipairs(linters) do
          if vim.fn.executable(linter_name) == 1 then
            has_linter = true
          else
            table.insert(missing_linters, linter_name)
          end
        end
        
        if has_linter then
          lint.try_lint()
        elseif #missing_linters > 0 then
          -- Show helpful tip once per session
          local tip_key = 'lint_tip_' .. ft
          if not vim.g[tip_key] then
            vim.g[tip_key] = true
            local linter_list = table.concat(missing_linters, ', ')
            vim.notify(
              string.format('Tip: Install %s for %s linting via :Mason or npm', linter_list, ft),
              vim.log.levels.INFO
            )
          end
        end
      end,
    })
  end,
}

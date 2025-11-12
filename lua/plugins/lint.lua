--[[
  Linting Configuration - Local node_modules Support
  
  All linters prefer local node_modules/.bin installations first,
  then fall back to npx, then global commands.
]]

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    
    -- ========================================================================
    -- HELPER: Find local executable in node_modules or use npx/global
    -- ========================================================================
    
    local function find_local_executable(cmd_name, filepath)
      -- Get project root by looking for package.json
      local root = vim.fs.dirname(vim.fs.find({ 'package.json' }, {
        upward = true,
        path = filepath,
      })[1])
      
      if root then
        -- Try local node_modules/.bin/cmd
        local local_cmd = root .. '/node_modules/.bin/' .. cmd_name
        if vim.fn.executable(local_cmd) == 1 then
          return local_cmd
        end
      end
      
      -- Try npx (will use local if available)
      if vim.fn.executable('npx') == 1 then
        return 'npx'
      end
      
      -- Fall back to global command
      if vim.fn.executable(cmd_name) == 1 then
        return cmd_name
      end
      
      return nil
    end
    
    -- ========================================================================
    -- CONFIGURE LINTERS WITH LOCAL SUPPORT
    -- ========================================================================
    
    -- Override remark-lint to use local installation
    lint.linters.remark_lint = vim.tbl_extend('force', lint.linters.remark_lint or {}, {
      cmd = 'remark',
      stdin = true,
      args = { '--no-stdout', '--quiet', '--frail' },
      stream = 'stderr',
      ignore_exitcode = true,
      parser = lint.linters.remark_lint and lint.linters.remark_lint.parser or function(output)
        -- Use default parser if available
        return {}
      end,
    })
    
    -- Override markdownlint to use local installation
    if lint.linters.markdownlint then
      local original_markdownlint = vim.deepcopy(lint.linters.markdownlint)
      lint.linters.markdownlint = vim.tbl_extend('force', original_markdownlint, {
        cmd = 'markdownlint',
      })
    end
    
    -- Set linters by filetype
    lint.linters_by_ft = {
      -- JavaScript/TypeScript - handled by custom XO linter below
      python = { 'pylint' },
      markdown = { 'markdownlint' },  -- Will use local if available
      yaml = { 'yamllint' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      pug = { 'puglint' },  -- Add pug linting
    }
    
    -- ========================================================================
    -- SMART LINTING: Use local executables when available
    -- ========================================================================
    
    local function smart_lint()
      local ft = vim.bo.filetype
      local linters = lint.linters_by_ft[ft]
      
      if not linters then
        return
      end
      
      -- For Node.js based linters, try to use local version
      local node_linters = { 'markdownlint', 'remark_lint', 'puglint' }
      local filepath = vim.api.nvim_buf_get_name(0)
      
      for _, linter_name in ipairs(linters) do
        if vim.tbl_contains(node_linters, linter_name) then
          local cmd_name = linter_name:gsub('_lint$', ''):gsub('_', '-')
          local local_cmd = find_local_executable(cmd_name, filepath)
          
          if local_cmd and lint.linters[linter_name] then
            -- Update linter command to use local version
            if local_cmd == 'npx' then
              -- For npx, we need to add the command name as first arg
              local original_args = lint.linters[linter_name].args or {}
              lint.linters[linter_name].cmd = 'npx'
              lint.linters[linter_name].args = vim.list_extend({ cmd_name }, original_args)
            else
              lint.linters[linter_name].cmd = local_cmd
            end
          end
        end
      end
      
      -- Run linting
      lint.try_lint()
    end
    
    -- Lint on save for configured filetypes
    local lint_augroup = vim.api.nvim_create_augroup('Lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = lint_augroup,
      callback = smart_lint,
    })
    
    -- ========================================================================
    -- XO LINTING - Custom Implementation for JavaScript/TypeScript
    -- ========================================================================
    
    local xo_ns = vim.api.nvim_create_namespace('xo_linter')
    
    local function run_xo()
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)
      
      -- Only run on JS/TS files
      local ft = vim.bo[bufnr].filetype
      if not vim.tbl_contains({'javascript', 'typescript', 'javascriptreact', 'typescriptreact'}, ft) then
        return
      end
      
      -- Skip if file doesn't exist on disk
      if filepath == '' or vim.fn.filereadable(filepath) == 0 then
        return
      end
      
      -- Find XO command (local first)
      local xo_cmd = find_local_executable('xo', filepath)
      if not xo_cmd then
        return
      end
      
      -- Build command args
      local args = {}
      if xo_cmd == 'npx' then
        table.insert(args, 'xo')
      end
      table.insert(args, filepath)
      table.insert(args, '--reporter=json')
      
      -- Clear previous diagnostics
      vim.diagnostic.reset(xo_ns, bufnr)
      
      -- Run XO asynchronously
      vim.system(
        vim.list_extend({ xo_cmd }, args),
        { text = true },
        vim.schedule_wrap(function(result)
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end
          
          local output = result.stdout or ''
          if output == '' then
            return
          end
          
          -- Parse JSON output
          local ok, decoded = pcall(vim.json.decode, output)
          if not ok then
            return
          end
          
          -- Convert to diagnostics
          local diagnostics = {}
          for _, file_result in ipairs(decoded) do
            for _, msg in ipairs(file_result.messages or {}) do
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = (msg.line or 1) - 1,
                col = (msg.column or 1) - 1,
                end_lnum = (msg.endLine or msg.line or 1) - 1,
                end_col = (msg.endColumn or msg.column or 1) - 1,
                severity = msg.severity == 2 and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                message = msg.message,
                source = 'xo',
                code = msg.ruleId,
              })
            end
          end
          
          -- Set diagnostics
          vim.diagnostic.set(xo_ns, bufnr, diagnostics, {})
        end)
      )
    end
    
    -- Run XO on save and buffer enter
    local xo_augroup = vim.api.nvim_create_augroup('XOLint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
      group = xo_augroup,
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
      callback = run_xo,
    })
    
    -- Also run on InsertLeave for faster feedback
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = xo_augroup,
      pattern = { '*.js', '*.jsx', '*.ts', '*.tsx' },
      callback = function()
        -- Debounce: only run if buffer was modified
        if vim.bo.modified then
          run_xo()
        end
      end,
    })
  end,
}

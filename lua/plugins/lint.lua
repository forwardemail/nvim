--[[
  Linting Configuration - Local node_modules Support + Config Detection

  All linters prefer local node_modules/.bin installations first,
  then fall back to npx, then global commands.

  Linters only run if a configuration file is found in the project.
]]

return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')
    local config_detect = require('utils.linter-config-detection')

    -- ========================================================================
    -- HELPER: Find local executable in node_modules or use npx/global
    -- ========================================================================

    -- Find project root by walking up to find package.json
    local function find_project_root(filepath)
      if not filepath or filepath == '' then
        return nil
      end

      local dir = vim.fn.fnamemodify(filepath, ':p:h')
      local max_depth = 20

      for _ = 1, max_depth do
        local package_json = dir .. '/package.json'
        if vim.fn.filereadable(package_json) == 1 then
          return dir
        end

        local parent = vim.fn.fnamemodify(dir, ':h')
        if parent == dir then
          break
        end
        dir = parent
      end

      return nil
    end

    -- Find local executable and return both command and project root
    local function find_local_executable(cmd_name, filepath)
      local root = find_project_root(filepath)

      if root then
        -- Try local node_modules/.bin/cmd
        local local_cmd = root .. '/node_modules/.bin/' .. cmd_name
        if vim.fn.executable(local_cmd) == 1 then
          return local_cmd, root
        end
      end

      -- Try npx (will use local if available)
      if vim.fn.executable('npx') == 1 then
        return 'npx', root
      end

      -- Fall back to global command
      if vim.fn.executable(cmd_name) == 1 then
        return cmd_name, root
      end

      return nil, nil
    end

    -- ========================================================================
    -- CONFIGURE STANDARD LINTERS
    -- ========================================================================

    -- Set linters by filetype (non-JS/TS/CSS files)
    lint.linters_by_ft = {
      python = { 'pylint' },
      yaml = { 'yamllint' },
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
    }

    -- Lint on save for configured filetypes
    local lint_augroup = vim.api.nvim_create_augroup('Lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost' }, {
      group = lint_augroup,
      callback = function()
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
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

      -- Check file extension (XO supports .js, .cjs, .mjs, .jsx, .ts, .cts, .mts, .tsx)
      local ext = vim.fn.fnamemodify(filepath, ':e')
      if not vim.tbl_contains({'js', 'cjs', 'mjs', 'jsx', 'ts', 'cts', 'mts', 'tsx'}, ext) then
        return
      end

      -- Skip if file doesn't exist on disk
      if filepath == '' or vim.fn.filereadable(filepath) == 0 then
        return
      end

      -- Check if XO config exists
      if not config_detect.has_config('xo', filepath) then
        return
      end

      -- Find XO command (local first) and project root
      local xo_cmd, project_root = find_local_executable('xo', filepath)
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

      -- Run XO asynchronously from project root
      vim.system(
        vim.list_extend({ xo_cmd }, args),
        {
          text = true,
          cwd = project_root  -- Run from project root to find config files
        },
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
      pattern = { '*.js', '*.cjs', '*.mjs', '*.jsx', '*.ts', '*.cts', '*.mts', '*.tsx' },
      callback = run_xo,
    })

    -- Also run on InsertLeave for faster feedback
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = xo_augroup,
      pattern = { '*.js', '*.cjs', '*.mjs', '*.jsx', '*.ts', '*.cts', '*.mts', '*.tsx' },
      callback = function()
        -- Debounce: only run if buffer was modified
        if vim.bo.modified then
          run_xo()
        end
      end,
    })

    -- ========================================================================
    -- REMARK LINTING - Custom Implementation for Markdown
    -- ========================================================================

    local remark_ns = vim.api.nvim_create_namespace('remark_linter')

    -- Parse remark output
    -- Format 1: "README.md: no issues found"
    -- Format 2: "  4:1-4:8  warning  First heading level should be `1`  first-heading-level  remark-lint"
    local function parse_remark_output(output, bufnr)
      local diagnostics = {}

      for line in output:gmatch('[^\r\n]+') do
        -- Skip "no issues found" and filename-only lines
        if line:match('no issues found') or not line:match('%d') then
          goto continue
        end

        -- Match format: "  4:1-4:8  warning  message  rule-name  remark-lint"
        -- Note: line may have leading spaces
        local lnum, col_start, severity, message, rule = line:match('^%s*(%d+):(%d+)%-%d+:%d+%s+(%w+)%s+(.-)%s+([%w%-]+)%s+remark%-lint')

        if lnum then
          table.insert(diagnostics, {
            bufnr = bufnr,
            lnum = tonumber(lnum) - 1,
            col = tonumber(col_start) - 1,
            end_lnum = tonumber(lnum) - 1,
            end_col = tonumber(col_start),
            severity = severity == 'error' and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
            message = message,
            source = 'remark',
            code = rule,
          })
        end

        ::continue::
      end

      return diagnostics
    end

    local function run_remark()
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)

      -- Only run on Markdown files
      local ft = vim.bo[bufnr].filetype
      if ft ~= 'markdown' then
        return
      end

      -- Skip if file doesn't exist on disk
      if filepath == '' or vim.fn.filereadable(filepath) == 0 then
        return
      end

      -- Check if Remark config exists
      if not config_detect.has_config('remark', filepath) then
        return
      end

      -- Find remark command (local first) and project root
      local remark_cmd, project_root = find_local_executable('remark', filepath)
      if not remark_cmd then
        return
      end

      -- Build command args
      local args = {}
      if remark_cmd == 'npx' then
        table.insert(args, 'remark')
      end
      table.insert(args, filepath)
      table.insert(args, '--no-stdout')  -- Don't output formatted markdown
      table.insert(args, '--no-color')   -- Disable ANSI color codes

      -- Clear previous diagnostics
      vim.diagnostic.reset(remark_ns, bufnr)

      -- Run remark asynchronously from project root
      vim.system(
        vim.list_extend({ remark_cmd }, args),
        {
          text = true,
          cwd = project_root  -- Run from project root to find config files
        },
        vim.schedule_wrap(function(result)
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end

          -- Remark outputs to stderr
          local output = result.stderr or ''
          if output == '' or output:match('no issues found') then
            return
          end

          -- Parse output
          local diagnostics = parse_remark_output(output, bufnr)

          -- Set diagnostics
          vim.diagnostic.set(remark_ns, bufnr, diagnostics, {})
        end)
      )
    end

    -- Run remark on save and buffer enter
    local remark_augroup = vim.api.nvim_create_augroup('RemarkLint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
      group = remark_augroup,
      pattern = { '*.md', '*.markdown', '*.mdown', '*.mkdn', '*.mkd', '*.mdwn', '*.mdtxt', '*.mdtext', '*.mdx' },
      callback = run_remark,
    })

    -- Also run on InsertLeave for faster feedback
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = remark_augroup,
      pattern = { '*.md', '*.markdown', '*.mdown', '*.mkdn', '*.mkd', '*.mdwn', '*.mdtxt', '*.mdtext', '*.mdx' },
      callback = function()
        if vim.bo.modified then
          run_remark()
        end
      end,
    })

    -- ========================================================================
    -- PUG-LINT - Custom Implementation for Pug Templates
    -- ========================================================================

    local puglint_ns = vim.api.nvim_create_namespace('puglint_linter')

    -- Parse pug-lint output (format: "file.pug:line:col")
    local function parse_puglint_output(output, bufnr)
      local diagnostics = {}
      local lines = vim.split(output, '\n')
      local i = 1

      while i <= #lines do
        local line = lines[i]
        -- Match format: "test.pug:5:3"
        local lnum, col = line:match('^[^:]+:(%d+):(%d+)')

        if lnum then
          -- Skip the context lines (next 5 lines showing code)
          i = i + 5
          -- Get the error message
          local message = lines[i] or 'Pug lint error'
          message = message:gsub('^%s+', '')  -- Trim leading whitespace

          table.insert(diagnostics, {
            bufnr = bufnr,
            lnum = tonumber(lnum) - 1,
            col = tonumber(col) - 1,
            end_lnum = tonumber(lnum) - 1,
            end_col = tonumber(col),
            severity = vim.diagnostic.severity.ERROR,
            message = message,
            source = 'pug-lint',
          })
        end

        i = i + 1
      end

      return diagnostics
    end

    local function run_puglint()
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)

      -- Only run on Pug files
      local ft = vim.bo[bufnr].filetype
      if ft ~= 'pug' then
        return
      end

      -- Skip if file doesn't exist on disk
      if filepath == '' or vim.fn.filereadable(filepath) == 0 then
        return
      end

      -- Check if Pug-lint config exists
      if not config_detect.has_config('puglint', filepath) then
        return
      end

      -- Find pug-lint command (local first) and project root
      local puglint_cmd, project_root = find_local_executable('pug-lint', filepath)
      if not puglint_cmd then
        return
      end

      -- Build command args
      local args = {}
      if puglint_cmd == 'npx' then
        table.insert(args, 'pug-lint')
      end
      table.insert(args, filepath)

      -- Clear previous diagnostics
      vim.diagnostic.reset(puglint_ns, bufnr)

      -- Run pug-lint asynchronously from project root
      vim.system(
        vim.list_extend({ puglint_cmd }, args),
        {
          text = true,
          cwd = project_root  -- Run from project root to find config files
        },
        vim.schedule_wrap(function(result)
          if not vim.api.nvim_buf_is_valid(bufnr) then
            return
          end

          -- pug-lint outputs to stdout
          local output = result.stdout or ''
          if output == '' then
            return
          end

          -- Parse output
          local diagnostics = parse_puglint_output(output, bufnr)

          -- Set diagnostics
          vim.diagnostic.set(puglint_ns, bufnr, diagnostics, {})
        end)
      )
    end

    -- Run pug-lint on save and buffer enter
    local puglint_augroup = vim.api.nvim_create_augroup('PugLint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
      group = puglint_augroup,
      pattern = { '*.pug', '*.jade' },
      callback = run_puglint,
    })

    -- Also run on InsertLeave for faster feedback
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = puglint_augroup,
      pattern = { '*.pug', '*.jade' },
      callback = function()
        if vim.bo.modified then
          run_puglint()
        end
      end,
    })

    -- ========================================================================
    -- STYLELINT - Custom Implementation for CSS/SCSS/LESS
    -- ========================================================================

    local stylelint_ns = vim.api.nvim_create_namespace('stylelint_linter')

    local function run_stylelint()
      local bufnr = vim.api.nvim_get_current_buf()
      local filepath = vim.api.nvim_buf_get_name(bufnr)

      -- Only run on CSS/SCSS/LESS files
      local ft = vim.bo[bufnr].filetype
      if not vim.tbl_contains({'css', 'scss', 'less', 'sass'}, ft) then
        return
      end

      -- Skip if file doesn't exist on disk
      if filepath == '' or vim.fn.filereadable(filepath) == 0 then
        return
      end

      -- Check if Stylelint config exists
      if not config_detect.has_config('stylelint', filepath) then
        return
      end

      -- Find stylelint command (local first) and project root
      local stylelint_cmd, project_root = find_local_executable('stylelint', filepath)
      if not stylelint_cmd then
        return
      end

      -- Build command args
      local args = {}
      if stylelint_cmd == 'npx' then
        table.insert(args, 'stylelint')
      end
      table.insert(args, filepath)
      table.insert(args, '--formatter=json')

      -- Clear previous diagnostics
      vim.diagnostic.reset(stylelint_ns, bufnr)

      -- Run stylelint asynchronously from project root
      vim.system(
        vim.list_extend({ stylelint_cmd }, args),
        {
          text = true,
          cwd = project_root  -- Run from project root to find config files
        },
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
            for _, warning in ipairs(file_result.warnings or {}) do
              table.insert(diagnostics, {
                bufnr = bufnr,
                lnum = (warning.line or 1) - 1,
                col = (warning.column or 1) - 1,
                end_lnum = (warning.endLine or warning.line or 1) - 1,
                end_col = (warning.endColumn or warning.column or 1) - 1,
                severity = warning.severity == 'error' and vim.diagnostic.severity.ERROR or vim.diagnostic.severity.WARN,
                message = warning.text,
                source = 'stylelint',
                code = warning.rule,
              })
            end
          end

          -- Set diagnostics
          vim.diagnostic.set(stylelint_ns, bufnr, diagnostics, {})
        end)
      )
    end

    -- Run stylelint on save and buffer enter
    local stylelint_augroup = vim.api.nvim_create_augroup('StylelintLint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter' }, {
      group = stylelint_augroup,
      pattern = { '*.css', '*.scss', '*.less', '*.sass' },
      callback = run_stylelint,
    })

    -- Also run on InsertLeave for faster feedback
    vim.api.nvim_create_autocmd('InsertLeave', {
      group = stylelint_augroup,
      pattern = { '*.css', '*.scss', '*.less', '*.sass' },
      callback = function()
        if vim.bo.modified then
          run_stylelint()
        end
      end,
    })

    -- ========================================================================
    -- POSTCSS (using stylelint as PostCSS linter is typically done via plugins)
    -- Note: PostCSS itself is not a linter, but postcss-cli can be used
    -- with plugins. For now, we'll skip direct PostCSS linting as it's
    -- typically handled by Stylelint with postcss-syntax.
    -- ========================================================================
  end,
}

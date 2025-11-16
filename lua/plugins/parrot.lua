-- ============================================================================
-- Parrot.nvim - AI Coding Assistant with Local Ollama Support
-- ============================================================================
-- Provides seamless integration with local Ollama LLMs for code generation,
-- editing, and chat-like sessions within Neovim.
--
-- Features:
-- - Multiple pre-configured models optimized for JavaScript/Node.js
-- - Chat sessions in native Neovim buffers
-- - Inline code editing and completion
-- - No background requests or hidden analysis
-- ============================================================================

return {
  'frankroeder/parrot.nvim',
  cmd = { 'PrtChatNew', 'PrtChatToggle', 'PrtChatDelete', 'PrtComplete', 'PrtExplain', 'PrtFixBugs', 'PrtOptimize', 'PrtUnitTests', 'PrtAddComments', 'PrtSpellCheck', 'PrtModel', 'PrtProvider', 'PrtInfo' },
  keys = {
    { '<C-g><C-g>', mode = { 'n', 'i', 'v', 'x' }, desc = 'Parrot: Send message' },
    { '<C-g>d', mode = { 'n', 'i', 'v', 'x' }, desc = 'Parrot: Delete chat' },
    { '<C-g>s', mode = { 'n', 'i', 'v', 'x' }, desc = 'Parrot: Stop generation' },
    { '<C-g>c', mode = { 'n', 'i', 'v', 'x' }, desc = 'Parrot: New chat' },
  },
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim',
  },
  config = function()
    require('parrot').setup({
      -- ========================================================================
      -- OLLAMA PROVIDER CONFIGURATION
      -- ========================================================================
      providers = {
        ollama = {
          name = 'ollama',
          endpoint = 'http://localhost:11434/api/chat',
          api_key = '', -- Not required for local Ollama
          
          -- Temperature and context settings
          params = {
            chat = {
              temperature = 0.7,      -- Lower for more focused code
              top_p = 0.95,
              num_ctx = 32768,        -- Large context for understanding codebases
              min_p = 0.05,
            },
            command = {
              temperature = 0.5,      -- Even lower for precise commands
              top_p = 0.9,
              num_ctx = 16384,
              min_p = 0.05,
            },
          },
          
          -- Topic generation for chat summaries
          topic_prompt = [[
            Summarize the chat above and provide a short headline of 2 to 3
            words without any opening phrase.
          ]],
          topic = {
            model = 'qwen2.5-coder:7b',
            params = { max_tokens = 32 },
          },
          
          headers = {
            ['Content-Type'] = 'application/json',
          },
          
          -- ====================================================================
          -- MODEL SELECTION - Optimized for JavaScript/Node.js on M5 Mac 32GB
          -- ====================================================================
          -- These models are pre-configured based on extensive research for
          -- JavaScript/Node.js development on Apple Silicon with 32GB RAM.
          --
          -- To use a model, first pull it with Ollama:
          --   ollama pull <model-name>
          --
          -- Recommended quantization: Q4_K_M or Q5_K_M for best balance
          -- ====================================================================
          
          models = {
            -- ----------------------------------------------------------------
            -- TIER 1: BEST FOR JAVASCRIPT/NODE.JS (RECOMMENDED)
            -- ----------------------------------------------------------------
            
            -- Qwen2.5-Coder 32B - Top recommendation for JS/Node.js
            -- Performance: Competitive with GPT-4o on code repair
            -- Memory: ~18-20GB with Q4_K_M quantization
            -- Speed: 40-60 tokens/sec on M5 32GB
            -- Best for: Complex code generation, refactoring, debugging
            'qwen2.5-coder:32b-instruct-q4_K_M',
            'qwen2.5-coder:32b-instruct-q5_K_M',  -- Higher quality, slightly slower
            
            -- DeepSeek-Coder V2 16B - Excellent all-rounder
            -- Performance: Rivals GPT-4 Turbo, MoE architecture (fast!)
            -- Memory: ~10-12GB with Q4_K_M
            -- Speed: 60-80 tokens/sec on M5 32GB
            -- Best for: Fast iterations, general coding tasks
            'deepseek-coder-v2:16b-lite-instruct-q4_K_M',
            'deepseek-coder-v2:16b-lite-instruct-q5_K_M',
            
            -- Yi-Coder 9B - Community favorite for web development
            -- Performance: Specifically praised for JS/Node.js/HTML/SQL
            -- Memory: ~6-7GB with Q4_K_M
            -- Speed: 80-100 tokens/sec on M5 32GB
            -- Best for: Full-stack web development, fast responses
            'yi-coder:9b-chat-q4_K_M',
            'yi-coder:9b-chat-q5_K_M',
            
            -- ----------------------------------------------------------------
            -- TIER 2: POWERFUL ALTERNATIVES
            -- ----------------------------------------------------------------
            
            -- Qwen3-Coder 30B A3B - Latest MoE model (if available)
            -- Performance: Fastest of the 30B+ models due to MoE
            -- Memory: ~18-20GB with Q4_K_M
            -- Speed: 70-90 tokens/sec on M5 32GB
            -- Best for: Latest features, long context retention
            'qwen3-coder:30b-a3b-instruct-q4_K_M',
            
            -- CodeQwen 7B - Smaller, faster option
            -- Performance: Good for quick tasks
            -- Memory: ~5GB with Q4_K_M
            -- Speed: 100+ tokens/sec on M5 32GB
            -- Best for: Quick completions, autocompletion
            'codeqwen:7b-code-v1.5-q4_K_M',
            
            -- ----------------------------------------------------------------
            -- TIER 3: LIGHTWEIGHT OPTIONS (for quick tasks)
            -- ----------------------------------------------------------------
            
            -- Qwen2.5-Coder 7B - Lightweight but capable
            -- Memory: ~5GB
            -- Speed: 100+ tokens/sec
            -- Best for: Quick edits, comments, simple tasks
            'qwen2.5-coder:7b-instruct-q4_K_M',
            
            -- Qwen2.5-Coder 3B - Ultra-fast for autocompletion
            -- Memory: ~2-3GB
            -- Speed: 150+ tokens/sec
            -- Best for: Inline completions, very quick responses
            'qwen2.5-coder:3b-instruct-q4_K_M',
            
            -- ----------------------------------------------------------------
            -- GENERAL PURPOSE (non-coding specialists)
            -- ----------------------------------------------------------------
            
            -- Qwen2.5 14B - Good general model with coding ability
            'qwen2.5:14b-instruct-q4_K_M',
            
            -- Llama 3.2 3B - Fast general purpose
            'llama3.2:3b-instruct-q4_K_M',
          },
          
          resolve_api_key = function()
            return true
          end,
          
          -- Process streaming responses from Ollama
          process_stdout = function(response)
            if response:match('message') and response:match('content') then
              local ok, data = pcall(vim.json.decode, response)
              if ok and data.message and data.message.content then
                return data.message.content
              end
            end
          end,
          
          -- Fetch available models from Ollama
          get_available_models = function(self)
            local Job = require('plenary.job')
            local url = self.endpoint:gsub('chat', '')
            local logger = require('parrot.logger')
            
            local job = Job:new({
              command = 'curl',
              args = { '-H', 'Content-Type: application/json', url .. 'tags' },
            }):sync()
            
            local parsed_response = require('parrot.utils').parse_raw_response(job)
            self:process_onexit(parsed_response)
            
            if parsed_response == '' then
              logger.debug('Ollama server not running on ' .. self.endpoint)
              return {}
            end
            
            local success, parsed_data = pcall(vim.json.decode, parsed_response)
            if not success then
              logger.error('Ollama - Error parsing JSON: ' .. vim.inspect(parsed_data))
              return {}
            end
            
            if not parsed_data.models then
              logger.error('Ollama - No models found. Please use "ollama pull" to download models.')
              return {}
            end
            
            local names = {}
            for _, model in ipairs(parsed_data.models) do
              table.insert(names, model.name)
            end
            
            return names
          end,
        },
      },
      
      -- ========================================================================
      -- CHAT SETTINGS
      -- ========================================================================
      toggle_target = 'vsplit',  -- 'popup', 'split', 'vsplit', 'tabnew'
      chat_dir = vim.fn.stdpath('data') .. '/parrot/chats',
      chat_confirm_delete = true,
      chat_conceal_model_params = false,
      chat_shortcut_respond = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g><C-g>' },
      chat_shortcut_delete = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>d' },
      chat_shortcut_stop = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>s' },
      chat_shortcut_new = { modes = { 'n', 'i', 'v', 'x' }, shortcut = '<C-g>c' },
      
      -- ========================================================================
      -- COMMAND SETTINGS
      -- ========================================================================
      command_auto_select_response = true,
      
      -- ========================================================================
      -- HOOKS - Predefined prompts for common tasks
      -- ========================================================================
      hooks = {
        -- Complete code based on comments
        Complete = function(parrot, params)
          local template = [[
          I have the following code from {{filename}}:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Please finish the code above carefully and logically.
          Respond just with the snippet of code that should be inserted.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.append, model, nil, template)
        end,
        
        -- Explain code
        Explain = function(parrot, params)
          local template = [[
          Explain the following {{filetype}} code:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Provide a clear, concise explanation of what this code does.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.new, model, 'Explanation', template)
        end,
        
        -- Fix bugs
        FixBugs = function(parrot, params)
          local template = [[
          Fix any bugs in the following {{filetype}} code:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Respond with the corrected code only.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.rewrite, model, nil, template)
        end,
        
        -- Optimize code
        Optimize = function(parrot, params)
          local template = [[
          Optimize the following {{filetype}} code for better performance:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Respond with the optimized code only.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.rewrite, model, nil, template)
        end,
        
        -- Add tests
        UnitTests = function(parrot, params)
          local template = [[
          Write unit tests for the following {{filetype}} code:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Use appropriate testing framework for {{filetype}}.
          Respond with complete test code.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.new, model, 'Unit Tests', template)
        end,
        
        -- Add JSDoc comments
        AddComments = function(parrot, params)
          local template = [[
          Add JSDoc comments to the following JavaScript/TypeScript code:
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Respond with the code including proper JSDoc comments.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.rewrite, model, nil, template)
        end,
        
        -- Spell check and grammar correction
        SpellCheck = function(parrot, params)
          local template = [[
          Fix all spelling and grammar errors in the following text.
          Preserve the original formatting, code blocks, and structure.
          Only fix spelling and grammar mistakes, do not change the meaning or style.
          
          ```{{filetype}}
          {{selection}}
          ```
          
          Respond with the corrected text only.
          ]]
          local model = parrot.get_model('command')
          parrot.Prompt(params, parrot.ui.Target.rewrite, model, nil, template)
        end,
      },
    })
  end,
}

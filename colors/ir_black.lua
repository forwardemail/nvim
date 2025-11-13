-- IR Black color scheme for Neovim
-- Ported from: https://github.com/wesgibbs/vim-irblack
-- Pure black background version

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
  vim.cmd('syntax reset')
end

vim.g.colors_name = 'ir_black'
vim.o.background = 'dark'

-- Color palette from original IR Black
local colors = {
  black = '#000000',
  white = '#ffffff',
  grey = '#7C7C7C',
  light_grey = '#E8E8D3',
  dark_grey = '#1C1C1C',
  yellow = '#FFFFB6',
  orange = '#FFD2A7',
  red = '#FF6C60',
  pink = '#FF73FD',
  purple = '#C6C5FE',
  blue = '#96CBFE',
  cyan = '#C6C5FE',
  green = '#A8FF60',
  brown = '#E18964',
  none = 'NONE',
}

-- Helper function to set highlights
local function hi(group, opts)
  local cmd = 'hi ' .. group
  if opts.fg then cmd = cmd .. ' guifg=' .. opts.fg end
  if opts.bg then cmd = cmd .. ' guibg=' .. opts.bg end
  if opts.style then cmd = cmd .. ' gui=' .. opts.style end
  if opts.sp then cmd = cmd .. ' guisp=' .. opts.sp end
  vim.cmd(cmd)
end

-- Editor highlights
hi('Normal', { fg = colors.light_grey, bg = colors.black })
hi('Cursor', { fg = colors.black, bg = colors.white })
hi('CursorLine', { bg = colors.dark_grey })
hi('CursorColumn', { bg = colors.dark_grey })
hi('ColorColumn', { bg = colors.dark_grey })
hi('LineNr', { fg = colors.grey, bg = colors.black })
hi('CursorLineNr', { fg = colors.white, bg = colors.dark_grey })
hi('VertSplit', { fg = colors.grey, bg = colors.black })
hi('StatusLine', { fg = colors.white, bg = colors.dark_grey })
hi('StatusLineNC', { fg = colors.grey, bg = colors.dark_grey })
hi('TabLine', { fg = colors.grey, bg = colors.dark_grey })
hi('TabLineFill', { bg = colors.dark_grey })
hi('TabLineSel', { fg = colors.white, bg = colors.black })
hi('Visual', { bg = colors.dark_grey })
hi('Search', { fg = colors.black, bg = colors.yellow })
hi('IncSearch', { fg = colors.black, bg = colors.orange })
hi('Pmenu', { fg = colors.light_grey, bg = colors.dark_grey })
hi('PmenuSel', { fg = colors.black, bg = colors.blue })
hi('PmenuSbar', { bg = colors.grey })
hi('PmenuThumb', { bg = colors.white })
hi('WildMenu', { fg = colors.black, bg = colors.yellow })
hi('Folded', { fg = colors.grey, bg = colors.dark_grey })
hi('FoldColumn', { fg = colors.grey, bg = colors.black })
hi('SignColumn', { fg = colors.grey, bg = colors.black })
hi('MatchParen', { fg = colors.orange, bg = colors.dark_grey, style = 'bold' })
hi('NonText', { fg = colors.grey })
hi('SpecialKey', { fg = colors.grey })
hi('Directory', { fg = colors.blue })
hi('Title', { fg = colors.orange })
hi('ErrorMsg', { fg = colors.white, bg = colors.red })
hi('WarningMsg', { fg = colors.red })
hi('Question', { fg = colors.green })
hi('MoreMsg', { fg = colors.green })
hi('ModeMsg', { fg = colors.green })

-- Syntax highlighting
hi('Comment', { fg = colors.grey, style = 'italic' })
hi('Constant', { fg = colors.pink })
hi('String', { fg = colors.green })
hi('Character', { fg = colors.green })
hi('Number', { fg = colors.pink })
hi('Boolean', { fg = colors.pink })
hi('Float', { fg = colors.pink })
hi('Identifier', { fg = colors.purple })
hi('Function', { fg = colors.orange })
hi('Statement', { fg = colors.blue })
hi('Conditional', { fg = colors.blue })
hi('Repeat', { fg = colors.blue })
hi('Label', { fg = colors.blue })
hi('Operator', { fg = colors.white })
hi('Keyword', { fg = colors.blue })
hi('Exception', { fg = colors.blue })
hi('PreProc', { fg = colors.blue })
hi('Include', { fg = colors.blue })
hi('Define', { fg = colors.blue })
hi('Macro', { fg = colors.blue })
hi('PreCondit', { fg = colors.blue })
hi('Type', { fg = colors.yellow })
hi('StorageClass', { fg = colors.blue })
hi('Structure', { fg = colors.yellow })
hi('Typedef', { fg = colors.yellow })
hi('Special', { fg = colors.orange })
hi('SpecialChar', { fg = colors.orange })
hi('Tag', { fg = colors.blue })
hi('Delimiter', { fg = colors.white })
hi('SpecialComment', { fg = colors.grey })
hi('Debug', { fg = colors.red })
hi('Underlined', { fg = colors.blue, style = 'underline' })
hi('Ignore', { fg = colors.grey })
hi('Error', { fg = colors.white, bg = colors.red })
hi('Todo', { fg = colors.black, bg = colors.yellow, style = 'bold' })

-- Treesitter highlights
hi('@comment', { fg = colors.grey, style = 'italic' })
hi('@constant', { fg = colors.pink })
hi('@constant.builtin', { fg = colors.pink })
hi('@constant.macro', { fg = colors.pink })
hi('@string', { fg = colors.green })
hi('@string.escape', { fg = colors.orange })
hi('@string.special', { fg = colors.orange })
hi('@character', { fg = colors.green })
hi('@number', { fg = colors.pink })
hi('@boolean', { fg = colors.pink })
hi('@float', { fg = colors.pink })
hi('@function', { fg = colors.orange })
hi('@function.builtin', { fg = colors.orange })
hi('@function.macro', { fg = colors.orange })
hi('@parameter', { fg = colors.purple })
hi('@method', { fg = colors.orange })
hi('@field', { fg = colors.purple })
hi('@property', { fg = colors.purple })
hi('@constructor', { fg = colors.yellow })
hi('@conditional', { fg = colors.blue })
hi('@repeat', { fg = colors.blue })
hi('@label', { fg = colors.blue })
hi('@operator', { fg = colors.white })
hi('@keyword', { fg = colors.blue })
hi('@keyword.function', { fg = colors.blue })
hi('@keyword.operator', { fg = colors.blue })
hi('@keyword.return', { fg = colors.blue })
hi('@exception', { fg = colors.blue })
hi('@variable', { fg = colors.purple })
hi('@variable.builtin', { fg = colors.purple })
hi('@type', { fg = colors.yellow })
hi('@type.builtin', { fg = colors.yellow })
hi('@type.definition', { fg = colors.yellow })
hi('@storageclass', { fg = colors.blue })
hi('@namespace', { fg = colors.yellow })
hi('@include', { fg = colors.blue })
hi('@preproc', { fg = colors.blue })
hi('@debug', { fg = colors.red })
hi('@tag', { fg = colors.blue })
hi('@tag.attribute', { fg = colors.purple })
hi('@tag.delimiter', { fg = colors.white })
hi('@punctuation.delimiter', { fg = colors.white })
hi('@punctuation.bracket', { fg = colors.white })
hi('@punctuation.special', { fg = colors.orange })

-- Markdown specific
hi('@markup.heading', { fg = colors.orange, style = 'bold' })
hi('@markup.strong', { fg = colors.light_grey, style = 'bold' })
hi('@markup.italic', { fg = colors.light_grey, style = 'italic' })
hi('@markup.link', { fg = colors.blue, style = 'underline' })
hi('@markup.link.url', { fg = colors.purple })
hi('@markup.list', { fg = colors.blue })
hi('@markup.quote', { fg = colors.grey, style = 'italic' })
hi('@markup.raw', { fg = colors.green })

-- LSP semantic tokens
hi('@lsp.type.class', { fg = colors.yellow })
hi('@lsp.type.decorator', { fg = colors.orange })
hi('@lsp.type.enum', { fg = colors.yellow })
hi('@lsp.type.enumMember', { fg = colors.pink })
hi('@lsp.type.function', { fg = colors.orange })
hi('@lsp.type.interface', { fg = colors.yellow })
hi('@lsp.type.macro', { fg = colors.pink })
hi('@lsp.type.method', { fg = colors.orange })
hi('@lsp.type.namespace', { fg = colors.yellow })
hi('@lsp.type.parameter', { fg = colors.purple })
hi('@lsp.type.property', { fg = colors.purple })
hi('@lsp.type.struct', { fg = colors.yellow })
hi('@lsp.type.type', { fg = colors.yellow })
hi('@lsp.type.typeParameter', { fg = colors.yellow })
hi('@lsp.type.variable', { fg = colors.purple })

-- Diagnostics
hi('DiagnosticError', { fg = colors.red })
hi('DiagnosticWarn', { fg = colors.orange })
hi('DiagnosticInfo', { fg = colors.blue })
hi('DiagnosticHint', { fg = colors.grey })
hi('DiagnosticUnderlineError', { sp = colors.red, style = 'undercurl' })
hi('DiagnosticUnderlineWarn', { sp = colors.orange, style = 'undercurl' })
hi('DiagnosticUnderlineInfo', { sp = colors.blue, style = 'undercurl' })
hi('DiagnosticUnderlineHint', { sp = colors.grey, style = 'undercurl' })

-- Git signs
hi('GitSignsAdd', { fg = colors.green })
hi('GitSignsChange', { fg = colors.orange })
hi('GitSignsDelete', { fg = colors.red })

-- Neo-tree
hi('NeoTreeNormal', { fg = colors.light_grey, bg = colors.black })
hi('NeoTreeNormalNC', { fg = colors.light_grey, bg = colors.black })
hi('NeoTreeDirectoryIcon', { fg = colors.blue })
hi('NeoTreeDirectoryName', { fg = colors.blue })
hi('NeoTreeFileName', { fg = colors.light_grey })
hi('NeoTreeFileNameOpened', { fg = colors.orange })
hi('NeoTreeGitAdded', { fg = colors.green })
hi('NeoTreeGitModified', { fg = colors.orange })
hi('NeoTreeGitDeleted', { fg = colors.red })
hi('NeoTreeRootName', { fg = colors.orange, style = 'bold' })

-- Telescope
hi('TelescopeNormal', { fg = colors.light_grey, bg = colors.black })
hi('TelescopeBorder', { fg = colors.grey, bg = colors.black })
hi('TelescopePromptNormal', { fg = colors.light_grey, bg = colors.dark_grey })
hi('TelescopePromptBorder', { fg = colors.grey, bg = colors.dark_grey })
hi('TelescopePromptTitle', { fg = colors.orange })
hi('TelescopePreviewTitle', { fg = colors.orange })
hi('TelescopeResultsTitle', { fg = colors.orange })
hi('TelescopeSelection', { fg = colors.white, bg = colors.dark_grey })
hi('TelescopeMatching', { fg = colors.yellow, style = 'bold' })

-- Terminal colors
vim.g.terminal_color_0 = colors.black
vim.g.terminal_color_1 = colors.red
vim.g.terminal_color_2 = colors.green
vim.g.terminal_color_3 = colors.yellow
vim.g.terminal_color_4 = colors.blue
vim.g.terminal_color_5 = colors.pink
vim.g.terminal_color_6 = colors.cyan
vim.g.terminal_color_7 = colors.light_grey
vim.g.terminal_color_8 = colors.grey
vim.g.terminal_color_9 = colors.red
vim.g.terminal_color_10 = colors.green
vim.g.terminal_color_11 = colors.yellow
vim.g.terminal_color_12 = colors.blue
vim.g.terminal_color_13 = colors.pink
vim.g.terminal_color_14 = colors.cyan
vim.g.terminal_color_15 = colors.white

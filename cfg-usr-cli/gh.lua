-- TODO: expand non-treesitter language specific styles matching gh web
-- TODO: popular plugins
-- TODO: dark dimmed

vim.cmd('hi clear')
if vim.fn.exists('syntax_on') then
	vim.cmd('syntax reset')
end

vim.o.termguicolors = true
vim.g.colors_name = 'gh'

function hl(group, fg, bg, style, sp)
	local n = 'NONE'

	if not style then style = n end
	if not fg then fg = n end
	if not bg then bg = n end
	if not sp then sp = n end

	local buf = {
		'highlight',
		group,
		'gui=' .. style,
		'guifg=' .. fg,
		'guibg=' .. bg,
		'guisp=' .. sp
	}
	vim.cmd(table.concat(buf, ' '))
end

function li(group, link)
	vim.cmd('highlight! link ' .. group .. ' ' .. link)
end

if vim.o.background == 'light' then
	c = {
		fg_1 = '#24292e',
		fg_2 = '#6a737d',
		fg_3 = '#babbbc',
		fg_blue = '#05264c',
		bg_1 = '#ffffff',
		bg_2 = '#fafbfc',
		bg_3 = '#e1e4e8',
		blue_0 = '#032f62',
		blue_1 = '#005cc5',
		blue_2 = '#c8e1ff',
		blue_3 = '#f1f8ff',
		red_0 = '#b31d28',
		red_1 = '#d73a49',
		red_2 = '#fdb8c0',
		red_3 = '#ffeef0',
		green_0 = '#165c26',
		green_1 = '#22863a',
		green_2 = '#acf2bd',
		green_3 = '#e6ffed',
		orange_0 = '#c24e00',
		orange_1 = '#e36209',
		orange_2 = '#ffab70',
		purple_0 = '#4c2889',
		purple_1 = '#6f42c1',
		pink_0 = '#99306f',
		pink_1 = '#d03592',
		yellow_3 = '#fffbdd',
	}
else
	c = {
		fg_1 = '#c9d1d9',
		fg_2 = '#8b949e',
		fg_3 = '#585d64',
		fg_blue = '#c8e1ff',
		bg_1 = '#0d1117',
		bg_2 = '#161b22',
		bg_3 = '#30363d',
		blue_0 = '#a5d6ff',
		blue_1 = '#79c0ff',
		blue_2 = '#2d465d',
		blue_3 = '#111d2f',
		red_0 = '#ffc1ba',
		red_1 = '#ff7b72',
		red_2 = '#882727',
		red_3 = '#36181c',
		green_0 = '#aff5b4',
		green_1 = '#7ee787',
		green_2 = '#226d32',
		green_3 = '#132e1f',
		orange_0 = '#ffdfb6',
		orange_1 = '#ffa657',
		orange_2 = '#762d0a',
		purple_0 = '#eddeff',
		purple_1 = '#d2a8ff',
		pink_0 = '#ffdaec',
		pink_1 = '#ff9bce',
		yellow_3 = '#533d11',
	}
end

-- Vim Terminal

vim.g.terminal_color_0 = c.bg_2
vim.g.terminal_color_8 = c.bg_3
vim.g.terminal_color_1 = c.red_1
vim.g.terminal_color_9 = c.red_0
vim.g.terminal_color_2 = c.green_1
vim.g.terminal_color_10 = c.green_0
vim.g.terminal_color_3 = c.orange_1
vim.g.terminal_color_11 = c.orange_0
vim.g.terminal_color_4 = c.blue_1
vim.g.terminal_color_12 = c.blue_0
vim.g.terminal_color_5 = c.pink_1
vim.g.terminal_color_13 = c.pink_0
vim.g.terminal_color_6 = c.purple_1
vim.g.terminal_color_14 = c.purple_0
vim.g.terminal_color_7 = c.fg_2
vim.g.terminal_color_15 = c.fg_1

-- Editor

hl('ColorColumn', nil, c.bg_2) -- columns set with 'colorcolumn'
hl('Conceal', c.fg_3, c.bg_1) -- placeholder characters for concealed text
hl('Cursor', nil, c.fg_1) -- character under the cursor
hl('CursorColumn', nil, c.bg_2) -- column following cursor
hl('CursorLine', nil, c.bg_2) -- vertical line under cursor
hl('Directory', c.blue_1) -- directory names in listsings
hl('ErrorMsg', c.red_1) -- command line error messages
hl('VertSplit', c.fg_3) -- column seperating vertical splits
hl('Folded', c.fg_3) -- line for closed folds
hl('FoldColumn', c.fg_3) -- gutter column showing folds
hl('SignColumn', c.fg_2) -- gutter column showing signs
hl('IncSearch', nil, c.orange_2)  -- incremental search
hl('Substitute', nil, c.red_2) -- text replaced with :s
hl('LineNr', c.fg_3)  -- gutter line numbers
hl('CursorLineNr', nil, c.bg_2) -- gutter line number for current line
hl('MatchParen', nil, c.yellow_3) -- current and matching bracket
hl('ModeMsg', c.fg_1) -- mode message (-- INSERT --)
hl('MsgArea', c.fg_1) -- area for messages and cmdline
hl('MoreMsg', c.fg_1) -- text for pager prompt
hl('NonText', c.fg_3) -- characters that are not part of the text
hl('Normal', c.fg_1, c.bg_1) -- normal text
hl('NormalFloat', c.fg_1, c.bg_1) -- normal text in floating windows
hl('NormalNC', c.fg_1, c.bg_1) -- normal text in non-current windows
hl('PMenu', nil, c.bg_2) -- popup menu, normal item
hl('PMenuSel', nil, c.blue_2) -- popup menu, selected item
hl('PMenuSbar', nil, c.bg_3) -- popup menu, scrollbar
hl('PMenuThumb', nil, c.fg_3) -- popup menu, scrollbar indicator
hl('Question', c.blue_1) -- prompts to continue with Enter or yes/no
hl('QuickFixLine', nil, c.yellow_3) -- current quickfix item
hl('Search', nil, c.yellow_3) -- last search pattern
hl('SpecialKey', c.fg_2) -- unprintable characters
hl('SpellBad', nil, nil, 'undercurl', c.red_1) -- unrecognized word
hl('SpellCap', nil, nil, 'undercurl', c.orange_1) -- non-capitalized word
hl('SpellLocal', nil, nil, 'undercurl', c.blue_1) -- used in other region
hl('SpellRare', nil, nil, 'undercurl', c.fg_2) -- rarely used word
hl('StatusLine', c.fg_blue, c.blue_3) -- status line of current window
hl('StatusLineNC', c.fg_2, c.bg_2)  -- status line of non-current window
hl('TabLine', nil, c.blue_3) -- tab line
-- hl('TabLineFill, nil) -- tab line outside tabs
hl('TabLineSel', nil, c.blue_2) -- tabline, current buffer
hl('Title', c.fg_1, nil, 'bold') -- tites from cmdline output
hl('Visual', nil, c.blue_3) -- visual mode selection
hl('VisualNOS', nil, c.blue_3) -- visual mode selection (not vim owned)
hl('WarningMsg', c.red_1) -- warning messages
hl('Whitespace', c.fg_2) -- whitespace (with 'listchars')
hl('WildMenu', c.fg_1, c.blue_2) -- current match in wildmenu completion

-- Standard Syntax

hl('Comment', c.fg_2, nil, 'italic')
hl('Constant', c.orange_1)
hl('String', c.blue_0)
li('Character', 'String')
hl('Number', c.blue_1)
hl('Boolean', c.blue_1)
hl('Float', c.blue_1)
hl('Identifier', c.red_1)
hl('Function', c.purple_1)
hl('Statement', c.red_1)
hl('Conditional', c.red_1)
hl('Repeat', c.red_1)
hl('Label', c.purple_1)
hl('Operator', c.blue_1)
hl('Keyword', c.red_1)
hl('Exception', c.red_1)
hl('PreProc', c.red_1)
hl('Include', c.red_1)
hl('Define', c.purple_1)
hl('Macro', c.purple_1)
hl('PreCondit', c.red_1)
hl('Type', c.blue_1)
hl('StorageClass', c.red_1)
hl('Structure', c.orange_1)
hl('Typedef', c.red_1)
hl('Special', c.blue_1)
hl('SpecialChar', c.blue_1)
-- hl('Tag', nil)
hl('Delimiter', c.blue_1)
hl('SpecialComment', c.green_1)
-- hl('Debug', nil)
hl('Bold', nil, nil, 'bold')
hl('Italic', nil, nil, 'italic')
hl('Underlined', nil, nil, 'underline')
-- hl('Ignore', nil)
hl('Error', nil, c.red_3, 'bold')
hl('Todo', c.red_1, nil, 'bold')

-- Diff

hl('DiffAdd', nil, c.green_3)  -- added line
hl('DiffChange', nil, c.yellow_3)  -- changed line
hl('DiffDelete', nil, c.red_3)  -- deleted line
hl('DiffText', nil, c.yellow_3, 'undercurl', c.blue_1)  -- changed text within changed line

li('DiffAdded', 'DiffAdd')
li('DiffRemoved', 'DiffDelete')
hl('DiffFile', c.green_1)
hl('DiffNewFile', c.red_1)
hl('DiffLine', c.blue_1)

-- HTML

hl('htmlTag', c.fg_1)
hl('htmlEndTag', c.fg_1)
hl('htmlLink', c.fg_1)
hl('htmlTagName', c.green_1)
hl('htmlSpecialTagName', c.green_1)

-- Markdown

hl('markdownH1', c.blue_1, nil, 'bold')
hl('markdownH2', c.blue_1, nil, 'bold')
hl('markdownH3', c.blue_1, nil, 'bold')
hl('markdownH4', c.blue_1, nil, 'bold')
hl('markdownLinkText', c.purple_1)
hl('markdownListMarker', c.orange_1)

-- Vim help

hl('helpCommand', c.blue_1)
hl('helpExample', c.blue_1)
hl('helpHeader', c.blue_1, nil, 'bold')
hl('helpHeadline', c.fg_1)
hl('helpHyperTextEntry', c.red_1)
hl('helpHyperTextJump', c.blue_1)
hl('helpOption', c.green_1)
hl('helpSectionDelim', c.blue_1)
hl('helpSpecial', c.purple_1)

-- YAML

hl('yamlBlockMappingKey', c.green_1)
hl('yamlDocumentStart', c.fg_1)
hl('yamlDocumentEnd', c.fg_1)

-- TreeSitter

hl('TSAnnotation', c.blue_1)
hl('TSAttribute', c.blue_1) -- undocumented
li('TSBoolean', 'Boolean')
li('TSCharacter', 'String')
li('TSComment', 'Comment')
li('TSConditional', 'Conditional') -- conditional keywords
li('TSConstant', 'Constant')
hl('TSConstBuiltin', c.blue_1) -- contant built into the langauge (nil for Lua)
hl('TSConstMacro', c.blue_1) -- constants defined by macros (NULL in C)
li('TSConstructor', 'Function') -- constructor calls and definitions ({} in Lua)
li('TSError', 'Error') -- syntax/parser errors
li('TSException', 'Exception') -- exception keywords
hl('TSField', c.fg_1)
li('TSFloat', 'Float')
li('TSFunction', 'Function') -- calls and definitions
li('TSFuncBuiltin', 'Function') -- builtin functions (table.insert in Lua)
hl('TSFuncMacro', c.blue_1) -- macro defined function call and definitions
li('TSInclude', 'Include') -- include and imports
hl('TSKeyword', c.red_1) -- keywords not in other categories
hl('TSKeywordFunction', c.red_1) -- keywords used to define functions
li('TSKeywordOperator', 'Operator') -- operators that are English words (and)
hl('TSLabel', c.blue_1) -- labels (foo: in C)
li('TSMethod', 'Function') -- method calls and definitions
hl('TSNamespace', c.red_1) -- identifiers for modules or namespaces
li('TSNone', 'Normal') -- no highligting
li('TSNumber', 'Number')
hl('TSOperator', c.blue_1) -- operators (+, -, etc and -> and * in C)
hl('TSParameter', c.fg_1) -- parameters of a function
hl('TSParameterReference', c.fg_1) -- references to parameters of a function
hl('TSProperty', c.fg_1) -- same as TSField
hl('TSPunctDelimiter', c.fg_1) -- Delimiters (i.e. .)
hl('TSPunctBracket', c.fg_1) -- brackets and parens
hl('TSPunctSpecial', c.fg_1) -- punctuation not in other categories
li('TSRepeat', 'Repeat') -- keywords related to loops
li('TSString', 'String')
hl('TSStringRegex', 'String') -- regular expressions
hl('TSStringEscape', c.blue_1) -- escape charactes within strings (i.e. \n)
hl('TSTag', c.green_1) -- i.e. html tag names
hl('TSTagDelimiter', c.fg_1) -- tag delimiters (<, >, /)
li('TSText', 'String') -- strings considered text in markup languages
hl('TSStrong', nil, nil, 'bold')
hl('TSEmphasis', nil, nil, 'italic')
hl('TSUnderline', nil, nil, 'underline')
hl('TSStrike', nil, nil, 'strikethrough')
hl('TSTitle', c.blue_1, nil, 'bold') -- text part of title
hl('TSLiteral', c.orange_1) -- literal text
hl('TSURI', c.blue_1) -- URI like link or email
-- hl('TSMath', nil.blue_1) -- latex math
hl('TSTextReference', c.blue_1) -- footnote, text references, citations
-- hl('TSEnviroment', nil) -- text environments of markup langauges
hl('TSNote', c.green_1, nil, 'bold') -- informatinal note (i.e. NOTE:)
hl('TSWarning', c.orange_1, nil, 'bold') -- warning note (i.e. TODO)
hl('TSDanger', c.red_1, nil, 'bold') -- danger note (i.e. FIXME)
hl('TSType', c.fg_1)
hl('TSTypeBuiltin', c.fg_1) -- built in types
-- hl('TSVariable', nil) -- fallback for variable names
-- hl('TSVariableBuiltin', nil) -- built in variables (i.e. this, self)

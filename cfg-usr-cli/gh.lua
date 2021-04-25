-- TODO: look at undercurl/line sp style
-- TODO: spelling with undercurl/sp
-- TODO: make visual and search highlight different
-- TODO: check that all treesitter groups are present
-- TODO: implement non-treesitter per-language settings (matching gh web)
-- TODO: style all vim gui elements

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
	vim.cmd("syntax reset")
end

vim.o.background = "light"
vim.o.termguicolors = true
vim.g.colors_name = "gh"

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

c = {
	fg_1      = '#24292e',
	fg_2      = '#6a737d',
	fg_3      = '#babbbc',
	bg_1      = '#ffffff',
	bg_2      = '#fafbfc',
	bg_3      = '#e1e4e8',
	blue_0    = '#05264c',
	blue_1    = '#032f62',
	blue_2    = '#005cc5',
	blue_3    = '#c8e1ff',
	blue_4    = '#f1f8ff',
	red_1     = '#d73a49',
	red_2     = '#fdb8c0',
	red_3     = '#ffeef0',
	green_1   = '#22863a',
	green_2   = '#acf2bd',
	green_3   = '#e6ffed',
	orange_1  = '#e36209',
	orange_2  = '#fab484',
	purple_1  = '#6f42c1',
	yellow_3  = '#fffbdd',
}

-- Vim Primary Colors

-- Color.new('Red', "#e88388")
-- Color.new('DarkRed', "#e06c75")
-- Color.new('Blue', "#61afef")
-- Color.new('DarkBlue', "#528bff")
-- Color.new('Green', "#98c379")
-- Color.new('DarkGreen', "#50a14f")
-- Color.new('Orange', "#d19a66")
-- Color.new('DarkOrange', "#c18401")
-- Color.new('Yellow', "#e5c07b")
-- Color.new('DarkYellow', "#986801")
-- Color.new('Purple', "#a626a4")
-- Color.new('Violet', '#b294bb')
-- Color.new('Magenta', '#ff80ff')
-- Color.new('DarkMagenta', '#a626a4')
-- Color.new('Black', "#333841")
-- Color.new('Grey', "#636d83")
-- Color.new('White',  '#f2e5bc')
-- Color.new('Cyan', '#8abeb7')
-- Color.new('DarkCyan', '#80a0ff')
-- Color.new('Aqua', '#8ec07c')
-- Color.new('pink', "#d291e4")

-- Vim Terminal

vim.g.terminal_color_0  = c.bg_2
vim.g.terminal_color_8  = c.bg_3
vim.g.terminal_color_1  = c.red_1
vim.g.terminal_color_9  = c.red_1
vim.g.terminal_color_2  = c.green_1
vim.g.terminal_color_10 = c.green_1
vim.g.terminal_color_3  = c.orange_1
vim.g.terminal_color_11 = c.orange_1
vim.g.terminal_color_4  = c.blue_2
vim.g.terminal_color_12 = c.blue_2
vim.g.terminal_color_5  = c.purple_1
vim.g.terminal_color_13 = c.purple_1
vim.g.terminal_color_6  = "#65c2cd"  -- FIXME
vim.g.terminal_color_14 = "#65c2cd"  -- FIXME
vim.g.terminal_color_7  = c.fg_2
vim.g.terminal_color_15 = c.fg_1

-- Editor

hl('Normal',        c.fg_1,    c.bg_1)
hl('bold',          nil,       nil,         'bold')
hl('ColorColumn',   nil,       c.bg_2)
hl('Conceal',       c.fg_3,    c.bg_1)
hl('Cursor',        nil,       c.fg_1)
-- hl('CursorIM',      nil)
hl('CursorColumn',  nil,       c.bg_2)
hl('CursorLine',    nil,       c.bg_2)
hl('Directory',     c.blue_2)
hl('ErrorMsg',      c.red_1)
hl('VertSplit',     c.fg_3)
hl('Folded',        c.fg_3)
hl('FoldColumn',    c.fg_3)
hl('IncSearch',     nil,       c.orange_2)
hl('LineNr',        c.fg_3)
hl('CursorLineNr',  nil,       c.bg_2)
hl('MatchParen',    nil,       c.yellow_3)
hl('Italic',        nil,       nil,         'italic')
hl('ModeMsg',       c.fg_1)
hl('MoreMsg',       c.fg_1)
hl('NonText',       c.fg_3)
hl('PMenu',         nil,       c.bg_2)
hl('PMenuSel',      nil,       c.blue_3)
hl('PMenuSbar',     nil,       c.bg_3)
hl('PMenuThumb',    nil,       c.fg_3)
hl('Question',      c.blue_2)
hl('Search',        nil,       c.yellow_3)
hl('SpecialKey',    c.fg_2)
hl('Whitespace',    c.fg_2)
hl('StatusLine',    c.blue_0,  c.blue_4)
hl('StatusLineNC',  c.fg_2,    c.bg_2)
hl('TabLine',       nil,       c.blue_4)
-- hl('TabLineFill',   nil)
hl('TabLineSel',    nil,       c.blue_3)
hl('Title',         c.fg_1,    nil,         'bold')
hl('Visual',        nil,       c.yellow_3)
hl('VisualNOS',     nil,       c.yellow_3)
hl('WarningMsg',    c.red_1)
hl('TooLong',       c.red_1)
hl('WildMenu',      c.fg_1,    c.blue_3)
-- hl('SignColumn',    nil)

-- Standard Syntax

hl('Comment',         c.fg_2,      nil,      'italic')
hl('Constant',        c.orange_1)
hl('String',          c.blue_1)
li('Character',       'String')
hl('Number',          c.blue_2)
hl('Boolean',         c.blue_2)
hl('Float',           c.blue_2)
hl('Identifier',      c.red_1)
hl('Function',        c.purple_1)
hl('Statement',       c.red_1)
hl('Conditional',     c.red_1)
hl('Repeat',          c.red_1)
hl('Label',           c.purple_1)
hl('Operator',        c.blue_2)
hl('Keyword',         c.red_1)
hl('Exception',       c.red_1)
hl('PreProc',         c.red_1)
hl('Include',         c.red_1)
hl('Define',          c.purple_1)
hl('Macro',           c.purple_1)
hl('PreCondit',       c.red_1)
hl('Type',            c.blue_2)
hl('StorageClass',    c.red_1)
hl('Structure',       c.orange_1)
hl('Typedef',         c.red_1)
hl('Special',         c.blue_2)
hl('SpecialChar',     c.blue_2)
-- hl('Tag',             nil)
hl('Delimiter',       c.blue_2)
hl('SpecialComment',  c.green_1)
-- hl('Debug',           nil)
hl('Underlined',      nil,         nil,      'underline')
-- hl('Ignore',          nil)
hl('Error',           nil,         c.red_3,  'bold')
hl('Todo',            c.red_1,     nil,      'bold')

-- Diff

hl('DiffAdd',     nil,  c.green_3)
hl('DiffChange',  nil,  c.yellow_3)
hl('DiffDelete',  nil,  c.red_3)
hl('DiffText',    nil,  c.yellow_3,  'undercurl')

li('DiffAdded',    'DiffAdd')
li('DiffRemoved',  'DiffDelete')
hl('DiffFile',     c.green_1)
hl('DiffNewFile',  c.red_1)
hl('DiffLine',     c.blue_2)

-- TreeSitter

hl('TSAnnotation',          c.blue_2)
hl('TSAttribute',           c.blue_2)
li('TSBoolean',             'Boolean')
li('TSCharacter',           'String')
li('TSConditional',         'Conditional')
li('TSConstant',            'Constant')
hl('TSConstBuiltin',        c.blue_2)
hl('TSConstMacro',          c.blue_2)
li('TSConstructor',         'Function')
hl('TSEmphasis',            nil,            nil,      'italic')
li('TSError',               'Error')
li('TSException',           'Exception')
-- hl('TSField',               nil)
li('TSFloat',               'Float')
li('TSFunction',            'Function')
li('TSFuncBuiltin',         'Function')
hl('TSFuncMacro',           c.blue_2)
li('TSInclude',             'Include')
hl('TSKeyword',             c.red_1)
hl('TSKeywordFunction',     c.red_1)
li('TSKeywordOperator',     'Operator')
hl('TSLabel',               c.blue_2)
hl('TSLiteral',             c.orange_1)
li('TSMethod',              'Function')
hl('TSNamespace',           c.red_1)
li('TSNumber',              'Number')
-- hl('TSOperator',            nil)
-- hl('TSParameter',           nil)
-- hl('TSParameterReference',  nil)
-- hl('TSProperty',            nil)
-- hl('TSPunctBracket',        nil)
-- hl('TSPunctDelimiter',      nil)
-- hl('TSPunctSpecial',        nil)
li('TSRepeat',              'Repeat')
li('TSString',              'String')
hl('TSStringEscape',        c.blue_2)
hl('TSStringRegex',         'String')
hl('TSStrong',              nil,            nil,      'bold')
li('TSStructure',           'Structure')
hl('TSTag',                 c.green_1)
-- hl('TSTagDelimiter',        nil)
-- hl('TSText',                nil)
hl('TSTitle',               c.blue_2,       nil,      'bold')
hl('TSType',                c.orange_1)
hl('TSTypeBuiltin',         c.orange_1)
hl('TSUnderline',           nil,            nil,      'underline')
hl('TSURI',                 c.blue_2)
-- hl('TSVariable',            nil)
-- hl('TSVariableBuiltin',     nil)

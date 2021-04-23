-- Based on OneBuddy, but with Github colors. Work in progress.

local Color, c, Group, g, s = require("colorbuddy").setup()
local b = s.bold
local i = s.italic
local n = s.inverse
local uc = s.undercurl
local ul = s.underline
local r = s.reverse
local sto = s.standout
local no = s.NONE
local v = vim

Color.new('fg_1',  '#24292e')
Color.new('fg_2',  '#6a737d')
Color.new('fg_3',  '#babbbc')
Color.new('bg_1',  '#ffffff')
Color.new('bg_2',  '#fafbfc')
Color.new('bg_3',  '#e1e4e8')
Color.new('blue_0', '#05264c')
Color.new('blue_1', '#032f62')
Color.new('blue_2', '#005cc5')
Color.new('blue_3', '#c8e1ff')
Color.new('blue_4', '#f1f8ff')
Color.new('red_1', '#d73a49')
Color.new('red_2', '#fdb8c0')
Color.new('red_3', '#ffeef0')
Color.new('green_1', '#22863a')
Color.new('green_2', '#acf2bd')
Color.new('green_3', '#e6ffed')
Color.new('orange_1', '#e36209')
Color.new('orange_2', '#fab484')
Color.new('purple_1', '#6f42c1')
Color.new('yellow_3', '#fffbdd')


Color.new('mono_3', "#a0a1a7")
Color.new('hue_1', "#0184bc")
Color.new('hue_2', "#4078f2")
Color.new('hue_3', "#a626a4")
Color.new('hue_4', "#50a14f")
Color.new('hue_5', "#e45649")
Color.new('hue_6', "#986801")
Color.new('hue_6_2', "#c18401")
Color.new('syntax_cursor', "#f0f0f0")
Color.new('syntax_accent', "#526fff")
Color.new('special_grey', "#d3d3d3")
Color.new('visual_grey', "#d0d0d0")

local italics = (function()
    if vim.g.onebuddy_disable_italics ~= true then
        return  i
    else
        return  no
    end
end)()

-------------------------
-- Vim Primary Colors --
-------------------------
Color.new('Red', "#e88388")
Color.new('DarkRed', "#e06c75")
Color.new('Blue', "#61afef")
Color.new('DarkBlue', "#528bff")
Color.new('Green', "#98c379")
Color.new('DarkGreen', "#50a14f")
Color.new('Orange', "#d19a66")
Color.new('DarkOrange', "#c18401")
Color.new('Yellow', "#e5c07b")
Color.new('DarkYellow', "#986801")
Color.new('Purple', "#a626a4")
Color.new('Violet', '#b294bb')
Color.new('Magenta', '#ff80ff')
Color.new('DarkMagenta', '#a626a4')
Color.new('Black', "#333841")
Color.new('Grey', "#636d83")
Color.new('White',  '#f2e5bc')
Color.new('Cyan', '#8abeb7')
Color.new('DarkCyan', '#80a0ff')
Color.new('Aqua', '#8ec07c')
-- Color.new('pink', "#d291e4")

-------------------------
-- Vim Terminal Colors --
-------------------------

v.g.terminal_color_0  = "#353a44"
v.g.terminal_color_8  = "#353a44"
v.g.terminal_color_1  = "#e88388"
v.g.terminal_color_9  = "#e88388"
v.g.terminal_color_2  = "#a7cc8c"
v.g.terminal_color_10 = "#a7cc8c"
v.g.terminal_color_3  = "#ebca8d"
v.g.terminal_color_11 = "#ebca8d"
v.g.terminal_color_4  = "#72bef2"
v.g.terminal_color_12 = "#72bef2"
v.g.terminal_color_5  = "#d291e4"
v.g.terminal_color_13 = "#d291e4"
v.g.terminal_color_6  = "#65c2cd"
v.g.terminal_color_14 = "#65c2cd"
v.g.terminal_color_7  = "#e3e5e9"
v.g.terminal_color_15 = "#e3e5e9"

----------------------
-- Vim Editor Color --
----------------------

Group.new('Normal',        c.fg_1,          c.bg_1,           no)
Group.new('bold',          c.none,          c.none,           b)
Group.new('ColorColumn',   c.none,          c.bg_2,  no)
Group.new('Conceal',       c.fg_3,          c.bg_1,           no)
Group.new('Cursor',        c.none,          c.syntax_accent,  no)
Group.new('CursorIM',      c.none,          c.none,           no)
Group.new('CursorColumn',  c.none,          c.syntax_cursor,  no)
Group.new('CursorLine',    c.none,          c.syntax_cursor,  no)
Group.new('Directory',     c.blue_2,        c.none,           no)
Group.new('ErrorMsg',      c.red_1,         c.none,           no)
Group.new('VertSplit',     c.fg_3,          c.none,           no)
Group.new('Folded',        c.mono_3,        c.none,           no)
Group.new('FoldColumn',    c.mono_3,        c.syntax_cursor,  no)
Group.new('IncSearch',     c.none,          c.orange_2,          no)
Group.new('LineNr',        c.fg_3,          c.none,           no)
Group.new('CursorLineNr',  c.fg_1,          c.syntax_cursor,  no)
Group.new('MatchParen',    c.none,          c.yellow_3,        no)
Group.new('Italic',        c.none,          c.none,           italics)
Group.new('ModeMsg',       c.fg_1,          c.none,           no)
Group.new('MoreMsg',       c.fg_1,          c.none,           no)
Group.new('NonText',       c.mono_3,        c.none,           no)
Group.new('PMenu',         c.none,          c.bg_2,           no)
Group.new('PMenuSel',      c.none,          c.blue_3,         no)
Group.new('PMenuSbar',     c.none,          c.bg_3,           no)
Group.new('PMenuThumb',    c.none,          c.fg_3,           no)
Group.new('Question',      c.blue_2,        c.none,           no)
Group.new('Search',        c.none,          c.yellow_3,         no)
Group.new('SpecialKey',    c.special_grey,  c.none,           no)
Group.new('Whitespace',    c.special_grey,  c.none,           no)
Group.new('StatusLine',    c.blue_0,        c.blue_4,         no)
Group.new('StatusLineNC',  c.fg_2,          c.bg_2,           no)
Group.new('TabLine',       c.none,          c.blue_4,         no)
Group.new('TabLineFill',   c.none,          c.none,           no)
Group.new('TabLineSel',    c.none,          c.blue_3,         no)
Group.new('Title',         c.fg_1,          c.none,           b)
Group.new('Visual',        c.none,          c.yellow_3,       no)
Group.new('VisualNOS',     c.none,          c.yellow_3,       no)
Group.new('WarningMsg',    c.red_1,         c.none,           no)
Group.new('TooLong',       c.red_1,         c.none,           no)
Group.new('WildMenu',      c.fg_1,          c.mono_3,         no)
Group.new('SignColumn',    c.none,          c.none,           no)

----------------------------------
-- Standard Syntax Highlighting --
----------------------------------

Group.new('Comment',        c.fg_2,        c.none, italics)
Group.new('Constant',       c.orange_1,         c.none, no)
Group.new('String',         c.blue_1,         c.none, no)
Group.new('Character',      g.String,         c.none, no)
Group.new('Number',         c.blue_2,         c.none, no)
Group.new('Boolean',        c.blue_2,         c.none, no)
Group.new('Float',          c.blue_2,         c.none, no)
Group.new('Identifier',     c.hue_5,         c.none, no)
Group.new('Function',       c.purple_1,         c.none, no)
Group.new('Statement',      c.red_1,         c.none, no)
Group.new('Conditional',    c.red_1,         c.none, no)
Group.new('Repeat',         c.red_1,         c.none, no)
Group.new('Label',          c.hue_3,         c.none, no)
Group.new('Operator',       c.blue_2,        c.none, no)
Group.new('Keyword',        c.hue_5,         c.none, no)
Group.new('Exception',      c.red_1,         c.none, no)
Group.new('PreProc',        c.hue_6_2,       c.none, no)
Group.new('Include',        c.red_1,         c.none, no)
Group.new('Define',         c.purple_1,         c.none, no)
Group.new('Macro',          c.hue_3,         c.none, no)
Group.new('PreCondit',      c.hue_6_2,       c.none, no)
Group.new('Type',           c.blue_2,       c.none, no)
Group.new('StorageClass',   c.red_1,       c.none, no)
Group.new('Structure',      c.orange_1,       c.none, no)
Group.new('Typedef',        c.red_1,       c.none, no)
Group.new('Special',        c.blue_2,         c.none, no)
Group.new('SpecialChar',    c.blue_2,          c.none, no)
Group.new('Tag',            c.none,          c.none, no)
Group.new('Delimiter',      c.blue_2,          c.none, no)
Group.new('SpecialComment', c.green_1,          c.none, no)
Group.new('Debug',          c.none,          c.none, no)
Group.new('Underlined',     c.none,          c.none, ul)
Group.new('Ignore',         c.none,          c.none, no)
Group.new('Error',          c.hue_5,         c.mono_3,    b)
Group.new('Todo',           c.hue_3,         c.mono_3,    no)

-----------------------
-- Diff Highlighting --
-----------------------

Group.new('DiffAdd',     c.none, c.green_3, no)
Group.new('DiffChange',  c.none, c.yellow_3, no)
Group.new('DiffDelete',  c.none, c.red_3, no)
Group.new('DiffText',    c.none, c.yellow_3, uc)

Group.new('DiffAdded',   c.none, g.DiffAdd, no)
Group.new('DiffRemoved', c.none, g.DiffDelete, no)
Group.new('DiffFile',    c.green_1, c.none, no)
Group.new('DiffNewFile', c.red_1, c.none, no)
Group.new('DiffLine',    c.blue_2, c.none, no)

-----------------------------
-- TreeSitter Highlighting --
-----------------------------
Group.new('TSAnnotation',         c.hue_6_2, c.none, no)
Group.new('TSAttribute',          c.hue_1, c.none, no)
Group.new('TSBoolean',            g.Boolean, c.none, no)
Group.new('TSCharacter',          g.String, c.none, no)
Group.new('TSConditional',        g.Conditional, c.none, no)
Group.new('TSConstant',           g.Constant, c.none, no)
Group.new('TSConstBuiltin',       c.blue_2, c.none, no)
Group.new('TSConstMacro',         c.hue_1, c.none, no)
Group.new('TSConstructor',        g.Function, c.none, no)
Group.new('TSEmphasis',           c.hue_6_2, c.none, no)
Group.new('TSError',              c.hue_5, c.none, no)
Group.new('TSException',          g.Exception, c.none, no)
Group.new('TSField',              c.fg_1, c.none, no)
Group.new('TSFloat',              g.Float, c.none, no)
Group.new('TSFunction',           g.Function, c.none, no)
Group.new('TSFuncBuiltin',        g.Function, c.none, no)
Group.new('TSFuncMacro',          c.hue_6_2, c.none, no)
Group.new('TSInclude',            g.Include, c.none, no)
Group.new('TSKeyword',            c.red_1, c.none, no)
Group.new('TSKeywordFunction',    c.red_1, c.none, no)
Group.new('TSKeywordOperator',    g.Operator, c.none, no)
Group.new('TSLabel',              c.hue_2, c.none, no)
Group.new('TSLiteral',            c.hue_6_2, c.none, no)
Group.new('TSMethod',             g.Function, c.none, no)
Group.new('TSNamespace',          c.red_1, c.none, no)
Group.new('TSNumber',             g.Number, c.none, no)
Group.new('TSOperator',           c.fg_1, c.none, no)
Group.new('TSParameter',          c.fg_1, c.none, no)
Group.new('TSParameterReference', c.hue_1, c.none, no)
Group.new('TSProperty',           c.fg_1, c.none, no)
Group.new('TSPunctBracket',       c.fg_1, c.none, no)
Group.new('TSPunctDelimiter',     c.fg_1, c.none, no)
Group.new('TSPunctSpecial',       c.fg_1, c.none, no)
Group.new('TSRepeat',             g.Repeat, c.none, no)
Group.new('TSString',             g.String, c.none, no)
Group.new('TSStringEscape',       c.hue_1, c.none, no)
Group.new('TSStringRegex',        c.hue_4, c.none, no)
Group.new('TSStrong',             c.hue_6_2, c.none, no)
Group.new('TSStructure',          g.Structure, c.none, no)
Group.new('TSTag',                c.hue_5, c.none, no)
Group.new('TSTagDelimiter',       c.mono_3, c.none, no)
Group.new('TSText',               c.hue_6_2, c.none, no)
Group.new('TSTitle',              c.hue_6_2, c.none, no)
Group.new('TSType',               c.orange_1, c.none, no)
Group.new('TSTypeBuiltin',        c.hue_2, c.none, no)
Group.new('TSUnderline',          c.hue_6_2, c.none, no)
Group.new('TSURI',                c.hue_6_2, c.none, no)
Group.new('TSVariable',           c.fg_1, c.none, no)
Group.new('TSVariableBuiltin',    c.fg_1, c.none, no)

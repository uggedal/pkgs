local util = require('util')

--
-- General
--

if vim.fn.isdirectory(vim.o.undodir) == 0 then
	vim.fn.mkdir(vim.o.undodir, 'p')
end

-- Save undo history to file (enables undo between sessions):
vim.bo.undofile = true

-- Show line numbers:
vim.wo.number = true

-- Highlight column number 80:
vim.wo.colorcolumn = '80'

-- Break lines when wrapping at punctuation:
vim.wo.linebreak = true

-- Visually indent each wrapped line:
vim.wo.breakindent = true

-- Disable intro messages when starting vim without a file:
vim.o.shortmess= vim.o.shortmess .. 'I'

-- Ignore case when searching with all lowercase queries:
vim.o.ignorecase = true
vim.o.smartcase = true

-- Substitute all matches on a line:
vim.o.gdefault = true

-- Live preview of substitutions:
vim.o.inccommand = 'split'

-- Completion settings with consecurive presses of TAB:
--   1. Complete till longest common string
--   2. When more than one match, list all matches
--   3. Complete next full match. After last match, the original string is used.
vim.o.wildmode = 'longest,list,full'

-- Keep some lines above and below cursor:
vim.o.scrolloff = 3

-- Allow placing the curser where there is no character in visual block mode:
vim.o.virtualedit = 'block'

-- Wait 10ms for a key code or mapped key sequence to complete:
vim.o.timeout = false
vim.o.ttimeoutlen = 10

-- Do not ask when moving from a buffer with unsaved changes:
vim.o.hidden = true

-- Highlight the line of the cursor only in insert mode:
vim.cmd([[
	augroup ToggleCursorLine
		autocmd!
		autocmd InsertLeave * set nocursorline
		autocmd InsertEnter * set cursorline
	augroup END
]])

--
-- Key bindings
--

-- Disable movement with cursor keys:
for _, k in ipairs({'up', 'down', 'left', 'right'}) do
	util.map('n', '<' .. k .. '>', '<nop>')
	util.map('i', '<' .. k .. '>', '<nop>')
end

-- Disable man page lookup of word under cursor with K key:
util.map('n', 'K', '<nop>')

-- Disable tab cycling keys:
util.map('n', 'gT', '<nop>')
util.map('n', 'gt', '<nop>')

-- Move up/down by display lines when long lines wrap:
util.map('n', 'j', 'gj')
util.map('n', 'k', 'gk')

-- Shorter bindings for split navigation:
for _, k in ipairs({'h', 'j', 'k', 'l'}) do
	util.map('n', '<C-' .. k .. '>', '<C-w>' .. k)
end

-- Keep search matches in the middle of the window:
for _, k in ipairs({'*', '#', 'n', 'N'}) do
	util.map('n', k, k .. 'zzzv')
end

vim.g.mapleader = ','

-- Convenience leader mappings for working with buffers:
util.map('n', '<leader>p', ':bp<CR>')
util.map('n', '<leader>n', ':bn<CR>')
util.map('n', '<leader>d', ':bd<CR>')

-- Convenience leader mapping for toggling paste mode (no auto indent):
util.map('n', '<leader>i', ':set invpaste<CR>')

-- Convenience leader mapping for opening file based on current file's path:
util.map('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- git sync commit leader binding:
function _G.gitci()
       vim.cmd([[!cd %:p:h && git add . && git ci -am sync && git push]])
end
util.map('n', '<leader>gc', ':call v:lua.gitci(4)<CR>')

--
-- Color scheme
--

vim.o.background = 'light'
vim.cmd('colorscheme gh')

-- Highlight trailing space when not in insert mode:
vim.cmd('augroup HighlightTrailing')
vim.cmd('  autocmd!')
vim.cmd('  autocmd BufNewFile,BufRead * highlight trail_space guibg=' .. vim.g.terminal_color_1)
vim.cmd('  autocmd InsertEnter * highlight trail_space guibg=NONE')
vim.cmd('  autocmd InsertLeave * highlight trail_space guibg=' .. vim.g.terminal_color_1)
vim.cmd([[  autocmd BufNewFile,BufRead * match trail_space /\s\+$/]])
vim.cmd('augroup END')

--
-- Languages
--

function _G.spaces(n)
	vim.bo.expandtab = true
	vim.bo.softtabstop = n
	vim.bo.tabstop = n
	vim.bo.shiftwidth = n
	vim.o.shiftround = true
end

-- Setup different levels of space based indent for some syntaxes:
vim.cmd([[
	augroup SpacesOrTabs
		autocmd!
		autocmd FileType python,lua,html,jinja.html,css,markdown call v:lua.spaces(4)
		autocmd FileType yaml call v:lua.spaces(2)
	augroup END
]])

-- Textfiles should be broken to a limited width:
vim.cmd([[
	augroup TextWidth
		autocmd!
		autocmd FileType mail,markdown setlocal textwidth=72
	augroup END
]])

-- Textfiles should not have line numbering
vim.cmd([[
	augroup NoNumber
		autocmd!
		autocmd FileType mail,markdown setlocal nonumber
	augroup END
]])

--
-- Spell
--

vim.bo.spelllang = 'en'
vim.cmd([[
	augroup Spelling
		autocmd!
		autocmd FileType markdown setlocal spelllang=en,nb
		autocmd FileType gitcommit,mail,markdown setlocal spell
	augroup END
]])

--
-- Plugins
--

require'diary'.setup()

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	}
}

require'buftabline'.setup {
	auto_hide = true,
	hlgroup_normal = 'TabLine'
}

require'colorizer'.setup({}, {
	names = false
})

require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true,
})

-- Telescope bindings
util.telmap('ff', 'find_files')
util.telmap('fg', 'live_grep')
util.telmap('fl', 'file_browser')
util.telmap('b', 'buffers')
util.telmap('h', 'help_tags')
util.telmap('s', 'spell_suggest')
util.telmap('gL', 'git_commits')
util.telmap('gl', 'git_bcommits')
util.telmap('gb', 'git_branches')
util.telmap('gs', 'git_status')

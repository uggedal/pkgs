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
vim.cmd('augroup ToggleCursorLine')
vim.cmd('  autocmd!')
vim.cmd('  autocmd InsertLeave * set nocursorline')
vim.cmd('  autocmd InsertEnter * set cursorline')
vim.cmd('augroup END')

--
-- Key bindings
--

local function map(mode, lhs, rhs, opts)
	local options = {noremap = true}
	if opts then options = vim.tbl_extend('force', options, opts) end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Disable movement with cursor keys:
for _, k in ipairs({'up', 'down', 'left', 'right'}) do
	map('n', '<' .. k .. '>', '<nop>')
	map('i', '<' .. k .. '>', '<nop>')
end

-- Disable man page lookup of word under cursor with K key:
map('n', 'K', '<nop>')

-- Disable tab cycling keys:
map('n', 'gT', '<nop>')
map('n', 'gt', '<nop>')

-- Move up/down by display lines when long lines wrap:
map('n', 'j', 'gj')
map('n', 'k', 'gk')

-- Shorter bindings for split navigation:
for _, k in ipairs({'h', 'j', 'k', 'l'}) do
	map('n', '<C-' .. k .. '>', '<C-w>' .. k)
end

-- Keep search matches in the middle of the window:
for _, k in ipairs({'*', '#', 'n', 'N'}) do
	map('n', k, k .. 'zzzv')
end

vim.g.mapleader = ','

-- Convenience leader mappings for working with buffers:
map('n', '<leader>p', ':bp<CR>')
map('n', '<leader>n', ':bn<CR>')
map('n', '<leader>d', ':bd<CR>')

-- Convenience leader mapping for toggling paste mode (no auto indent):
map('n', '<leader>i', ':set invpaste<CR>')

-- Convenience leader mapping for opening file based on current file's path:
map('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>')

-- git sync commit leader binding:
function _G.gitci()
       vim.cmd([[!cd %:p:h && git add . && git ci -am sync && git push]])
end
map('n', '<leader>g', ':call v:lua.gitci(4)<CR>')

--
-- Color scheme
--

vim.o.background = 'dark'
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
vim.cmd('augroup SpacesOrTabs')
vim.cmd('  autocmd!')
vim.cmd('  autocmd FileType python,html,jinja.html,css,markdown,vimwiki call v:lua.spaces(4)')
vim.cmd('  autocmd FileType yaml call v:lua.spaces(2)')
vim.cmd('augroup END')

-- Textfiles should be broken to a limited width:
vim.cmd('augroup TextWidth')
vim.cmd('  autocmd!')
vim.cmd('  autocmd FileType mail,markdown,vimwiki setlocal textwidth=72')
vim.cmd('augroup END')

-- Textfiles should not have line numbering
vim.cmd('augroup NoNumber')
vim.cmd('  autocmd!')
vim.cmd('  autocmd FileType mail,markdown,vimwiki setlocal nonumber')
vim.cmd('augroup END')

--
-- Plugins
--

require'nvim-treesitter.configs'.setup {
	highlight = {
		enable = true
	}
}

require'bufferline'.setup {
	options = {
		numbers = 'buffer_id',
		number_style = 'none',
		show_buffer_close_icons = false,
		show_close_icon = false,
		show_tab_indicators = false
	},
	highlights = {
		buffer_selected = {
			gui = 'bold'
		}
	}
}

require'colorizer'.setup()

require('kommentary.config').configure_language('default', {
    prefer_single_line_comments = true,
})

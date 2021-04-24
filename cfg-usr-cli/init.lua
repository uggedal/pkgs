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

-- Disable movement with cursor keys:
for _, k in ipairs({'up', 'down', 'left', 'right'}) do
	vim.api.nvim_set_keymap('n', '<' .. k .. '>', '<nop>', { noremap = true })
	vim.api.nvim_set_keymap('i', '<' .. k .. '>', '<nop>', { noremap = true })
end

-- Disable man page lookup of word under cursor with K key:
vim.api.nvim_set_keymap('n', 'K', '<nop>', { noremap = true })

-- Disable tab cycling keys:
vim.api.nvim_set_keymap('n', 'gT', '<nop>', { noremap = true })
vim.api.nvim_set_keymap('n', 'gt', '<nop>', { noremap = true })

-- Move up/down by display lines when long lines wrap:
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true })

-- Shorter bindings for split navigation:
for _, k in ipairs({'h', 'j', 'k', 'l'}) do
	vim.api.nvim_set_keymap('n', '<C-' .. k .. '>', '<C-w>' .. k, { noremap = true })
end

-- Keep search matches in the middle of the window:
for _, k in ipairs({'*', '#', 'n', 'N'}) do
	vim.api.nvim_set_keymap('n', k, k .. 'zzzv', { noremap = true })
end

vim.g.mapleader = ','

-- Convenience leader mappings for working with buffers:
vim.api.nvim_set_keymap('n', '<leader>p', ':bp<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>n', ':bn<CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>d', ':bd<CR>', { noremap = true })

-- Convenience leader mapping for toggling paste mode (no auto indent):
vim.api.nvim_set_keymap('n', '<leader>i', ':set invpaste<CR>', { noremap = true })

-- Convenience leader mapping for opening file based on current file's path:
vim.api.nvim_set_keymap('n', '<leader>e', ':e <C-R>=expand("%:p:h") . "/" <CR>', { noremap = true })

-- git sync commit leader binding:
function _G.gitci()
       vim.cmd([[!cd %:p:h && git add . && git ci -am sync && git push]])
end
vim.api.nvim_set_keymap('n', '<leader>g', ':call v:lua.gitci(4)<CR>', { noremap = true })

--
-- Color scheme
--

require('colorbuddy').colorscheme('gh', true)

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

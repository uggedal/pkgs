local util = require('util')

require'lspconfig'.pyls.setup{}

vim.cmd([[
	augroup LspFormat
		autocmd!
		autocmd FileType python autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
	augroup END
]])

util.telmap('lr', 'lsp_references')
util.telmap('ld', 'lsp_definitions')

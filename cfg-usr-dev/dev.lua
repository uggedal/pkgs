local lspconf = require('lspconfig')

local on_attach = function(client, bufnr)
    local function bufmap(keys, cmd)
        local opts = {noremap = true, silent = true}
        vim.api.nvim_buf_set_keymap(bufnr, 'n', keys, cmd, opts)
    end

    local function buftelmap(keys, cmd)
        bufmap(keys, "<cmd>lua require('telescope.builtin')." .. cmd .. '()<cr>')
    end

    local function buflspmap(keys, cmd)
        bufmap(keys, "<cmd>lua vim.lsp." .. cmd .. '()<cr>')
    end

    buftelmap('gr', 'lsp_references')
    buftelmap('gd', 'lsp_definitions')
    buftelmap('gd', 'lsp_definitions')
    buflspmap('gD', 'buf.declaration')
    buflspmap('gi', 'buf.implementation')
    buflspmap('K', 'buf.hover')
    buflspmap('<leader>rn', 'buf.rename')
    buflspmap('<leader>ca', 'buf.code_action')

    if client.resolved_capabilities.document_formatting then
        vim.cmd([[
			augroup LspFormat
				autocmd! * <buffer>
				autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil, 1000)
			augroup END
		]])
    end
end

lspconf.pyls.setup {on_attach = on_attach}

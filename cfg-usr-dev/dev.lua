local util = require('util')

--
-- LSP
--

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

lspconf.sumneko_lua.setup {
    cmd = {'/usr/bin/lua-language-server'},
    on_attach = on_attach,
    settings = {
        Lua = {
            runtime = {version = 'LuaJIT', path = vim.split(package.path, ';')},
            diagnostics = {globals = {'vim'}},
            workspace = {
                library = {
                    [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                    [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true
                }
            },
            telemetry = {enable = false}
        }
    }
}

lspconf.bashls.setup {filetypes = {'sh', 'PKGBUILD'}}

local function shcfg(ignores)
    return {
        {formatCommand = 'shfmt -ci -s -bn', formatStdin = true}, {
            lintCommand = 'shellcheck -f gcc -x -e ' ..
                table.concat(ignores, ','),
            lintSource = '',
            lintFormats = {
                '%f:%l:%c: %trror: %m', '%f:%l:%c: %tarning: %m',
                '%f:%l:%c: %tote: %m'
            }
        }
    }
end

lspconf.efm.setup {
    on_attach = on_attach,
    init_options = {documentFormatting = true},
    filetypes = {'lua', 'sh', 'PKGBUILD'},
    rootMarkers = {'.git/'},
    settings = {
        languages = {
            lua = {{formatCommand = 'lua-format -i', formatStdin = true}},
            sh = shcfg({'SC2086', 'SC2231', 'SC1091', 'SC1090'}),
            PKGBUILD = shcfg({'SC2034', 'SC2148', 'SC2154', 'SC2164'})
        }
    }
}

--
-- Completion
--

vim.o.completeopt = 'menuone,noselect'

-- require'compe'.setup {debug = true, source = {path = true, buffer = true}}

require'compe'.setup {
    autocomplete = false,
    documentation = false,
    source = {
        path = true,
        buffer = true,
        spell = {filetypes = {'markdown'}},
        nvim_lsp = true,
        nvim_treesitter = {ignored_filetypes = {'lua', 'python', 'sh'}}
    }
}

util.map('i', '<C-Space>', 'compe#complete()', {silent = true, expr = true})
util.map('i', '<CR>', "compe#confirm('<CR>')", {silent = true, expr = true})
util.map('i', '<C-e>', "compe#close('<C-e>')", {silent = true, expr = true})

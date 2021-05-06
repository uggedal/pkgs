local M = {}

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.telmap(keys, cmd)
    M.map('n', '<leader>' .. keys,
          "<cmd>lua require('telescope.builtin')." .. cmd .. "()<cr>")
end

return M

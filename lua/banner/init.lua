local M = {}

M._stack = {}

M.comment = function()
    local line = vim.api.nvim_get_current_line()
    local comment_line = "-- " .. line
    vim.api.nvim_set_current_line(comment_line)
end

M.uncomment = function()
    local line = vim.api.nvim_get_current_line()
    local comment_line = line:sub(4)
    vim.api.nvim_set_current_line(comment_line)
end

M.clear = function()
    M._stack = {}
end

vim.api.nvim_create_user_command('CommentLine', M.comment, {})
vim.api.nvim_create_user_command('UncommentLine', M.uncomment, {})

return M

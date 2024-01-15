local M = {}
local static = require('static')
local utils = require('utils')
local core = require('core')


M.setup = function(new_config)

end


local M.check_log = function()
    local bufnr = vim.api.nvim_create_buf(false,true)
    core.win.proportional_size( static.config.win.width_ratio, static.config.win.height_ratio )

    -- check the logs
    local file_name = vim.api.nvim_buf_get_name(0)
    local line_range = utils.range()
    local extra_args = core.lua.list.reduce(static.config.extra_args, function(acc, arg)
        return acc .. " " .. arg
    end, "")
    local log = vim.api.nvim_exec2(
        string.format("!git log %s -L %s,%s,%s", extra_args, line_range[1], line_range[2], file_name),
        { output = true }
    )

    -- format log

end

return M

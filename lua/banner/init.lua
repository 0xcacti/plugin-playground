local M = {}
local static = require('banner.static')
local utils = require('banner.utils')
local core = require('core')


M.setup = function(new_config)

end


M.check_log = function()
    local bufnr = vim.api.nvim_create_buf(false, true)
    local window_size = core.win.proportional_size(static.config.win.width_ratio, static.config.win.height_ratio)

    -- check the logs
    local file_name = vim.api.nvim_buf_get_name(0)
    local line_range = utils.range()
    local extra_args = core.lua.list.reduce(static.config.extra_args, function(acc, arg)
        return acc .. " " .. arg
    end, "")
    local log = vim.api.nvim_exec2(
        string.format("!git log %s -L %s,%s:%s", extra_args, line_range[1], line_range[2], file_name),
        { output = true }
    )

    log = core.lua.string.split(log.output, "\n")
    log = core.lua.list.filter(log, function(_, i)
        return i ~= 1 and i ~= 2
    end)

    local new_log = {}
    local first_commit = true

    for i = 1, table.maxn(log), 1 do
        if string.match(log[i], "^commit") then
            if first_commit then
                first_commit = false
            else
                table.insert(new_log, utils.separator(window_size.width))
            end
        end
        table.insert(new_log, log[i])
    end

    log = new_log

    -- format log
    for key, value in pairs(log) do
        print(key, value)
    end


    core.win.open_float(bufnr, {
        enter = true,
        relative = "editor",
        width = window_size.width,
        height = window_size.height,
        row = window_size.row,
        col = window_size.col,
        border = static.config.win.border,
        title = "git log",
        style = "minimal",
        title_pos = "center",
    })

    vim.api.nvim_set_option_value("modifiable", true, {
        buf = bufnr,
    })

    vim.api.nvim_set_option_value("filetype", "git" < {
        buf = bufnr,
    })

    vim.keymap.set("n", static.config.keymap.close, function()
        pcall(vim.api.nvim_buf_delete, bufnr, {
            force = true,
        })
    end, {
        buffer = bufnr,
    })
end

vim.api.nvim_create_user_command("GL", M.check_log, {})

return M

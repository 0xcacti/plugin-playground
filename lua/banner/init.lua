local M = {}

M.setup = function()
    print("penis")
end

local find_mapping = function(maps, lhs)
    for _, value in ipairs(maps) do
        if value.lhs == lhs then
            return value
        end
    end
end

M._stack = {}

M.push = function(name, mode, mappings)
    local maps = vim.api.nvim_get_keymap(mode)
    local existing_maps = {}
    for lhs, rhs in pairs(mappings) do
        local existing = find_mapping(maps, lhs)
        if existing then
            table.insert(existing_maps, existing)
        end
    end
    P(existing_maps)
    M._stack = existing_maps
    for lhs, rhs in pairs(mappings) do
        vim.keymap.set(mode, lhs, rhs)
    end
end

M.push("debug_mode", "n", {
    [" st"] = "echo 'Hello'",
    [" sz"] = "echo 'Hello'",
})

M.pop = function(name)
end

return M


--

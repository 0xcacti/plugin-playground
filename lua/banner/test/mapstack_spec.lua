local find_mapping = function(maps, lhs)
    for _, value in ipairs(maps) do
        if value.lhs == lhs then
            return value
        end
    end
end
describe("banner", function()
    it("can be required", function()
        require("banner")
    end)

    it("can push a single mapping", function()
        local rhs = "echo 'This is a test'"
        require("banner").push("test1", "n", {
            aoeuaoeu = rhs,
        })
        local maps = vim.api.nvim_get_keymap("n")
        local found = find_mapping(maps, "aoeuaoeu")
        assert.are.same(rhs, found.rhs)
    end)

    it("can push a multiple mapping", function()
        local rhs = "echo 'This is a test'"
        require("banner").push("test1", "n", {
            aoeuaoeu = rhs .. "1",
            aoeuaoeu2 = rhs .. "2",
        })
        local maps = vim.api.nvim_get_keymap("n")
        local found = find_mapping(maps, "aoeuaoeu")
        assert.are.same(rhs .. '1', found.rhs)
        found = find_mapping(maps, "aoeuaoeu2")
        assert.are.same(rhs .. '2', found.rhs)
    end)
end)

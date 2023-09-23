local find_mapping = function(lhs)
    local maps = vim.api.nvim_get_keymap("n")
    for _, value in ipairs(maps) do
        if value.lhs == lhs then
            return value
        end
    end
end
describe("banner", function()
    before_each(function()
        require("banner").clear()
        pcall(vim.keymap.del, "n", "aoeuaoeu")
    end)

    it("can be required", function()
        require("banner")
    end)

    it("can push a single mapping", function()
        local rhs = "echo 'This is a test'"
        require("banner").push("test1", "n", {
            aoeuaoeu = rhs,
        })
        local found = find_mapping("aoeuaoeu")
        assert.are.same(rhs, found.rhs)
    end)

    it("can push a multiple mapping", function()
        local rhs = "echo 'This is a test'"
        require("banner").push("test1", "n", {
            aoeuaoeu = rhs .. "1",
            aoeuaoeu2 = rhs .. "2",
        })
        local found = find_mapping("aoeuaoeu")
        assert.are.same(rhs .. '1', found.rhs)
        found = find_mapping("aoeuaoeu2")
        assert.are.same(rhs .. '2', found.rhs)
    end)

    it('can delete mappings after pop: no existing', function()
        local rhs = "echo 'This is a test'"
        require("banner").push("test1", "n", {
            aoeuaoeu = rhs,
        })

        local found = find_mapping("aoeuaoeu")
        assert.are.same(rhs, found.rhs)

        require("banner").pop("test1", "n")
        local after_pop = find_mapping("asdfasdf")
        assert.are.same(nil, after_pop)
    end)
end)

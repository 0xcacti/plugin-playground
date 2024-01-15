describe("banner", function()
    it("can be required", function()
        require("banner")
    end)

    it("it logs", function()
        require("banner").check_log()
    end)
end)

describe("banner", function()
    it("can be required", function()
        require("banner")
    end)

    it("it logs", function()
        local gl = require("banner")
        gl.check_log()
    end)
end)

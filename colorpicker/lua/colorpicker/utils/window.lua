local M = {}
local utils = require("colorpicker.utils")

--- Setup the window on init

local win = nil
local buf = nil
local ns = vim.api.nvim_create_namespace("colorpicker")
local user_mappings = {}

-- Set configurables

M.user_setting = {
    ["icons"] = { "ﱢ", "" },
    ["border"] = "rounded",
    ["background_highlight_group"] = "Normal",
    ["border_highlight_group"] = "FloatBorder",
    ["text_highlight_group"] = "Normal",
}

----------------------------------------


vim.cmd(":highlight ColorPickerFloat guifg=#white")
vim.cmd(":highlight ColorPickerActionGroup guifg=#00F1F5")

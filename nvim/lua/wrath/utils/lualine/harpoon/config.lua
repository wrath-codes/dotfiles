local require = require("lualine_require").require
local utils = require("lualine.utils.utils")

local M = {}
--@param config table
local markers = {}
for i = 1, 8 do
	markers[i] = i
end

M.symbols = {
	icon = {
		active = "󰛢",
	},
}

return M

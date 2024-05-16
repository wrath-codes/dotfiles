local require = require("lualine_require").require
local highlight = require("lualine.highlight")
local utils = require("lualine.utils.utils")

local M = require("lualine.component"):extend()

-- Initializer
function M:init(options)
	M.super.init(self, options)
end

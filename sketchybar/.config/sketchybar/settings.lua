local colors = require("colors")
local icons = require("icon_list")

return {
	paddings = 2,
	group_paddings = 4,
	modes = {
		main = {
			icon = icons.misc.Apple,
			color = colors.rainbow[1],
		},
		service = {
			icon = icons.kind.Event,
			color = 0xffff9e64,
		},
	},
	bar = {
		height = 36,
		padding = {
			x = 4,
			y = 0,
		},
		background = colors.transparent,
	},
	items = {
		height = 26,
		gap = 4,
		padding = {
			right = 18,
			left = 4,
			top = 0,
			bottom = 0,
		},
		default_color = function(workspace)
			return colors.rainbow[workspace + 1]
		end,
		highlight_color = function(workspace)
			return colors.yellow
		end,
		colors = {
			background = colors.bg1,
		},
		corner_radius = 4,
	},

	icons = "sketchybar-app-font:Regular:16.0", -- alternatively available: NerdFont

	font = {
		text = "CaskaydiaCove Nerd Font Mono", -- Used for text
		numbers = "CaskaydiaCove Nerd Font Mono", -- Used for numbers
		style_map = {
			["Regular"] = "Regular",
			["Semibold"] = "Medium",
			["Bold"] = "SemiBold",
			["Heavy"] = "Bold",
			["Black"] = "ExtraBold",
		},
	},
}

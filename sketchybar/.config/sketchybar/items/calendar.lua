local settings = require("settings")
local colors = require("colors")
local icons = require("icon_list")

-- Padding item required because of bracket
sbar.add("item", {
	position = "right",
	width = settings.group_paddings,
})

local cal = sbar.add("item", {
	icon = {
		color = colors.white,
		padding_left = 8,
		font = {
			size = 22.0,
		},
	},
	label = {
		color = colors.white,
		padding_right = 8,
		width = 100,
		align = "right",
		font = {
			family = settings.icons,
		},
	},
	position = "right",
	update_freq = 30,
	padding_left = 1,
	padding_right = 1,
	background = {
		color = colors.bg2,
		border_color = colors.rainbow[#colors.rainbow],
		border_width = 1,
	},
})

-- Padding item required because of bracket
sbar.add("item", {
	position = "right",
	width = settings.group_paddings,
})

cal:subscribe({ "forced", "routine", "system_woke" }, function(env)
	cal:set({
		icon = icons.ui.Calendar,
		label = os.date("%d/%m/%y %H:%M"),
	})
end)

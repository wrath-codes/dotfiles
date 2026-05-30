local icons = require("icon_list")
local colors = require("colors")
local settings = require("settings")

local disk = sbar.add("item", "widgets.disk", {
	position = "right",
	update_freq = 60,
	icon = {
		string = icons.misc.Disk,
		font = {
			family = settings.font.icons,
			style = settings.font.style_map["Regular"],
			size = 16.0,
		},
	},
	label = {
		string = "??%",
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 11.0,
		},
	},
	padding_right = settings.paddings + 6,
})

disk:subscribe({ "routine", "forced" }, function()
	sbar.exec("df -h / | awk 'NR==2 {gsub(\"%\",\"\",$5); print $5}'", function(out)
		local used = tonumber(out)
		if not used then
			return
		end

		local color = colors.blue
		if used > 90 then
			color = colors.red
		elseif used > 75 then
			color = colors.orange
		elseif used > 60 then
			color = colors.yellow
		end

		disk:set({
			icon = { color = color },
			label = { string = string.format("%d%%", used) },
		})
	end)
end)

disk:subscribe("mouse.clicked", function()
	sbar.exec("open /")
end)

sbar.add("bracket", "widgets.disk.bracket", { disk.name }, {
	background = {
		color = colors.surface0,
		border_color = colors.overlay0,
		border_width = 1,
	},
})

sbar.add("item", "widgets.disk.padding", {
	position = "right",
	width = settings.group_paddings,
})

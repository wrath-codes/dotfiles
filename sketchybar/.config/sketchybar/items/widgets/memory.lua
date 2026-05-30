local icons = require("icon_list")
local colors = require("colors")
local settings = require("settings")

local memory = sbar.add("item", "widgets.memory", {
	position = "right",
	update_freq = 5,
	icon = {
		string = icons.misc.Memory,
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

memory:subscribe({ "routine", "forced" }, function()
	sbar.exec("memory_pressure | awk '/free percentage/ {gsub(\"%\",\"\",$NF); print 100-$NF}'", function(out)
		local used = tonumber(out)
		if not used then
			return
		end

		local color = colors.blue
		if used > 80 then
			color = colors.red
		elseif used > 60 then
			color = colors.orange
		elseif used > 40 then
			color = colors.yellow
		end

		memory:set({
			icon = { color = color },
			label = { string = string.format("%d%%", used) },
		})
	end)
end)

memory:subscribe("mouse.clicked", function()
	sbar.exec("open -a 'Activity Monitor'")
end)

sbar.add("bracket", "widgets.memory.bracket", { memory.name }, {
	background = {
		color = colors.surface0,
		border_color = colors.overlay0,
		border_width = 1,
	},
})

sbar.add("item", "widgets.memory.padding", {
	position = "right",
	width = settings.group_paddings,
})

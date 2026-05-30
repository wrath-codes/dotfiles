local icons = require("icon_list")
local colors = require("colors")
local settings = require("settings")

-- Pomodoro durations (seconds)
local WORK = 25 * 60
local BREAK = 5 * 60

-- State: "idle" | "work" | "break" | "paused"
local state = "idle"
local remaining = WORK
local paused_from = "work" -- which phase we were in before pausing

local function format_time(secs)
	local m = math.floor(secs / 60)
	local s = secs % 60
	return string.format("%02d:%02d", m, s)
end

local function notify(title, msg)
	sbar.exec(string.format(
		[[osascript -e 'display notification "%s" with title "%s" sound name "Glass"']],
		msg,
		title
	))
end

local pomodoro = sbar.add("item", "widgets.pomodoro", {
	position = "right",
	update_freq = 1,
	icon = {
		string = icons.pomodoro.Idle,
		color = colors.overlay1,
		font = {
			family = settings.font.icons,
			style = settings.font.style_map["Regular"],
			size = 16.0,
		},
	},
	label = {
		string = format_time(WORK),
		font = {
			family = settings.font.numbers,
			style = settings.font.style_map["Bold"],
			size = 11.0,
		},
	},
	padding_right = settings.paddings + 6,
})

local function render()
	local icon, color
	if state == "work" then
		icon, color = icons.pomodoro.Work, colors.red
	elseif state == "break" then
		icon, color = icons.pomodoro.Break, colors.green
	elseif state == "paused" then
		icon, color = icons.pomodoro.Paused, colors.yellow
	else
		icon, color = icons.pomodoro.Idle, colors.overlay1
	end

	pomodoro:set({
		icon = { string = icon, color = color },
		label = { string = format_time(remaining) },
	})
end

render()

pomodoro:subscribe({ "routine", "forced" }, function()
	if state ~= "work" and state ~= "break" then
		return
	end

	remaining = remaining - 1
	if remaining <= 0 then
		if state == "work" then
			notify("Pomodoro", "Work complete — break time!")
			state = "break"
			remaining = BREAK
		else
			notify("Pomodoro", "Break over — back to work!")
			state = "work"
			remaining = WORK
		end
	end
	render()
end)

pomodoro:subscribe("mouse.clicked", function(env)
	if env.BUTTON == "right" then
		-- reset
		state = "idle"
		remaining = WORK
		paused_from = "work"
	elseif state == "idle" then
		state = "work"
		remaining = WORK
	elseif state == "paused" then
		state = paused_from
	else
		paused_from = state
		state = "paused"
	end
	render()
end)

sbar.add("bracket", "widgets.pomodoro.bracket", { pomodoro.name }, {
	background = {
		color = colors.surface0,
		border_color = colors.overlay0,
		border_width = 1,
	},
})

sbar.add("item", "widgets.pomodoro.padding", {
	position = "right",
	width = settings.group_paddings,
})

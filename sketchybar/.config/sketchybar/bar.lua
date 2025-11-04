local settings = require("settings")

-- Equivalent to the --bar domain
sbar.bar({
	topmost = "window",
	height = settings.bar.height,
	color = settings.bar.background,
	padding_right = settings.bar.padding.x,
	padding_left = settings.bar.padding.x,
	sticky = true,
	position = "top",
	shadow = true,
})

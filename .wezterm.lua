local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 15.0
config.font = wezterm.font("CaskaydiaCove Nerd Font Mono", { bold = false, italic = false })
config.font_rules = {
	{
		intensity = "Normal",
		italic = false,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { italic = false, bold = false }),
	},
	{
		intensity = "Bold",
		italic = false,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { bold = true, italic = false }),
	},
	{
		italic = true,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { italic = true, bold = false }),
	},
	{
		intensity = "Bold",
		italic = true,
		font = wezterm.font("CaskaydiaCove Nerd Font Mono", { italic = true, bold = true }),
	},
}
config.line_height = 1.0

config.bold_brightens_ansi_colors = true
config.freetype_load_target = "Light"
config.front_end = "WebGpu"

config.color_scheme = "Catppuccin Frappé (Gogh)"

config.window_decorations = "NONE|RESIZE"
config.window_padding = {
	left = 9,
	right = 2,
	top = 2,
	bottom = 0,
}

config.window_background_opacity = 0.75
config.macos_window_background_blur = 20
config.term = "xterm-256color"
config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.scrollback_lines = 10000
config.check_for_updates = false
config.enable_tab_bar = true
config.enable_scroll_bar = false

return config

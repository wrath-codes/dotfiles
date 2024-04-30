local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.font_size = 13.0
config.font = wezterm.font ("Liga SFMono Nerd Font", { bold = false, italic = false })
config.font_rules = {
  {
    intensity = "Normal",
    italic = false,
    font = wezterm.font("Liga SFMono Nerd Font", { italic = false, bold = false }),
  },
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font("Operator Mono", { bold = true, italic = false }),
  },
  {
    italic = true,
    font = wezterm.font("Operator Mono", { italic = true, bold = false}),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font("Operator Mono", { italic = true, bold = true}),
  },
}


config.bold_brightens_ansi_colors = true
config.freetype_load_target = "Light"

config.front_end = "WebGpu"
config.freetype_load_flags = 'FORCE_AUTOHINT'
config.cell_width = 0.9

config.color_scheme = "Tokyo Night Moon"

config.window_padding = {
  left = 9,
  right = 2,
  top = 2,
  bottom = 0,
}


config.window_background_opacity = 0.7
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

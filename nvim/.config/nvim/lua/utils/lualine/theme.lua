local M = {}

function M.colors()
  local mocha = require("catppuccin.palettes").get_palette("mocha")
  local statusline_palette = {
    blue = mocha.blue,
    teal = mocha.teal,
    transparent = mocha.none,
    red = mocha.red,
    violet = mocha.mauve,
    yellow = mocha.yellow,
    green = mocha.green,
    orange = mocha.peach,
    white = mocha.text,
    grey = mocha.mantle,
  }
  return statusline_palette
end

M.modes = function()
  local colors = M.colors()

  local mode_colors = {
    normal = {
      a = { fg = colors.transparent, bg = colors.blue },
      b = { fg = colors.blue, bg = colors.grey },
      c = { fg = colors.transparent, bg = colors.transparent },
    },
    insert = {
      a = { fg = colors.transparent, bg = colors.green },
      b = { fg = colors.green, bg = colors.grey },
      c = { fg = colors.green, bg = colors.transparent },
    },
    visual = {
      a = { fg = colors.transparent, bg = colors.violet },
      b = { fg = colors.violet, bg = colors.grey },
      c = { fg = colors.violet, bg = colors.transparent },
    },
    replace = {
      a = { fg = colors.transparent, bg = colors.orange },
      b = { fg = colors.orange, bg = colors.grey },
      c = { fg = colors.orange, bg = colors.transparent },
    },
    command = {
      a = { fg = colors.transparent, bg = colors.yellow },
      b = { fg = colors.yellow, bg = colors.grey },
      c = { fg = colors.yellow, bg = colors.transparent },
    },
    inactive = {
      a = { fg = colors.transparent, bg = colors.transparent },
      b = { fg = colors.transparent, bg = colors.transparent },
      c = { fg = colors.transparent, bg = colors.transparent },
    },
  }
  return mode_colors
end

M.separators = {
  component_separators = { left = " ", right = " " },
  section_separators = { left = "", right = "" },
}

return M

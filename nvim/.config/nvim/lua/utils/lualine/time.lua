local M = {}

function M.setup()
  -- Define visual settings for time with Catppuccin Mocha colors
  local catppuccin = require("catppuccin.palettes").get_palette("mocha")
  local time_colors = {
    icon = catppuccin.blue,
    text = catppuccin.lavender,
    grey = catppuccin.surface0,
  }

  -- Highlight groups for time component
  vim.api.nvim_set_hl(0, "TimeIcon", { fg = time_colors.icon, bg = time_colors.grey })
  vim.api.nvim_set_hl(0, "TimeText", { fg = time_colors.text, bg = time_colors.grey })

  return M.component
end

M.component = function()
  return string.format("%%#TimeIcon# %%#TimeText#%s", os.date("%H:%M:%S", os.time()))
end

return M

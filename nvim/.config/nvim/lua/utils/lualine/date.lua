local M = {}

function M.setup()
  -- Define visual settings for date with Catppuccin Mocha colors
  local catppuccin = require("catppuccin.palettes").get_palette("mocha")
  local date_colors = {
    icon = catppuccin.peach,
    text = catppuccin.lavender,
    transparent = catppuccin.none,
  }

  -- Highlight groups for date component
  vim.api.nvim_set_hl(0, "DateIcon", { fg = date_colors.icon, bg = date_colors.transparent })
  vim.api.nvim_set_hl(0, "DateText", { fg = date_colors.text, bg = date_colors.transparent })

  return M.component
end

M.component = function()
  return string.format("%%#DateIcon# %%#DateText#%s", os.date("%Y-%m-%d", os.time()))
end

return M

local M = {}

function M.setup()
  -- Define visual settings for harpoon tabline with Catppuccin Mocha colors
  local catppuccin = require("catppuccin.palettes").get_palette("mocha")
  local harpoon_colors = {
    active = {
      text = catppuccin.mauve, -- Mauve
      number = catppuccin.peach,
    },
    inactive = {
      text = catppuccin.surface2, -- Surface2
      number = catppuccin.overlay1, -- Overlay1
    },
    grey = catppuccin.overlay1, -- Overlay1
    transparent = catppuccin.none,
  }

  vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = harpoon_colors.inactive.text, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(0, "HarpoonActive", { fg = harpoon_colors.active.text, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = harpoon_colors.active.number, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(
    0,
    "HarpoonNumberInactive",
    { fg = harpoon_colors.inactive.number, bg = harpoon_colors.transparent }
  )
  vim.api.nvim_set_hl(0, "HarpoonEmpty", { fg = harpoon_colors.grey, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(0, "HarpoonNumberEmpty", { fg = harpoon_colors.grey, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(0, "TabLineFill", { fg = harpoon_colors.transparent, bg = harpoon_colors.transparent })

  return M.component
end

M.component = function()
  local harpoon = require("harpoon")
  local contents = {}
  local list = harpoon:list()
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  local letters = { "1", "2", "3", "4", "7", "8", "9", "0" }
  local content_index = 1

  -- Filter out nil entries and build display
  for i = 1, list:length() do
    local item = list:get(i)
    if item and content_index <= 8 then
      local harpoon_file_path = item.value
      local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

      if current_file_path == harpoon_file_path then
        contents[content_index] = string.format(" %%#HarpoonNumberActive#%s %%#HarpoonActive#%s ", "[󰛢]", file_name)
      else
        contents[content_index] =
          string.format(" %%#HarpoonNumberInactive#%s %%#HarpoonInactive#%s ", letters[content_index], file_name)
      end
      content_index = content_index + 1
    end
  end

  -- Fill remaining slots with empty
  for index = content_index, 8 do
    contents[index] = string.format("%%#HarpoonNumberEmpty#%s%%#HarpoonEmpty#%s ", "[+]", "[Empty]")
  end

  return table.concat(contents)
end

return M

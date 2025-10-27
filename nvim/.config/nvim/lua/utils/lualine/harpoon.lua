local M = {}

function M.setup()
  local harpoon = require("harpoon")

  -- Define visual settings for harpoon tabline with Catppuccin Mocha colors
  local harpoon_colors = {
    active = {
      text = "#cba6f7", -- Mauve
      number = "#fab387", -- Peach
    },
    inactive = {
      text = "#6c7086", -- Surface2
      number = "#9399b2", -- Overlay1
    },
    grey = "#6c7086",
    transparent = nil,
  }

  vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = harpoon_colors.inactive.text, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(0, "HarpoonActive", { fg = harpoon_colors.active.text, bg = harpoon_colors.transparent })
  vim.api.nvim_set_hl(
    0,
    "HarpoonNumberActive",
    { fg = harpoon_colors.active.number, bg = harpoon_colors.transparent }
  )
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
  local marks_length = harpoon:list():length()
  local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
  local letters = { "1", "2", "3", "4", "7", "8", "9", "0" }

  for index = 1, math.min(marks_length, 8) do
    local harpoon_file_path = harpoon:list():get(index).value
    local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

    if current_file_path == harpoon_file_path then
      contents[index] = string.format(" %%#HarpoonNumberActive#%s %%#HarpoonActive#%s ", "[󰛢]", file_name)
    else
      contents[index] =
        string.format(" %%#HarpoonNumberInactive#%s %%#HarpoonInactive#%s ", letters[index], file_name)
    end
  end

  for index = marks_length + 1, 8 do
    contents[index] = string.format("%%#HarpoonNumberEmpty#%s%%#HarpoonEmpty#%s ", "[+]", "[Empty]")
  end

  return table.concat(contents)
end

return M

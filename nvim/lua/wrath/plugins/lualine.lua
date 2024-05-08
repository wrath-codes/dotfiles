local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
  },
}

function M.config()
  local filetype = {
    "filetype",
    colored = true, -- Displays filetype icon in color if set to true
    icon_only = true, -- Display only an icon for filetype
    icon = { align = "right" },
    function()
      local filetype = vim.bo.filetype
      local upper_case_filetypes = {
        "json",
        "jsonc",
        "yaml",
        "toml",
        "css",
        "scss",
        "html",
        "xml",
        "xhtml",
      }

      if vim.tbl_contains(upper_case_filetypes, filetype) then
        return filetype:upper()
      end

      return filetype
    end,
  }

  local harpoon = require("harpoon")

  -- define visual settings for harpoon tabline
  local yellow = "#DCDCAA"
  local yellow_orange = "#D7BA7D"
  local background_color = "#ffffff"
  local grey = "#797C91"
  local light_blue = "#9CDCFE"

  vim.api.nvim_set_hl(0, "HarpoonInactive", { fg = grey, bg = background_color })
  vim.api.nvim_set_hl(0, "HarpoonActive", { fg = light_blue, bg = background_color })
  vim.api.nvim_set_hl(0, "HarpoonNumberActive", { fg = yellow, bg = background_color })
  vim.api.nvim_set_hl(0, "HarpoonNumberInactive", { fg = yellow_orange, bg = background_color })
  vim.api.nvim_set_hl(0, "HarpoonEmpty", { fg = "grey", bg = background_color })
  vim.api.nvim_set_hl(0, "HarpoonNumberEmpty", { fg = "grey", bg = background_color })
  vim.api.nvim_set_hl(0, "TabLineFill", { fg = "white", bg = background_color })

  local function harpoon_files()
    local contents = {}
    local marks_length = harpoon:list():length()
    local current_file_path = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
    for index = 1, marks_length do
      local harpoon_file_path = harpoon:list():get(index).value
      local file_name = harpoon_file_path == "" and "(empty)" or vim.fn.fnamemodify(harpoon_file_path, ":t")

      if current_file_path == harpoon_file_path then
        contents[index] = string.format("%%#HarpoonNumberActive# %s. %%#HarpoonActive#%s ", index, file_name)
      else
        contents[index] =
            string.format("%%#HarpoonNumberInactive# %s. %%#HarpoonInactive#%s ", index, file_name)
      end
    end

    for index = marks_length + 1, 4 do
      contents[index] = string.format("%%#HarpoonNumberEmpty# %s %%#HarpoonEmpty#%s ", "[+]", "[Empty]")
    end

    return table.concat(contents)
  end

  local colors = {
    teal = "#94e2d5",
    yellow = "#f9e2af",
    mauve = "#79dac8",
    transparent = "#ffffff",
    peach = "#fab387",
    white = "#c6c6c6",
    green = "#a6e3a1",
    violet = "#d183e8",
    grey = "#303030",
  }

  local bubbles_theme = {
    normal = {
      a = { fg = colors.transparent, bg = colors.teal },
      b = { fg = colors.teal, bg = colors.grey },
      c = { fg = colors.white, bg = colors.transparent },
    },

    insert = { a = { fg = colors.transparent, bg = colors.green } },
    visual = { a = { fg = colors.transparent, bg = colors.mauve } },
    replace = { a = { fg = colors.transparent, bg = colors.peach } },
    command = { a = { fg = colors.transparent, bg = colors.yellow } },

    inactive = {
      a = { fg = colors.white, bg = colors.transparent },
      b = { fg = colors.white, bg = colors.transparent },
      c = { fg = colors.white, bg = colors.transparent },
    },
  }

  require("lualine").setup({
    options = {
      theme = bubbles_theme,
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      ignore_focus = { "NvimTree" },
      -- Define custom colors for regular and active indicators
    },
    sections = {
      lualine_a = { { "mode", icon = "" } },
      lualine_b = { { "branch", icon = "" } },
      lualine_c = {
        "%=",
        {
          harpoon_files,
        },
      },
      lualine_x = { "filename", filetype, "encoding" },
      lualine_y = { "copilot" },
      lualine_z = { "progress", "location" },
    },
    extensions = { "quickfix", "man", "fugitive", "oil" },
  })
end

return M

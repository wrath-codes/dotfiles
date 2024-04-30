local M = {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "AndreM222/copilot-lualine",
    { "abeldekat/harpoonline", version = "*" },
  },
}

function M.config()
  local icons = require("wrath.utils.icons")
  local diff = {
    "diff",
    colored = true,
    symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
  }

  local diagnostics = {
    "diagnostics",
    sections = { "error", "warn" },
    colored = true,      -- Displays diagnostics status in color if set to true.
    always_visible = true, -- Show diagnostics even if there are none.
  }

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

  local harpoonline = require("harpoonline")

  harpoonline.setup({
    formatter = "extended",
    icon = "󱡅",
    formatter_opts = {
      extended = { -- remove all decodespaces...
        indicators = {
          " H ",
          " T ",
          " N ",
          " S ",
        },
        active_indicators = {
          " [H] ",
          " [T] ",
          " [N] ",
          " [S] ",
        },
        empty_slot = "·",
        more_marks_indicator = "…", -- horizontal elipsis. Disable with empty string
        more_marks_active_indicator = "[…]", -- Disable with empty string
      },
    },
    on_update = function()
      require("lualine").refresh()
    end,
  })

  require("lualine").setup({
    options = {
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },

      ignore_focus = { "NvimTree" },
      -- Define custom colors for regular and active indicators
    },
    sections = {
      lualine_a = { { "mode", icon = "" } },
      lualine_b = { { "branch", icon = "" }, diff, diagnostics },
      lualine_c = {
        "%=",
        {
          harpoonline.format,
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

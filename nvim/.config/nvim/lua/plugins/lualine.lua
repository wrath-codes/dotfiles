return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Setup harpoon component
      local harpoon_component = require("utils.lualine.harpoon").setup()
      local filetype_component = require("utils.lualine.filetype").setup()
      local filename_component = require("utils.lualine.filename").setup()
      local datetime_component = require("utils.lualine.datetime").setup()

      -- Configure tabline (top bar) for harpoon
      opts.tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          "%=", -- Center the harpoon component
          {
            harpoon_component,
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
      }

      -- Keep LazyVim's default sections for statusline (bottom bar)
      -- Just add time to section Y
      opts.theme = "auto"
      opts.sections = {
        lualine_a = { { "mode", icon = "", separator = { left = "" }, right_padding = 2 } },
        lualine_b = { { "branch", icon = "" } },
        lualine_c = { filename_component, filetype_component },
        lualine_x = { "encoding", "copilot" },
        lualine_y = { datetime_component },
        lualine_z = {
          { "progress", separator = { left = "" }, right_padding = 2 },
          { "location", separator = { right = "" }, left_padding = 2 },
        },
      }
      opts.extensions = { "quickfix", "man", "fugitive", "oil" }

      return opts
    end,
  },
}

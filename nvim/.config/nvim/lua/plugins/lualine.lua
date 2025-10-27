return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Setup harpoon component
      local harpoon_component = require("utils.lualine.harpoon").setup()

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
      table.insert(opts.sections.lualine_y, 1, {
        function()
          return os.date("%H:%M")
        end,
      })

      return opts
    end,
  },
}

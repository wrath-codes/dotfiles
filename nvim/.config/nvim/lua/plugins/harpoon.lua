return {
  {
    "ThePrimeagen/harpoon",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    keys = function()
      local keys = {
        -- Add mark with notification
        {
          "<leader>ha",
          function()
            require("harpoon"):list():add()
            vim.notify("󰛢  marked file", vim.log.levels.INFO)
          end,
          desc = "Harpoon Mark File",
        },
        -- Edit harpoon list
        {
          "<leader>he",
          function()
            local harpoon = require("harpoon")
            harpoon.ui:toggle_quick_menu(harpoon:list())
          end,
          desc = "Harpoon Edit List",
        },
        -- Previous/Next in harpoon list
        {
          "<C-S-P>",
          function()
            require("harpoon"):list():prev()
          end,
          desc = "Harpoon Prev",
        },
        {
          "<C-S-N>",
          function()
            require("harpoon"):list():next()
          end,
          desc = "Harpoon Next",
        },
      }

      -- Disable default <leader>1-9 mappings
      for i = 1, 9 do
        table.insert(keys, {
          "<leader>" .. i,
          false,
        })
      end

      -- Add custom number key mappings for 8 harpoons (1-4, 7-0)
      local harpoon_keys = { "1", "2", "3", "4", "7", "8", "9", "0" }
      for idx, key in ipairs(harpoon_keys) do
        table.insert(keys, {
          key,
          function()
            require("harpoon"):list():select(idx)
          end,
          desc = "Harpoon to File " .. idx,
        })
      end

      -- Disable default <leader>h and <leader>H
      table.insert(keys, { "<leader>h", false })
      table.insert(keys, { "<leader>H", false })

      return keys
    end,
  },
}

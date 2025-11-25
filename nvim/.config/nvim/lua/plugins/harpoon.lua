return {
  {
    "ThePrimeagen/harpoon",
    opts = {
      settings = {
        save_on_toggle = true,
      },
    },
    config = function(_, opts)
      require("harpoon").setup(opts)

      -- Register which-key groups
      local wk = require("which-key")
      wk.add({
        { "<leader>h", group = "Harpoon" },
        { "<leader>hd", group = "Harpoon Delete" },
        { "<leader>hs", group = "Harpoon Swap" },
      })
    end,
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
        -- Delete current file from harpoon
        {
          "<leader>hdc",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx then
              list:remove_at(idx)
              -- Compact items array by removing nils
              local new_items = {}
              for i = 1, list:length() do
                if list.items[i] then
                  table.insert(new_items, list.items[i])
                end
              end
              list.items = new_items
              harpoon:sync()
              vim.notify("󰛢 removed from harpoon", vim.log.levels.INFO)
            end
          end,
          desc = "Delete Current",
        },
        -- Delete previous file from harpoon
        {
          "<leader>hdp",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx and idx > 1 then
              list:remove_at(idx - 1)
              -- Compact items array by removing nils
              local new_items = {}
              for i = 1, list:length() do
                if list.items[i] then
                  table.insert(new_items, list.items[i])
                end
              end
              list.items = new_items
              harpoon:sync()
              vim.notify("󰛢 removed from harpoon", vim.log.levels.INFO)
            end
          end,
          desc = "Delete Previous",
        },
        -- Delete next file from harpoon
        {
          "<leader>hdn",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx and idx < list:length() then
              list:remove_at(idx + 1)
              -- Compact items array by removing nils
              local new_items = {}
              for i = 1, list:length() do
                if list.items[i] then
                  table.insert(new_items, list.items[i])
                end
              end
              list.items = new_items
              harpoon:sync()
              vim.notify("󰛢 removed from harpoon", vim.log.levels.INFO)
            end
          end,
          desc = "Delete Next",
        },
        -- Delete all harpoons to the left
        {
          "<leader>hdl",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx then
              -- Remove all items before current index
              for i = idx - 1, 1, -1 do
                list.items[i] = nil
              end
              -- Compact items array by removing nils
              local new_items = {}
              for i = 1, list:length() do
                if list.items[i] then
                  table.insert(new_items, list.items[i])
                end
              end
              list.items = new_items
              harpoon:sync()
              vim.notify("󰛢 deleted all to the left", vim.log.levels.INFO)
            end
          end,
          desc = "Delete All Left",
        },
        -- Delete all harpoons to the right
        {
          "<leader>hdr",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx then
              -- Remove all items after current index
              for i = list:length(), idx + 1, -1 do
                list.items[i] = nil
              end
              -- Compact items array by removing nils
              local new_items = {}
              for i = 1, list:length() do
                if list.items[i] then
                  table.insert(new_items, list.items[i])
                end
              end
              list.items = new_items
              harpoon:sync()
              vim.notify("󰛢 deleted all to the right", vim.log.levels.INFO)
            end
          end,
          desc = "Delete All Right",
        },
        -- Delete all other harpoons
        {
          "<leader>hdo",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")

            local _, idx = list:get_by_value(current_file)
            if idx then
              -- Keep only current item, remove all others
              local current_item = list.items[idx]
              list.items = { current_item }
              harpoon:sync()
              vim.notify("󰛢 deleted all others", vim.log.levels.INFO)
            end
          end,
          desc = "Delete All Others",
        },
        -- Previous/Next in harpoon list
        {
          "<leader>hp",
          function()
            require("harpoon"):list():prev()
          end,
          desc = "Harpoon Prev",
        },
        {
          "<leader>hn",
          function()
            require("harpoon"):list():next()
          end,
          desc = "Harpoon Next",
        },
        -- Swap with next
        {
          "<leader>hsn",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
            local _, idx = list:get_by_value(current_file)

            if idx and idx < list:length() then
              local temp = list.items[idx]
              list.items[idx] = list.items[idx + 1]
              list.items[idx + 1] = temp
              harpoon:sync()
              vim.notify("󰛢 swapped with next", vim.log.levels.INFO)
            end
          end,
          desc = "Swap with Next",
        },
        -- Swap with previous
        {
          "<leader>hsp",
          function()
            local harpoon = require("harpoon")
            local list = harpoon:list()
            local current_file = vim.fn.fnamemodify(vim.fn.expand("%:p"), ":.")
            local _, idx = list:get_by_value(current_file)

            if idx and idx > 1 then
              local temp = list.items[idx]
              list.items[idx] = list.items[idx - 1]
              list.items[idx - 1] = temp
              harpoon:sync()
              vim.notify("󰛢 swapped with previous", vim.log.levels.INFO)
            end
          end,
          desc = "Swap with Previous",
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
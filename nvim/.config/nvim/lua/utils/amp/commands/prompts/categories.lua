local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXCategories", function()
    local prompts_utils = require("utils.amp.utils.prompts")
    local categories = prompts_utils.get_categories()

    if #categories == 0 then
      vim.notify("No categories found. Add one with Ctrl+Shift+A.", vim.log.levels.INFO)
    end

    local items = {}
    for _, cat in ipairs(categories) do
      -- Count prompts in this category
      local prompt_count = 0
      local all_prompts = prompts_utils.get_prompts()
      for _, p in ipairs(all_prompts) do
        if p.category == cat.name then
          prompt_count = prompt_count + 1
        end
      end
      table.insert(items, {
        text = cat.name .. " (" .. prompt_count .. " prompts)",
        id = cat.id,
        name = cat.name,
        prompt_count = prompt_count,
      })
    end

    local layout_config = {
      layout = {
        box = "horizontal",
        width = 0.8,
        min_width = 120,
        height = 0.8,
        {
          box = "vertical",
          border = true,
          title = "{title}",
          { win = "input", height = 1, border = "bottom" },
          { win = "list", border = "none" },
        },
        { win = "preview", width = 0.5, border = "rounded" },
      },
    }

    require("snacks").picker({
      items = items,
      title = " Manage Categories ",
      layout = layout_config,
      actions = {
        delete_category = function(picker, item)
          picker:close()
          if item.prompt_count > 0 then
            vim.ui.select({ "Cancel", "Delete and move to Undefined" }, {
              prompt = "Delete category '" .. item.name .. "'? " .. item.prompt_count .. " prompts will be moved to 'Undefined'.",
            }, function(choice)
              if choice == "Delete and move to Undefined" then
                if require("utils.amp.utils.prompts").delete_category(item.id) then
                  vim.notify("Category '" .. item.name .. "' deleted, prompts moved to 'Undefined'", vim.log.levels.INFO)
                  -- Refresh the picker
                  vim.schedule(function()
                    vim.cmd("AmpDashXCategories")
                  end)
                end
              end
            end)
          else
            -- No prompts, delete directly
            if require("utils.amp.utils.prompts").delete_category(item.id) then
              vim.notify("Category '" .. item.name .. "' deleted", vim.log.levels.INFO)
              vim.schedule(function()
                vim.cmd("AmpDashXCategories")
              end)
            end
          end
        end,
        add_category = function(picker, item)
          picker:close()
          vim.ui.input({ prompt = "New category name:" }, function(new_name)
            if new_name and new_name ~= "" then
              if require("utils.amp.utils.prompts").add_category({ name = new_name }) then
                vim.notify("Category '" .. new_name .. "' added", vim.log.levels.INFO)
                vim.schedule(function()
                  vim.cmd("AmpDashXCategories")
                end)
              end
            end
          end)
        end,
        edit_category = function(picker, item)
          picker:close()
          vim.ui.input({ prompt = "New name for '" .. item.name .. "':" }, function(new_name)
            if new_name and new_name ~= "" and new_name ~= item.name then
              -- Update all prompts in this category
              local data = require("utils.amp.utils.prompts").load_data()
              local updated = false
              for _, prompt in ipairs(data.prompts) do
                if prompt.category == item.name then
                  prompt.category = new_name
                  updated = true
                end
              end
              -- Update category name
              for _, cat in ipairs(data.categories) do
                if cat.id == item.id then
                  cat.name = new_name
                  updated = true
                  break
                end
              end
              if updated and require("utils.amp.utils.prompts").save_data(data) then
                vim.notify("Category renamed to '" .. new_name .. "'", vim.log.levels.INFO)
                vim.schedule(function()
                  vim.cmd("AmpDashXCategories")
                end)
              end
            end
          end)
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-S-d>"] = { "delete_category", mode = { "i", "n" } },
            ["<C-S-a>"] = { "add_category", mode = { "i", "n" } },
            ["<C-S-e>"] = { "edit_category", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["?"] = "toggle_help_list",
          },
        },
      },
      format = function(item)
        return { { item.text, "SnacksPickerLabel" } }
      end,
      preview = function(ctx)
        local item = ctx.item
        if not item then return end

        local lines = {
          "# " .. item.name,
          "",
          "**Prompts:** " .. item.prompt_count,
        }

        -- List prompts in this category
        if item.prompt_count > 0 then
          local prompts = require("utils.amp.utils.prompts").get_prompts_by_category(item.name)
          table.insert(lines, "")
          table.insert(lines, "**Prompts in this category:**")
          for _, p in ipairs(prompts) do
            table.insert(lines, "- " .. p.title)
          end
        end

        ctx.preview:reset()
        ctx.preview:set_lines(lines)
        ctx.preview:highlight({ ft = "markdown" })
      end,
      confirm = function(picker, item)
        picker:close()
        -- Open filtered prompts picker for this category
        local prompts_utils = require("utils.amp.utils.prompts")
        local category_prompts = prompts_utils.get_prompts_by_category(item.name)
        if #category_prompts == 0 then
          vim.notify("No prompts in category '" .. item.name .. "'", vim.log.levels.INFO)
          return
        end

        local items = {}
        for _, p in ipairs(category_prompts) do
          table.insert(items, {
            text = p.title .. ": " .. p.description,
            prompt = p.prompt,
            id = p.id,
            title = p.title,
            category = p.category,
          })
        end

        local nested_layout = {
          layout = {
            box = "horizontal",
            width = 0.8,
            min_width = 120,
            height = 0.8,
            {
              box = "vertical",
              border = true,
              title = "{title}",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
            { win = "preview", width = 0.5, border = "rounded" },
          },
        }

        require("snacks").picker({
          items = items,
          title = " Prompts in " .. item.name .. " ",
          layout = nested_layout,
          format = function(item)
            return { { item.text, "SnacksPickerLabel" } }
          end,
          preview = function(ctx)
            local item = ctx.item
            if not item then return end

            local lines = {
              "# " .. item.title,
              "",
              "**Category:** `" .. item.category .. "`",
              "**Description:** " .. item.description,
              "",
              "**Prompt Text:**",
              "```",
              item.prompt,
              "```",
              "",
              "---",
              "*Press `<CR>` to copy to clipboard*",
            }

            ctx.preview:reset()
            ctx.preview:set_lines(lines)
            ctx.preview:highlight({ ft = "markdown" })
          end,
          confirm = function(picker2, item2)
            picker2:close()
            vim.fn.setreg("+", item2.prompt)
            vim.notify("Copied prompt to clipboard", vim.log.levels.INFO)
          end,
        })
      end,
      on_show = function(picker)
        if not picker.hints_win or not vim.api.nvim_win_is_valid(picker.hints_win) then
          local buf = vim.api.nvim_create_buf(false, true)
          local col_start = math.floor(0.1 * vim.o.columns)
          local width = math.floor(0.8 * vim.o.columns)
          local row = math.floor(0.9 * vim.o.lines)
          ---@diagnostic disable: inject-field
          picker.hints_win = vim.api.nvim_open_win(buf, false, {
            relative = "editor",
            width = width,
            height = 3,
            row = row,
            col = col_start,
            border = "rounded",
            style = "minimal",
            title = " Key Hints ",
          })
          local hints = {
            " <C-S-d>  delete category (moves prompts to Undefined)",
            " <C-S-a>  add new category",
            " <C-S-e>  edit category name",
            " <CR>     view prompts in category",
            " ?        toggle help",
          }
          local hint_lines = {}
          for i = 1, #hints, 2 do
            local line = hints[i]
            if hints[i + 1] then
              line = line .. string.rep(" ", 55 - #hints[i]) .. hints[i + 1]
            end
            table.insert(hint_lines, line)
          end
          vim.api.nvim_buf_set_lines(buf, 0, -1, false, hint_lines)
          -- Highlight keymaps and descriptions
          local ns = vim.api.nvim_create_namespace("amp_hints")
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 0 }, { 0, 10 })
          vim.hl.range(buf, ns, "Comment", { 0, 10 }, { 0, -1 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 0 }, { 1, 9 })
          vim.hl.range(buf, ns, "Comment", { 1, 9 }, { 1, -1 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 2, 0 }, { 2, 9 })
          vim.hl.range(buf, ns, "Comment", { 2, 9 }, { 2, -1 })
        end
      end,
      on_close = function(picker)
        ---@diagnostic disable: undefined-field
        if picker.hints_win and vim.api.nvim_win_is_valid(picker.hints_win) then
          vim.api.nvim_win_close(picker.hints_win, true)
        end
      end,
    })
  end, {
    desc = "Manage Amp prompt categories",
  })
end

return M

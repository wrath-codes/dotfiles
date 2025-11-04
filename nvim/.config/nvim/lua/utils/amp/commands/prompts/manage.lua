local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXManage", function()
    local prompts_utils = require("utils.amp.utils.prompts")
    local prompts = prompts_utils.get_prompts()

    if #prompts == 0 then
      vim.notify("No prompts to manage", vim.log.levels.INFO)
      return
    end

    local items = {}
    for _, p in ipairs(prompts) do
      table.insert(items, {
        text = p.title .. " (" .. p.category .. "): " .. p.description,
        id = p.id,
        title = p.title,
        prompt_data = p, -- store full data for edit
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
      title = " Manage Prompts ",
      layout = layout_config,
      actions = {
        delete = function(picker, item)
          if prompts_utils.delete_prompt(item.id) then
            vim.notify("Prompt '" .. item.title .. "' deleted", vim.log.levels.INFO)
            -- Refresh the picker
            picker:close()
            vim.cmd("AmpDashXManage")
          end
        end,
        edit = function(picker, item)
          M.edit_prompt(item.prompt_data)
        end,
        add_prompt = function(picker, item)
          picker:close()
          vim.cmd("AmpDashXAdd")
        end,
        copy_command = function(picker, item)
          local command = 'amp -x "' .. item.prompt_data.prompt:gsub('"', '\\"') .. '"'
          vim.fn.setreg("+", command)
          vim.notify("Copied command to clipboard", vim.log.levels.INFO)
        end,
        send_prompt = function(picker, item)
          picker:close()
          local cmd = "amp -x " .. vim.fn.shellescape(item.prompt_data.prompt) .. "; echo '\nPress any key to close...'; read -n 1"
          require("snacks").terminal(cmd, {
            win = {
              style = "float",
              width = 0.5,
              height = 0.5,
              border = "rounded",
              title = " Amp Output ",
              title_pos = "center",
            },
            interactive = true,
          })
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-S-d>"] = { "delete", mode = { "i", "n" } },
            ["<C-S-e>"] = { "edit", mode = { "i", "n" } },
            ["<C-S-a>"] = { "add_prompt", mode = { "i", "n" } },
            ["<C-S-x>"] = { "send_prompt", mode = { "i", "n" } },
            ["<C-S-c>"] = { "copy_command", mode = { "i", "n" } },
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
        if not item or not item.prompt_data then return end

        local p = item.prompt_data
        local lines = {
          "# " .. p.title,
          "",
          "**Category:** `" .. p.category .. "`",
          "**Description:** " .. p.description,
          "",
          "**Prompt Text:**",
          "```",
          p.prompt,
          "```",
          "",
          "---",
          "*Press `<C-S-d>` to delete*",
          "*Press `<C-S-e>` to edit*",
          "*Press `<C-S-a>` to add new prompt*",
          "*Press `<C-S-x>` to execute with `amp -x`*",
          "*Press `<C-S-c>` to copy amp command*",
        }

        ctx.preview:reset()
        ctx.preview:set_lines(lines)
        ctx.preview:highlight({ ft = "markdown" })
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
            height = 4,
            row = row,
            col = col_start,
            border = "rounded",
            style = "minimal",
            title = " Key Hints ",
          })
          local hints = {
            " <C-S-d>   delete prompt",
            " <C-S-e>   edit prompt",
            " <C-S-a>   add new prompt",
            " <C-S-x>   execute prompt in terminal",
            " <C-S-c>   copy amp command",
            " ?         toggle help",
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
          -- Line 0: delete + edit
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 0 }, { 0, 10 })
          vim.hl.range(buf, ns, "Comment", { 0, 10 }, { 0, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 55 }, { 0, 64 })
          vim.hl.range(buf, ns, "Comment", { 0, 64 }, { 0, -1 })
          -- Line 1: add new + execute
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 0 }, { 1, 10 })
          vim.hl.range(buf, ns, "Comment", { 1, 10 }, { 1, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 55 }, { 1, 64 })
          vim.hl.range(buf, ns, "Comment", { 1, 64 }, { 1, -1 })
          -- Line 2: copy command + toggle help
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 2, 0 }, { 2, 10 })
          vim.hl.range(buf, ns, "Comment", { 2, 10 }, { 2, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 2, 55 }, { 2, 60 })
          vim.hl.range(buf, ns, "Comment", { 2, 60 }, { 2, -1 })
          -- Line 3: toggle help (single item)
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 3, 0 }, { 3, 4 })
          vim.hl.range(buf, ns, "Comment", { 3, 4 }, { 3, -1 })
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
    desc = "Manage saved Amp prompts",
  })
end

--- Edit an existing prompt
---@param existing table The existing prompt data
function M.edit_prompt(existing)
  vim.ui.input({ prompt = "Title: ", default = existing.title }, function(title)
    if not title or title == "" then
      vim.notify("No title provided", vim.log.levels.WARN)
      return
    end

    vim.ui.input({ prompt = "Category: ", default = existing.category }, function(category)
      vim.ui.input({ prompt = "Description: ", default = existing.description }, function(description)
        vim.ui.input({ prompt = "Prompt text: ", default = existing.prompt }, function(prompt_text)
          if not prompt_text or prompt_text == "" then
            vim.notify("No prompt provided", vim.log.levels.WARN)
            return
          end

          local form_data = {
            id = existing.id,
            title = title,
            category = category or "General",
            description = description or "",
            prompt = prompt_text,
          }

          -- Update the prompt
          local data = require("utils.amp.utils.prompts").load_data()
          for i, p in ipairs(data.prompts) do
            if p.id == existing.id then
              data.prompts[i] = form_data
              if require("utils.amp.utils.prompts").save_data(data) then
                vim.notify("Prompt '" .. form_data.title .. "' updated", vim.log.levels.INFO)
                -- Refresh the appropriate list
                vim.schedule(function()
                  -- Try to refresh whichever command is most likely open
                  -- This will work for both AmpDashXManage and AmpDashXCategories
                  local success = pcall(vim.cmd, "AmpDashXManage")
                  if not success then
                    pcall(vim.cmd, "AmpDashXCategories")
                  end
                end)
              end
              return
            end
          end
          vim.notify("Failed to update prompt", vim.log.levels.ERROR)
        end)
      end)
    end)
  end)
end

return M

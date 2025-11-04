local M = {}

local picker = require("amp-extras.core.picker")
local terminal = require("amp-extras.core.terminal")
local markdown = require("amp-extras.core.markdown")
local input = require("amp-extras.core.input")
local utils = require("amp-extras.core.utils")

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXManage", function()
    local prompts_utils = require("amp-extras.utils.prompts")
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
        category = p.category,
        description = p.description,
        prompt = p.prompt,
      })
    end

    local hints = {
      " <C-S-d>   delete prompt",
      " <C-S-e>   edit prompt",
      " <C-S-a>   add new prompt",
      " <C-S-x>   execute prompt in terminal",
      " <C-S-c>   copy amp command",
      " ?         toggle help",
    }

    picker.show({
      items = items,
      title = " Manage Prompts ",
      layout = picker.create_layout(),
      actions = {
        ["<C-S-d>"] = function(p, item)
          if prompts_utils.delete_prompt(item.id) then
            vim.notify("Prompt '" .. item.title .. "' deleted", vim.log.levels.INFO)
            p:close()
            vim.cmd("AmpDashXManage")
          end
        end,
        ["<C-S-e>"] = function(p, item)
          M.edit_prompt(item)
        end,
        ["<C-S-a>"] = function(p, item)
          p:close()
          vim.cmd("AmpDashXAdd")
        end,
        ["<C-S-x>"] = function(p, item)
          p:close()
          terminal.amp_prompt(item.prompt)
        end,
        ["<C-S-c>"] = function(p, item)
          local command = 'amp -x "' .. item.prompt:gsub('"', '\\"') .. '"'
          utils.copy_to_clipboard(command)
        end,
      },
      format = function(item)
        return { { item.text, "SnacksPickerLabel" } }
      end,
      preview = function(ctx)
        markdown.render_preview(ctx, ctx.item, {
          footer = markdown.create_footer({
            ["<C-S-d>"] = "delete",
            ["<C-S-e>"] = "edit",
            ["<C-S-a>"] = "add new prompt",
            ["<C-S-x>"] = "execute with amp -x",
            ["<C-S-c>"] = "copy amp command",
          }),
        })
      end,
      on_show = function(p)
        picker.show_hints(p, hints)
      end,
      on_close = function(p)
        picker.close_hints(p)
      end,
    })
  end, {
    desc = "Manage saved Amp prompts",
  })
end

---Edit an existing prompt using multi-step input
---@param existing table The existing prompt data
function M.edit_prompt(existing)
  local prompts_utils = require("amp-extras.utils.prompts")
  
  input.multi_step({
    steps = {
      {
        type = "input",
        key = "title",
        prompt = "Title",
        title = "Edit Title",
        default = existing.title,
      },
      {
        type = "select",
        key = "category",
        prompt = "Select category",
        items = prompts_utils.get_category_names(),
      },
      {
        type = "input",
        key = "description",
        prompt = "Description",
        title = "Edit Description",
        default = existing.description,
      },
      {
        type = "input",
        key = "prompt",
        prompt = "Prompt Text",
        title = "Edit Prompt Text",
        width = 80,
        default = existing.prompt,
      },
    },
    on_complete = function(results)
      if not results.title or results.title == "" then
        vim.notify("No title provided", vim.log.levels.WARN)
        return
      end
      
      if not results.prompt or results.prompt == "" then
        vim.notify("No prompt provided", vim.log.levels.WARN)
        return
      end
      
      local updated = {
        id = existing.id,
        title = results.title,
        category = results.category,
        description = results.description or "",
        prompt = results.prompt,
      }
      
      local data = prompts_utils.load_data()
      for i, p in ipairs(data.prompts) do
        if p.id == existing.id then
          data.prompts[i] = updated
          if prompts_utils.save_data(data) then
            vim.notify("Prompt '" .. updated.title .. "' updated", vim.log.levels.INFO)
            vim.schedule(function()
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
    end,
  })
end

return M

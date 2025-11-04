local M = {}

local input = require("amp-extras.core.input")
local utils = require("amp-extras.core.utils")

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXAdd", function()
    local prompts_utils = require("amp-extras.utils.prompts")
    
    local visual_lines = utils.get_visual_selection()
    local default_title = ""
    local default_prompt = table.concat(visual_lines, "\n")
    
    if #visual_lines > 0 then
      default_title = visual_lines[1]:gsub("^%s*(.-)%s*$", "%1"):gsub("^#+%s*", "")
    end

    input.multi_step({
      steps = {
        {
          type = "input",
          key = "title",
          prompt = "Prompt Title",
          title = "Prompt Title",
          default = default_title,
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
          title = "Description",
        },
        {
          type = "input",
          key = "prompt",
          prompt = "Prompt Text",
          title = "Prompt Text",
          width = 80,
          default = default_prompt,
        },
      },
      on_complete = function(results)
        if results.category == "Add new..." then
          input.prompt({
            prompt = "New category name",
            title = "New Category",
            on_submit = function(new_cat)
              if new_cat and new_cat ~= "" then
                prompts_utils.add_category({ name = new_cat })
                results.category = new_cat
                M.save_prompt(results)
              end
            end,
            on_cancel = function()
              vim.notify("Add cancelled", vim.log.levels.INFO)
            end,
          })
        else
          M.save_prompt(results)
        end
      end,
    })
  end, {
    desc = "Add a new Amp prompt",
  })
end

---Save the prompt with validation
---@param data table Prompt data
function M.save_prompt(data)
  local prompts_utils = require("amp-extras.utils.prompts")
  
  if not data.title or data.title == "" then
    vim.notify("No title provided", vim.log.levels.WARN)
    return
  end
  
  if not data.prompt or data.prompt == "" then
    vim.notify("No prompt provided", vim.log.levels.WARN)
    return
  end
  
  if prompts_utils.add_prompt({
    title = data.title,
    category = data.category,
    description = data.description or "",
    prompt = data.prompt,
  }) then
    vim.notify("Prompt '" .. data.title .. "' added", vim.log.levels.INFO)
  end
end

return M

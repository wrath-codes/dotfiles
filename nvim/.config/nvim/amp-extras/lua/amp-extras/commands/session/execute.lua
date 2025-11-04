local M = {}

local input = require("amp-extras.core.input")
local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpSessionExecute", function()
    input.prompt({
      prompt = "Prompt",
      title = "Execute Prompt",
      on_submit = function(prompt_text)
        if not prompt_text or prompt_text == "" then
          vim.notify("No prompt provided", vim.log.levels.WARN)
          return
        end

        terminal.amp_prompt(prompt_text)

        vim.schedule(function()
          local prompts_utils = require("amp-extras.utils.prompts")
          
          local categories = prompts_utils.get_categories()
          local has_uncategorized = false
          for _, cat in ipairs(categories) do
            if cat.name == "Uncategorized" then
              has_uncategorized = true
              break
            end
          end
          
          if not has_uncategorized then
            prompts_utils.add_category({ name = "Uncategorized" })
          end
          
          local title = prompt_text:match("^([^\n]+)") or prompt_text
          if #title > 50 then
            title = title:sub(1, 47) .. "..."
          end
          
          local prompt_data = {
            title = title,
            category = "Uncategorized",
            description = "Quick execute",
            prompt = prompt_text,
          }
          
          if prompts_utils.add_prompt(prompt_data) then
            vim.notify("Prompt saved to Uncategorized", vim.log.levels.INFO)
          end
        end)
      end,
      on_cancel = function()
        vim.notify("Execution cancelled", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Execute prompt and save to Uncategorized",
  })
end

return M

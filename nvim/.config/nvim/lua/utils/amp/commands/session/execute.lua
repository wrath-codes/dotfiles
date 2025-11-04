local M = {}

function M.setup()
  -- Execute a prompt on the fly and save to Uncategorized
  vim.api.nvim_create_user_command("AmpSessionExecute", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- Prompt for message
    local input = Input({
      position = "50%",
      size = {
        width = 60,
      },
      border = {
        style = "rounded",
        text = {
          top = " Execute Prompt ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Prompt: ",
      on_close = function()
        vim.notify("Execution cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(prompt_text)
        if not prompt_text or prompt_text == "" then
          vim.notify("No prompt provided", vim.log.levels.WARN)
          return
        end

        -- Execute the prompt in terminal
        local cmd = "amp -x " .. vim.fn.shellescape(prompt_text) .. "; echo '\nPress any key to close...'; read -n 1"
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

        -- Save to Uncategorized in the background
        vim.schedule(function()
          local prompts_utils = require("utils.amp.utils.prompts")
          
          -- Ensure Uncategorized category exists
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
          
          -- Generate a simple title from the prompt (first 50 chars or first line)
          local title = prompt_text:match("^([^\n]+)") or prompt_text
          if #title > 50 then
            title = title:sub(1, 47) .. "..."
          end
          
          -- Save the prompt
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
    })

    input:mount()
    input:map("n", "<Esc>", function() input:unmount() end)
    input:map("n", "q", function() input:unmount() end)
    input:on(event.BufLeave, function() input:unmount() end)
  end, {
    desc = "Execute prompt and save to Uncategorized",
  })
end

return M

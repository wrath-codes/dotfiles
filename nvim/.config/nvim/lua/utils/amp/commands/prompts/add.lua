local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXAdd", function()
    local prompts_utils = require("utils.amp.utils.prompts")
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local form_data = {}

    -- First input: title
    local title_input = Input({
      position = "50%",
      size = {
        width = 40,
      },
      border = {
        style = "rounded",
        text = {
          top = " Prompt Title ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Title: ",
      on_close = function()
        vim.notify("Add prompt cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(title)
        if not title or title == "" then
          vim.notify("No title provided", vim.log.levels.WARN)
          return
        end
        form_data.title = title

        -- Second input: category selection
        local categories = prompts_utils.get_category_names()
        vim.ui.select(categories, {
        prompt = "Select category:",
        }, function(choice)
        if not choice then
          vim.notify("Add prompt cancelled", vim.log.levels.INFO)
        return
        end

        if choice == "Add new..." then
        vim.ui.input({ prompt = "New category name:" }, function(new_cat)
            if new_cat and new_cat ~= "" then
              prompts_utils.add_category({ name = new_cat })
            form_data.category = new_cat
              M.continue_add_prompt(form_data)
              end
          end)
        else
        form_data.category = choice
          M.continue_add_prompt(form_data)
        end
        end)
      end,
    })

    title_input:mount()
    title_input:map("n", "<Esc>", function()
      title_input:unmount()
    end)
    title_input:map("n", "q", function()
      title_input:unmount()
    end)
    title_input:on(event.BufLeave, function()
      title_input:unmount()
    end)
  end, {
    desc = "Add a new Amp prompt",
  })
end

--- Continue adding prompt after category selection
---@param form_data table
function M.continue_add_prompt(form_data)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  -- Third input: description
  local desc_input = Input({
    position = "50%",
    size = {
      width = 60,
    },
    border = {
      style = "rounded",
      text = {
        top = " Description ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "Description: ",
    on_close = function()
      vim.notify("Add prompt cancelled", vim.log.levels.INFO)
    end,
    on_submit = function(description)
      form_data.description = description or ""

      -- Fourth input: prompt text
      local prompt_input = Input({
        position = "50%",
        size = {
          width = 80,
        },
        border = {
          style = "rounded",
          text = {
            top = " Prompt Text ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      }, {
        prompt = "> ",
        on_close = function()
          vim.notify("Add prompt cancelled", vim.log.levels.INFO)
        end,
        on_submit = function(prompt_text)
          if not prompt_text or prompt_text == "" then
            vim.notify("No prompt provided", vim.log.levels.WARN)
            return
          end
          form_data.prompt = prompt_text

          -- Save the prompt
          if require("utils.amp.utils.prompts").add_prompt(form_data) then
            vim.notify("Prompt '" .. form_data.title .. "' added", vim.log.levels.INFO)
          end
        end,
      })

      prompt_input:mount()
      prompt_input:map("n", "<Esc>", function()
        prompt_input:unmount()
      end)
      prompt_input:map("n", "q", function()
        prompt_input:unmount()
      end)
      prompt_input:on(event.BufLeave, function()
        prompt_input:unmount()
      end)
    end,
  })

  desc_input:mount()
  desc_input:map("n", "<Esc>", function()
    desc_input:unmount()
  end)
  desc_input:map("n", "q", function()
    desc_input:unmount()
  end)
  desc_input:on(event.BufLeave, function()
    desc_input:unmount()
  end)
end

return M

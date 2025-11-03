local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXAdd", function()
    local prompts_utils = require("utils.amp.utils.prompts")

    -- Get visual selection for default title
    local bufnr = vim.api.nvim_get_current_buf()
    local start_line = vim.api.nvim_buf_get_mark(bufnr, "<")[1]
    local end_line = vim.api.nvim_buf_get_mark(bufnr, ">")[1]
    local lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)

    if #lines == 0 then
      vim.notify("No selection", vim.log.levels.WARN)
      return
    end

    -- Get current filetype for language tag
    local ft = vim.bo.filetype

    -- Get first line as default title suggestion
    local first_line = lines[1]:gsub("^%s*(.-)%s*$", "%1")
    first_line = first_line:gsub("^#+%s*", "")

    vim.ui.input({ prompt = "Prompt title: ", default = first_line }, function(title)
      if not title or title == "" then
        vim.notify("No title provided", vim.log.levels.WARN)
        return
      end

      -- Second input: category selection
      local categories = prompts_utils.get_category_names()
      vim.ui.select(categories, {
        prompt = "Select category:",
      }, function(choice)
        if not choice then
          vim.notify("Add prompt cancelled", vim.log.levels.INFO)
          return
        end

        local form_data = { title = title }

        if choice == "Add new..." then
          vim.ui.input({ prompt = "New category name:" }, function(new_cat)
            if new_cat and new_cat ~= "" then
              prompts_utils.add_category({ name = new_cat })
              form_data.category = new_cat
              M.continue_add_prompt(form_data, lines)
            end
          end)
        else
          form_data.category = choice
          M.continue_add_prompt(form_data, lines)
        end
      end)
    end)
  end, {
    desc = "Add a new Amp prompt",
  })
end

--- Continue adding prompt after category selection
---@param form_data table
---@param selected_lines table The selected lines from visual mode
function M.continue_add_prompt(form_data, selected_lines)
  vim.ui.input({ prompt = "Description: ", default = "" }, function(description)
    form_data.description = description or ""

    -- Use selected lines as default prompt
    local default_prompt = table.concat(selected_lines or {}, "\n")
    vim.ui.input({ prompt = "Prompt text: ", default = default_prompt }, function(prompt_text)
      if not prompt_text or prompt_text == "" then
        vim.notify("No prompt provided", vim.log.levels.WARN)
        return
      end
      form_data.prompt = prompt_text

      -- Save the prompt
      if require("utils.amp.utils.prompts").add_prompt(form_data) then
        vim.notify("Prompt '" .. form_data.title .. "' added", vim.log.levels.INFO)
      end
    end)
  end)
end

return M

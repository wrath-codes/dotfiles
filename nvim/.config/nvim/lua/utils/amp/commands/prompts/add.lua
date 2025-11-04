local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXAdd", function()
    local prompts_utils = require("utils.amp.utils.prompts")
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- Try to get visual selection for default prompt text
    local bufnr = vim.api.nvim_get_current_buf()
    local lines = {}
    local first_line = ""
    
    -- Check if we have a visual selection
    local mode = vim.fn.mode()
    if mode == "v" or mode == "V" or mode == "\22" then
      -- In visual mode, get the selection
      local start_pos = vim.fn.getpos("'<")
      local end_pos = vim.fn.getpos("'>")
      local start_line = start_pos[2]
      local end_line = end_pos[2]
      lines = vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
    else
      -- Not in visual mode, check for previous visual selection marks
      local start_mark = vim.api.nvim_buf_get_mark(bufnr, "<")
      local end_mark = vim.api.nvim_buf_get_mark(bufnr, ">")
      if start_mark[1] > 0 and end_mark[1] > 0 and start_mark[1] <= end_mark[1] then
        lines = vim.api.nvim_buf_get_lines(bufnr, start_mark[1] - 1, end_mark[1], false)
      end
    end

    -- Get first line as default title suggestion if we have lines
    if #lines > 0 then
      first_line = lines[1]:gsub("^%s*(.-)%s*$", "%1")
      first_line = first_line:gsub("^#+%s*", "")
    end

    -- First input: title
    local title_input = Input({
      position = "50%",
      size = {
        width = 60,
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
      default_value = first_line,
      on_close = function()
        vim.notify("Add cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(title)
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
            -- New category input
            local cat_input = Input({
              position = "50%",
              size = {
                width = 40,
              },
              border = {
                style = "rounded",
                text = {
                  top = " New Category ",
                  top_align = "center",
                },
              },
              win_options = {
                winhighlight = "Normal:Normal,FloatBorder:Normal",
              },
            }, {
              prompt = "Name: ",
              on_close = function()
                vim.notify("Add cancelled", vim.log.levels.INFO)
              end,
              on_submit = function(new_cat)
                if new_cat and new_cat ~= "" then
                  prompts_utils.add_category({ name = new_cat })
                  form_data.category = new_cat
                  M.continue_add_prompt(form_data, lines)
                end
              end,
            })
            
            cat_input:mount()
            cat_input:map("n", "<Esc>", function() cat_input:unmount() end)
            cat_input:map("n", "q", function() cat_input:unmount() end)
            cat_input:on(event.BufLeave, function() cat_input:unmount() end)
          else
            form_data.category = choice
            M.continue_add_prompt(form_data, lines)
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
---@param selected_lines table The selected lines from visual mode
function M.continue_add_prompt(form_data, selected_lines)
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  -- Description input
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
    prompt = "Desc: ",
    on_close = function()
      vim.notify("Add cancelled", vim.log.levels.INFO)
    end,
    on_submit = function(description)
      form_data.description = description or ""

      -- Prompt text input
      local default_prompt = table.concat(selected_lines or {}, "\n")
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
        default_value = default_prompt,
        on_close = function()
          vim.notify("Add cancelled", vim.log.levels.INFO)
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
      prompt_input:map("n", "<Esc>", function() prompt_input:unmount() end)
      prompt_input:map("n", "q", function() prompt_input:unmount() end)
      prompt_input:on(event.BufLeave, function() prompt_input:unmount() end)
    end,
  })

  desc_input:mount()
  desc_input:map("n", "<Esc>", function() desc_input:unmount() end)
  desc_input:map("n", "q", function() desc_input:unmount() end)
  desc_input:on(event.BufLeave, function() desc_input:unmount() end)
end

return M

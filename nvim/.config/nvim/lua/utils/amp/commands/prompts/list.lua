local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpDashX", function()
    local prompts_utils = require("utils.amp.utils.prompts")
    local cli = require("utils.amp.utils.cli")
    local prompts = prompts_utils.get_prompts()

    if #prompts == 0 then
      vim.notify("No prompts saved. Use AmpDashXAdd to add one.", vim.log.levels.INFO)
      return
    end

    local items = {}
    for _, p in ipairs(prompts) do
      table.insert(items, {
        text = p.title .. " (" .. p.category .. "): " .. p.description,
        prompt = p.prompt,
        id = p.id,
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
      title = " Amp Dash X ",
      layout = layout_config,
      actions = {
        delete_prompt = function(picker, item)
          if prompts_utils.delete_prompt(item.id) then
            vim.notify("Prompt '" .. item.title .. "' deleted", vim.log.levels.INFO)
            -- Refresh the list
            vim.schedule(function()
              vim.cmd("AmpDashX")
            end)
          end
        end,
        edit_prompt = function(picker, item)
          picker:close()
          M.edit_prompt_inline(item)
        end,
        change_category = function(picker, item)
          picker:close()
          M.change_category(item)
        end,
        send_prompt = function(picker, item)
          picker:close()
          require("snacks").terminal("amp -x " .. vim.fn.shellescape(item.prompt), {
            win = { style = "float" },
          })
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-S-d>"] = { "delete_prompt", mode = { "i", "n" } },
            ["<C-S-e>"] = { "edit_prompt", mode = { "i", "n" } },
            ["<C-S-c>"] = { "change_category", mode = { "i", "n" } },
            ["<C-S-s>"] = { "send_prompt", mode = { "i", "n" } },
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
          "*Press `<C-S-s>` to execute with `amp -x`*",
        }

        ctx.preview:reset()
        ctx.preview:set_lines(lines)
        ctx.preview:highlight({ ft = "markdown" })
      end,
      confirm = function(picker, item)
        picker:close()
        vim.fn.setreg("+", item.prompt)
        vim.notify("Copied prompt to clipboard", vim.log.levels.INFO)
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
            " <C-S-d>  delete prompt",
            " <C-S-e>  edit prompt",
            " <C-S-c>  change category",
            " <C-S-s>  send prompt in terminal",
            " <CR>     copy prompt to clipboard",
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
          vim.hl.range(buf, ns, "Comment", { 0, 10 }, { 0, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 55 }, { 0, 67 })
          vim.hl.range(buf, ns, "Comment", { 0, 67 }, { 0, -1 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 0 }, { 1, 9 })
          vim.hl.range(buf, ns, "Comment", { 1, 9 }, { 1, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 55 }, { 1, 67 })
          vim.hl.range(buf, ns, "Comment", { 1, 67 }, { 1, -1 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 2, 0 }, { 2, 9 })
          vim.hl.range(buf, ns, "Comment", { 2, 9 }, { 2, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 2, 55 }, { 2, 67 })
          vim.hl.range(buf, ns, "Comment", { 2, 67 }, { 2, -1 })
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
    desc = "List and execute saved Amp prompts",
  })
end

--- Edit prompt inline (open buffer for editing)
---@param item table The prompt item
function M.edit_prompt_inline(item)
  -- Create a temporary buffer for editing
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "Amp Prompt Edit")
  vim.api.nvim_buf_set_option(buf, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  -- Set initial content
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(item.prompt, "\n"))

  -- Open in a floating window
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local win = vim.api.nvim_open_win(buf, true, {
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
    title = " Edit Prompt: " .. item.title .. " ",
  })

  -- Set up autocmd to save on write
  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = buf,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local new_prompt = table.concat(lines, "\n")
      if prompts_utils.update_prompt(item.id, { prompt = new_prompt }) then
        vim.notify("Prompt updated", vim.log.levels.INFO)
        vim.api.nvim_win_close(win, false)
        -- Refresh the list
        vim.schedule(function()
          vim.cmd("AmpDashX")
        end)
      else
        vim.notify("Failed to update prompt", vim.log.levels.ERROR)
      end
    end,
  })

  -- Instructions
  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "-- Press :w to save, :q to cancel" })
end

--- Change category of a prompt
---@param item table The prompt item
function M.change_category(item)
  local current_category = item.category
  local categories = prompts_utils.get_category_names()

  vim.ui.select(categories, {
    prompt = "Select new category (current: " .. current_category .. "):",
  }, function(choice)
    if choice == "Add new..." then
      vim.ui.input({ prompt = "New category name:" }, function(new_cat)
        if new_cat and new_cat ~= "" then
          prompts_utils.add_category({ name = new_cat })
          if prompts_utils.update_prompt(item.id, { category = new_cat }) then
            vim.notify("Category changed to '" .. new_cat .. "'", vim.log.levels.INFO)
            vim.schedule(function()
              vim.cmd("AmpDashX")
            end)
          end
        end
      end)
    elseif choice and choice ~= current_category then
      if prompts_utils.update_prompt(item.id, { category = choice }) then
        vim.notify("Category changed to '" .. choice .. "'", vim.log.levels.INFO)
        vim.schedule(function()
          vim.cmd("AmpDashX")
        end)
      end
    end
  end)
end

return M

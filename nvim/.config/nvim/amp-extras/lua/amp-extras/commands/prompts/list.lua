local M = {}

local picker = require("amp-extras.core.picker")
local terminal = require("amp-extras.core.terminal")
local markdown = require("amp-extras.core.markdown")
local input = require("amp-extras.core.input")
local utils = require("amp-extras.core.utils")

function M.setup()
  vim.api.nvim_create_user_command("AmpDashX", function()
    local prompts_utils = require("amp-extras.utils.prompts")
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
        title = p.title,
        category = p.category,
        description = p.description,
      })
    end

    local hints = {
      " <C-S-d>  delete prompt",
      " <C-S-e>  edit prompt",
      " <C-S-c>  change category",
      " <C-S-s>  send prompt in terminal",
      " <CR>     copy prompt to clipboard",
      " ?        toggle help",
    }

    picker.show({
      items = items,
      title = " Amp Dash X ",
      layout = picker.create_layout(),
      actions = {
        ["<C-S-d>"] = function(p, item)
          if prompts_utils.delete_prompt(item.id) then
            vim.notify("Prompt '" .. item.title .. "' deleted", vim.log.levels.INFO)
            vim.schedule(function()
              vim.cmd("AmpDashX")
            end)
          end
        end,
        ["<C-S-e>"] = function(p, item)
          M.edit_prompt_inline(item)
        end,
        ["<C-S-c>"] = function(p, item)
          p:close()
          M.change_category(item)
        end,
        ["<C-S-s>"] = function(p, item)
          p:close()
          terminal.amp_prompt(item.prompt)
        end,
      },
      format = function(item)
        return { { item.text, "SnacksPickerLabel" } }
      end,
      preview = function(ctx)
        markdown.render_preview(ctx, ctx.item, {
          footer = markdown.create_footer({
            ["<CR>"] = "copy to clipboard",
            ["<C-S-s>"] = "execute with amp -x",
          }),
        })
      end,
      confirm = function(p, item)
        p:close()
        utils.copy_to_clipboard(item.prompt)
      end,
      on_show = function(p)
        picker.show_hints(p, hints)
      end,
      on_close = function(p)
        picker.close_hints(p)
      end,
    })
  end, {
    desc = "List and execute saved Amp prompts",
  })
end

---Edit prompt inline (open buffer for editing)
---@param item table The prompt item
function M.edit_prompt_inline(item)
  local prompts_utils = require("amp-extras.utils.prompts")

  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_name(buf, "Amp Prompt Edit")
  vim.api.nvim_buf_set_option(buf, "buftype", "acwrite")
  vim.api.nvim_buf_set_option(buf, "filetype", "markdown")

  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(item.prompt, "\n"))

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

  vim.api.nvim_create_autocmd("BufWriteCmd", {
    buffer = buf,
    callback = function()
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local new_prompt = table.concat(lines, "\n")
      if prompts_utils.update_prompt(item.id, { prompt = new_prompt }) then
        vim.notify("Prompt updated", vim.log.levels.INFO)
        vim.api.nvim_win_close(win, false)
        vim.schedule(function()
          vim.cmd("AmpDashX")
        end)
      else
        vim.notify("Failed to update prompt", vim.log.levels.ERROR)
      end
    end,
  })

  vim.api.nvim_buf_set_lines(buf, -1, -1, false, { "", "-- Press :w to save, :q to cancel" })
end

---Change category of a prompt
---@param item table The prompt item
function M.change_category(item)
  local prompts_utils = require("amp-extras.utils.prompts")
  local current_category = item.category
  local categories = prompts_utils.get_category_names()

  input.select(categories, {
    prompt = "Select new category (current: " .. current_category .. "):",
  }, function(choice)
    if choice == "Add new..." then
      input.prompt({
        prompt = "New category name",
        on_submit = function(new_cat)
          if new_cat and new_cat ~= "" then
            prompts_utils.add_category({ name = new_cat })
            if prompts_utils.update_prompt(item.id, { category = new_cat }) then
              vim.notify("Category changed to '" .. new_cat .. "'", vim.log.levels.INFO)
              vim.schedule(function()
                vim.cmd("AmpDashX")
              end)
            end
          end
        end,
      })
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

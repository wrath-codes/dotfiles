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
          picker:close()
          M.edit_prompt(item.prompt_data)
        end,
      },
      win = {
        input = {
          keys = {
            ["<C-S-d>"] = { "delete", mode = { "i", "n" } },
            ["<C-S-e>"] = { "edit", mode = { "i", "n" } },
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
            height = 2,
            row = row,
            col = col_start,
            border = "rounded",
            style = "minimal",
            title = " Key Hints ",
          })
          local hints = {
            " <C-S-d>   delete prompt",
            " <C-S-e>   edit prompt",
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
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 0 }, { 0, 10 })
          vim.hl.range(buf, ns, "Comment", { 0, 10 }, { 0, 55 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 0, 55 }, { 0, 67 })
          vim.hl.range(buf, ns, "Comment", { 0, 67 }, { 0, -1 })
          vim.hl.range(buf, ns, "SnacksPickerLabel", { 1, 0 }, { 1, 4 })
          vim.hl.range(buf, ns, "Comment", { 1, 4 }, { 1, -1 })
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
  local prompts_utils = require("utils.amp.utils.prompts")
  local Input = require("nui.input")
  local event = require("nui.utils.autocmd").event

  local form_data = { id = existing.id }

  -- First input: title
  local title_input = Input({
    position = "50%",
    size = {
      width = 40,
    },
    border = {
      style = "rounded",
      text = {
        top = " Edit Prompt Title ",
        top_align = "center",
      },
    },
    win_options = {
      winhighlight = "Normal:Normal,FloatBorder:Normal",
    },
  }, {
    prompt = "Title: ",
    default_value = existing.title,
    on_close = function()
      vim.notify("Edit cancelled", vim.log.levels.INFO)
    end,
    on_submit = function(title)
      if not title or title == "" then
        vim.notify("No title provided", vim.log.levels.WARN)
        return
      end
      form_data.title = title

      -- Second input: category
      local category_input = Input({
        position = "50%",
        size = {
          width = 40,
        },
        border = {
          style = "rounded",
          text = {
            top = " Edit Category ",
            top_align = "center",
          },
        },
        win_options = {
          winhighlight = "Normal:Normal,FloatBorder:Normal",
        },
      }, {
        prompt = "Category: ",
        default_value = existing.category,
        on_close = function()
          vim.notify("Edit cancelled", vim.log.levels.INFO)
        end,
        on_submit = function(category)
          form_data.category = category or "General"

          -- Third input: description
          local desc_input = Input({
            position = "50%",
            size = {
              width = 60,
            },
            border = {
              style = "rounded",
              text = {
                top = " Edit Description ",
                top_align = "center",
              },
            },
            win_options = {
              winhighlight = "Normal:Normal,FloatBorder:Normal",
            },
          }, {
            prompt = "Description: ",
            default_value = existing.description,
            on_close = function()
              vim.notify("Edit cancelled", vim.log.levels.INFO)
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
                    top = " Edit Prompt Text ",
                    top_align = "center",
                  },
                },
                win_options = {
                  winhighlight = "Normal:Normal,FloatBorder:Normal",
                },
              }, {
                prompt = "> ",
                default_value = existing.prompt,
                on_close = function()
                  vim.notify("Edit cancelled", vim.log.levels.INFO)
                end,
                on_submit = function(prompt_text)
                  if not prompt_text or prompt_text == "" then
                    vim.notify("No prompt provided", vim.log.levels.WARN)
                    return
                  end
                  form_data.prompt = prompt_text

                  -- Update the prompt
                  local data = prompts_utils.load_data()
                  for i, p in ipairs(data.prompts) do
                    if p.id == existing.id then
                      data.prompts[i] = form_data
                      if prompts_utils.save_data(data) then
                        vim.notify("Prompt '" .. form_data.title .. "' updated", vim.log.levels.INFO)
                      end
                      return
                    end
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
        end,
      })

      category_input:mount()
      category_input:map("n", "<Esc>", function()
        category_input:unmount()
      end)
      category_input:map("n", "q", function()
        category_input:unmount()
      end)
      category_input:on(event.BufLeave, function()
        category_input:unmount()
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
end

return M

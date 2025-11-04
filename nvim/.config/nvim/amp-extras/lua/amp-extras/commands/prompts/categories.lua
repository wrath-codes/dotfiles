local M = {}

local picker = require("amp-extras.core.picker")
local markdown = require("amp-extras.core.markdown")
local input = require("amp-extras.core.input")

function M.setup()
  vim.api.nvim_create_user_command("AmpDashXCategories", function()
    M.show_categories()
  end, {
    desc = "Manage Amp prompt categories",
  })
end

---Show categories picker
function M.show_categories()
  local prompts_utils = require("amp-extras.utils.prompts")
  local categories = prompts_utils.get_categories()

  if #categories == 0 then
    vim.notify("No categories found. Add one with Ctrl+Shift+A.", vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, cat in ipairs(categories) do
    local prompt_count = #prompts_utils.get_prompts_by_category(cat.name)
    table.insert(items, {
      text = cat.name .. " (" .. prompt_count .. " prompts)",
      id = cat.id,
      name = cat.name,
      prompt_count = prompt_count,
    })
  end

  local hints = {
    " <C-S-d>  delete category (moves prompts to Undefined)",
    " <C-S-a>  add new category",
    " <C-S-e>  edit category name",
    " <CR>     view prompts in category",
    " ?        toggle help",
  }

  picker.show({
    items = items,
    title = " Manage Categories ",
    layout = picker.create_layout(),
    actions = {
      ["<C-S-d>"] = function(p, item)
        M.delete_category(p, item)
      end,
      ["<C-S-a>"] = function(p, item)
        M.add_category()
      end,
      ["<C-S-e>"] = function(p, item)
        M.edit_category(item)
      end,
    },
    format = function(item)
      return { { item.text, "SnacksPickerLabel" } }
    end,
    preview = function(ctx)
      local prompts = prompts_utils.get_prompts_by_category(ctx.item.name)
      markdown.render_category_preview(ctx, ctx.item, prompts)
    end,
    confirm = function(p, item)
      p:close()
      M.show_category_prompts(item)
    end,
    on_show = function(p)
      picker.show_hints(p, hints)
    end,
    on_close = function(p)
      picker.close_hints(p)
    end,
  })
end

---Delete a category
---@param p table Picker instance
---@param item table Category item
function M.delete_category(p, item)
  local prompts_utils = require("amp-extras.utils.prompts")
  
  p:close()
  
  if item.prompt_count > 0 then
    input.select({ "Cancel", "Delete and move to Undefined" }, {
      prompt = "Delete category '" .. item.name .. "'? " .. item.prompt_count .. " prompts will be moved to 'Undefined'.",
    }, function(choice)
      if choice == "Delete and move to Undefined" then
        if prompts_utils.delete_category(item.id) then
          vim.notify("Category '" .. item.name .. "' deleted, prompts moved to 'Undefined'", vim.log.levels.INFO)
          vim.schedule(M.show_categories)
        end
      end
    end)
  else
    if prompts_utils.delete_category(item.id) then
      vim.notify("Category '" .. item.name .. "' deleted", vim.log.levels.INFO)
      vim.schedule(M.show_categories)
    end
  end
end

---Add a new category
function M.add_category()
  input.prompt({
    prompt = "New category name",
    title = "New Category",
    on_submit = function(new_name)
      if new_name and new_name ~= "" then
        local prompts_utils = require("amp-extras.utils.prompts")
        if prompts_utils.add_category({ name = new_name }) then
          vim.notify("Category '" .. new_name .. "' added", vim.log.levels.INFO)
          vim.schedule(M.show_categories)
        end
      end
    end,
  })
end

---Edit a category name
---@param item table Category item
function M.edit_category(item)
  local prompts_utils = require("amp-extras.utils.prompts")
  
  input.prompt({
    prompt = "New name for '" .. item.name .. "'",
    title = "Edit Category",
    default = item.name,
    on_submit = function(new_name)
      if new_name and new_name ~= "" and new_name ~= item.name then
        local data = prompts_utils.load_data()
        local updated = false
        
        for _, prompt in ipairs(data.prompts) do
          if prompt.category == item.name then
            prompt.category = new_name
            updated = true
          end
        end
        
        for _, cat in ipairs(data.categories) do
          if cat.id == item.id then
            cat.name = new_name
            updated = true
            break
          end
        end
        
        if updated and prompts_utils.save_data(data) then
          vim.notify("Category renamed to '" .. new_name .. "'", vim.log.levels.INFO)
          vim.schedule(M.show_categories)
        end
      end
    end,
  })
end

---Show prompts in a category
---@param category_item table Category item
function M.show_category_prompts(category_item)
  local prompts_utils = require("amp-extras.utils.prompts")
  local category_prompts = prompts_utils.get_prompts_by_category(category_item.name)
  
  if #category_prompts == 0 then
    vim.notify("No prompts in category '" .. category_item.name .. "'", vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, p in ipairs(category_prompts) do
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
    " <C-S-s>  switch category",
    " <C-S-x>  execute prompt in terminal",
    " <C-S-c>  copy amp command",
    " <CR>     copy prompt to clipboard",
    " ?        toggle help",
  }
  
  local terminal = require("amp-extras.core.terminal")
  local utils = require("amp-extras.core.utils")

  picker.show({
    items = items,
    title = " Prompts in " .. category_item.name .. " ",
    layout = picker.create_layout(),
    actions = {
      ["<C-S-d>"] = function(p, item)
        if prompts_utils.delete_prompt(item.id) then
          vim.notify("Prompt '" .. item.title .. "' deleted", vim.log.levels.INFO)
          vim.schedule(M.show_categories)
        end
      end,
      ["<C-S-e>"] = function(p, item)
        require("amp-extras.commands.prompts.manage").edit_prompt(item)
      end,
      ["<C-S-s>"] = function(p, item)
        p:close()
        require("amp-extras.commands.prompts.list").change_category(item)
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
          ["<CR>"] = "copy prompt to clipboard",
          ["<C-S-x>"] = "execute with amp -x",
          ["<C-S-c>"] = "copy amp command",
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
end

return M

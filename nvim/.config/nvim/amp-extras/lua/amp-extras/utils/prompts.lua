---@class PromptsUtil
local M = {}

---Get storage path from config
---@return string path
local function get_storage_path()
  local config = require("amp-extras.config").get()
  return config.data_dir .. "/prompts.json"
end

---Ensure the directory for storage_path exists
---@param path string
local function ensure_directory_exists(path)
  local dir = vim.fn.fnamemodify(path, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

---Load prompts and categories from storage file
---@return table data The loaded data {prompts = {...}, categories = {...}}
function M.load_data()
  local storage_path = get_storage_path()

  if vim.fn.filereadable(storage_path) == 1 then
    local content = table.concat(vim.fn.readfile(storage_path), "\n")
    local ok, parsed = pcall(vim.json.decode, content)
    if ok then
      return parsed
    else
      vim.notify("Failed to parse prompts file: " .. parsed, vim.log.levels.WARN)
      local defaults = require("amp-extras.data.defaults")
      return { prompts = defaults.prompts, categories = defaults.categories }
    end
  end

  local defaults = require("amp-extras.data.defaults")
  local data = { prompts = defaults.prompts, categories = defaults.categories }
  M.save_data(data)
  return data
end

---Save prompts and categories to storage file
---@param data table The data to save {prompts = {...}, categories = {...}}
---@return boolean success True if saved successfully
function M.save_data(data)
  local storage_path = get_storage_path()
  ensure_directory_exists(storage_path)

  local ok, encoded = pcall(vim.json.encode, data)
  if ok then
    local success = pcall(vim.fn.writefile, vim.split(encoded, "\n"), storage_path)
    if success then
      return true
    else
      vim.notify("Failed to write prompts file", vim.log.levels.ERROR)
      return false
    end
  else
    vim.notify("Failed to encode prompts: " .. encoded, vim.log.levels.ERROR)
    return false
  end
end

---Add a new prompt
---@param prompt table {title, description, category, prompt}
---@return boolean success
function M.add_prompt(prompt)
  local data = M.load_data()
  local utils = require("amp-extras.core.utils")
  prompt.id = utils.generate_id()
  table.insert(data.prompts, prompt)
  return M.save_data(data)
end

---Get all prompts
---@return table prompts
function M.get_prompts()
  local data = M.load_data()
  return data.prompts
end

---Get prompts by category
---@param category string
---@return table prompts
function M.get_prompts_by_category(category)
  local all = M.get_prompts()
  local utils = require("amp-extras.core.utils")
  return utils.table_filter(all, function(p)
    return p.category == category
  end)
end

---Delete a prompt by id
---@param id string
---@return boolean success
function M.delete_prompt(id)
  local data = M.load_data()
  for i, p in ipairs(data.prompts) do
    if p.id == id then
      table.remove(data.prompts, i)
      return M.save_data(data)
    end
  end
  return false
end

---Get all categories
---@return table categories
function M.get_categories()
  local data = M.load_data()
  return data.categories
end

---Add a new category
---@param category table {name}
---@return boolean success
function M.add_category(category)
  local data = M.load_data()
  local utils = require("amp-extras.core.utils")
  category.id = utils.generate_id()
  table.insert(data.categories, category)
  return M.save_data(data)
end

---Delete a category and move prompts to "Undefined"
---@param category_id string
---@return boolean success
function M.delete_category(category_id)
  local data = M.load_data()
  local category_name = nil

  for i, cat in ipairs(data.categories) do
    if cat.id == category_id then
      category_name = cat.name
      table.remove(data.categories, i)
      break
    end
  end

  if not category_name then
    return false
  end

  for _, prompt in ipairs(data.prompts) do
    if prompt.category == category_name then
      prompt.category = "Undefined"
    end
  end

  return M.save_data(data)
end

---Update a prompt
---@param id string
---@param updates table
---@return boolean success
function M.update_prompt(id, updates)
  local data = M.load_data()
  for i, p in ipairs(data.prompts) do
    if p.id == id then
      for k, v in pairs(updates) do
        data.prompts[i][k] = v
      end
      return M.save_data(data)
    end
  end
  return false
end

---Get category names for selection
---@return table category_names
function M.get_category_names()
  local data = M.load_data()
  local names = {}
  for _, cat in ipairs(data.categories) do
    table.insert(names, cat.name)
  end
  table.insert(names, "Add new...")
  return names
end

return M

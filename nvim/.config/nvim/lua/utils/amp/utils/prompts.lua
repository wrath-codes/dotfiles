local M = {}

-- Default storage path for prompts
M.storage_path = vim.fn.expand("~/amp/dashx_prompts/prompts.json")

--- Ensure the directory for storage_path exists
---@param path string
local function ensure_directory_exists(path)
  local dir = vim.fn.fnamemodify(path, ":h")
  if vim.fn.isdirectory(dir) == 0 then
    vim.fn.mkdir(dir, "p")
  end
end

--- Default prompts to include when starting fresh
local default_prompts = {
  {
    id = "default_1",
    title = "Fix TypeScript errors",
    description = "Fix all TypeScript errors in the current file",
    category = "Code Fixes",
    prompt = "Fix all the TypeScript errors in this file"
  },
  {
    id = "default_2",
    title = "Run tests and fix",
    description = "Run the tests and fix any failing ones",
    category = "Testing",
    prompt = "Run the tests and fix any failing ones"
  },
  {
    id = "default_3",
    title = "Add dark mode toggle",
    description = "Add a dark mode toggle to this React component",
    category = "UI/UX",
    prompt = "Add a dark mode toggle to this React component"
  },
  {
    id = "default_4",
    title = "Find auth logic",
    description = "Find where user authentication is handled in this codebase",
    category = "Code Analysis",
    prompt = "Find where user authentication is handled in this codebase"
  },
  {
    id = "default_5",
    title = "Plan real-time chat",
    description = "Plan how to add real-time chat to this app, but don't write code yet",
    category = "Planning",
    prompt = "Plan how to add real-time chat to this app, but don't write code yet"
  }
}

local default_categories = {
  { id = "cat_1", name = "Code Fixes" },
  { id = "cat_2", name = "Testing" },
  { id = "cat_3", name = "UI/UX" },
  { id = "cat_4", name = "Code Analysis" },
  { id = "cat_5", name = "Planning" }
}

--- Load prompts and categories from storage file
---@return table data The loaded data {prompts = {...}, categories = {...}} with defaults if empty
function M.load_data()
  if vim.fn.filereadable(M.storage_path) == 1 then
    local content = table.concat(vim.fn.readfile(M.storage_path), "\n")
    local ok, parsed = pcall(vim.json.decode, content)
    if ok then
      -- If no prompts, add defaults
      if #parsed.prompts == 0 then
        parsed.prompts = vim.deepcopy(default_prompts)
        parsed.categories = vim.deepcopy(default_categories)
        M.save_data(parsed) -- Save the defaults
      end
      return parsed
    else
      vim.notify("Failed to parse prompts file: " .. parsed, vim.log.levels.WARN)
      -- Return defaults on parse error
      return { prompts = vim.deepcopy(default_prompts), categories = vim.deepcopy(default_categories) }
    end
  end
  -- File doesn't exist, return defaults
  local data = { prompts = vim.deepcopy(default_prompts), categories = vim.deepcopy(default_categories) }
  M.save_data(data) -- Save defaults to file
  return data
end

--- Save prompts and categories to storage file
---@param data table The data to save {prompts = {...}, categories = {...}}
---@return boolean success True if saved successfully
function M.save_data(data)
  ensure_directory_exists(M.storage_path)
  local ok, encoded = pcall(vim.json.encode, data)
  if ok then
    local success = pcall(vim.fn.writefile, vim.split(encoded, "\n"), M.storage_path)
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

--- Add a new prompt
---@param prompt table {title, description, category, prompt}
---@return boolean success
function M.add_prompt(prompt)
  local data = M.load_data()
  prompt.id = vim.fn.reltimestr(vim.fn.reltime()) -- simple id
  table.insert(data.prompts, prompt)
  return M.save_data(data)
end

--- Get all prompts
---@return table prompts
function M.get_prompts()
  local data = M.load_data()
  return data.prompts
end

--- Get prompts by category
---@param category string
---@return table prompts
function M.get_prompts_by_category(category)
  local all = M.get_prompts()
  local filtered = {}
  for _, p in ipairs(all) do
    if p.category == category then
      table.insert(filtered, p)
    end
  end
  return filtered
end

--- Delete a prompt by id
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

--- Get all categories
---@return table categories
function M.get_categories()
  local data = M.load_data()
  return data.categories
end

--- Add a new category
---@param category table {name}
---@return boolean success
function M.add_category(category)
  local data = M.load_data()
  category.id = vim.fn.reltimestr(vim.fn.reltime())
  table.insert(data.categories, category)
  return M.save_data(data)
end

--- Delete a category and move prompts to "Undefined"
---@param category_id string
---@return boolean success
function M.delete_category(category_id)
  local data = M.load_data()
  local category_name = nil
  -- Find and remove category
  for i, cat in ipairs(data.categories) do
    if cat.id == category_id then
      category_name = cat.name
      table.remove(data.categories, i)
      break
    end
  end
  if not category_name then return false end

  -- Move prompts to "Undefined"
  for _, prompt in ipairs(data.prompts) do
    if prompt.category == category_name then
      prompt.category = "Undefined"
    end
  end
  return M.save_data(data)
end

--- Update a prompt
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

--- Get category names for selection
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

--- Set custom storage path
---@param path string The path to use for storage
function M.set_storage_path(path)
  M.storage_path = vim.fn.expand(path)
end

return M

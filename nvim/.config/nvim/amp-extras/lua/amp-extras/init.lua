---@class AmpExtras
local M = {}

local config = require("amp-extras.config")
local defaults = require("amp-extras.data.defaults")

---@type boolean
local initialized = false

---Ensure data directory exists and initialize if needed
---@param data_dir string
---@return boolean success
local function ensure_data_dir(data_dir)
  local uv = vim.loop
  
  local stat = uv.fs_stat(data_dir)
  if not stat then
    local ok = uv.fs_mkdir(data_dir, 448)
    if not ok then
      vim.notify("amp-extras: Failed to create data directory: " .. data_dir, vim.log.levels.ERROR)
      return false
    end
    vim.notify("amp-extras: Created data directory: " .. data_dir, vim.log.levels.INFO)
  end
  
  return true
end

---Initialize default data file if it doesn't exist
---@param data_dir string
---@return boolean success
local function init_data_file(data_dir)
  local data_file = data_dir .. "/prompts.json"
  local uv = vim.loop
  
  local stat = uv.fs_stat(data_file)
  if stat then
    return true
  end
  
  local default_data = {
    version = "1.0.0",
    categories = defaults.categories,
    prompts = defaults.prompts,
  }
  
  local json = vim.json.encode(default_data)
  local fd = uv.fs_open(data_file, "w", 438)
  if not fd then
    vim.notify("amp-extras: Failed to create data file: " .. data_file, vim.log.levels.ERROR)
    return false
  end
  
  uv.fs_write(fd, json)
  uv.fs_close(fd)
  
  vim.notify("amp-extras: Initialized default prompts and categories", vim.log.levels.INFO)
  return true
end

---Setup amp-extras plugin
---@param user_config table|nil User configuration
---@return boolean success
function M.setup(user_config)
  if initialized then
    vim.notify("amp-extras: Already initialized", vim.log.levels.WARN)
    return true
  end
  
  local conf = config.setup(user_config)
  if not conf then
    return false
  end
  
  if not ensure_data_dir(conf.data_dir) then
    return false
  end
  
  if not init_data_file(conf.data_dir) then
    return false
  end
  
  initialized = true
  
  require("amp-extras.commands").setup()
  
  vim.notify("amp-extras: Plugin initialized successfully", vim.log.levels.INFO)
  
  return true
end

---Check if plugin is initialized
---@return boolean
function M.is_initialized()
  return initialized
end

---Get current configuration
---@return table
function M.get_config()
  return config.get()
end

return M

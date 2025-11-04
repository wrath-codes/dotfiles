---@class AmpExtrasConfig
---@field picker "snacks"|"telescope" Picker backend to use
---@field data_dir string Path to store user data (prompts, categories)
---@field keymaps table<string, any> Custom keymaps configuration

local M = {}

---@type AmpExtrasConfig
M.defaults = {
  picker = "snacks",
  data_dir = vim.fn.expand("~/.config/amp-extras"),
  keymaps = {
    enabled = true,
  },
}

---@type AmpExtrasConfig|nil
M.options = nil

---Deep merge two tables
---@param default table
---@param user table|nil
---@return table
local function deep_merge(default, user)
  local result = vim.deepcopy(default)
  if not user then
    return result
  end
  
  for k, v in pairs(user) do
    if type(v) == "table" and type(result[k]) == "table" then
      result[k] = deep_merge(result[k], v)
    else
      result[k] = v
    end
  end
  
  return result
end

---Validate configuration
---@param config table
---@return boolean success
---@return string|nil error_message
local function validate_config(config)
  local ok, err = pcall(vim.validate, {
    picker = { config.picker, function(p)
      return p == "snacks" or p == "telescope"
    end, "picker must be 'snacks' or 'telescope'" },
    data_dir = { config.data_dir, "string" },
    keymaps = { config.keymaps, "table" },
  })
  
  if not ok then
    return false, err
  end
  
  return true, nil
end

---Setup and validate configuration
---@param user_config AmpExtrasConfig|nil
---@return AmpExtrasConfig|nil
function M.setup(user_config)
  local config = deep_merge(M.defaults, user_config)
  
  local ok, err = validate_config(config)
  if not ok then
    vim.notify("amp-extras: Invalid configuration - " .. (err or "unknown error"), vim.log.levels.ERROR)
    return nil
  end
  
  M.options = config
  return config
end

---Get current configuration
---@return AmpExtrasConfig
function M.get()
  return M.options or M.defaults
end

return M

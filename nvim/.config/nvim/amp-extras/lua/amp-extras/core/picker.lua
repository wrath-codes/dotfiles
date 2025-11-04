---@class PickerItem
---@field text string Display text
---@field [string] any Additional item data

---@class PickerLayout
---@field width number|nil Width ratio (0-1) or absolute
---@field height number|nil Height ratio (0-1) or absolute
---@field min_width number|nil Minimum width
---@field border string|nil Border style
---@field title string|nil Window title

---@class PickerOpts
---@field items table[] Items to pick from
---@field title string Picker title
---@field layout table|nil Layout configuration
---@field format function|nil Format function for items
---@field preview function|nil Preview function
---@field confirm function|nil Confirm callback
---@field actions table<string, function>|nil Custom actions
---@field on_show function|nil On show callback
---@field on_close function|nil On close callback

local M = {}

---Create a standard layout configuration
---@param opts table|nil Layout options
---@return table layout Layout configuration
function M.create_layout(opts)
  opts = opts or {}
  
  local width = opts.width or 0.8
  local height = opts.height or 0.8
  local min_width = opts.min_width or 120
  local preview_width = opts.preview_width or 0.5
  
  return {
    layout = {
      box = "horizontal",
      width = width,
      min_width = min_width,
      height = height,
      {
        box = "vertical",
        border = true,
        title = "{title}",
        { win = "input", height = 1, border = "bottom" },
        { win = "list", border = "none" },
      },
      { win = "preview", width = preview_width, border = "rounded" },
    },
  }
end

---Show hints window with proper highlighting
---@param picker table Picker instance
---@param hints string[] List of hint strings (keybind and description pairs)
---@return number|nil win_id Window ID of hints window
function M.show_hints(picker, hints)
  if picker.hints_win and vim.api.nvim_win_is_valid(picker.hints_win) then
    return picker.hints_win
  end
  
  local buf = vim.api.nvim_create_buf(false, true)
  local col_start = math.floor(0.1 * vim.o.columns)
  local width = math.floor(0.8 * vim.o.columns)
  local row = math.floor(0.9 * vim.o.lines)
  
  local num_lines = math.ceil(#hints / 2)
  
  picker.hints_win = vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    width = width,
    height = num_lines,
    row = row,
    col = col_start,
    border = "rounded",
    style = "minimal",
    title = " Key Hints ",
  })
  
  local hint_lines = {}
  for i = 1, #hints, 2 do
    local line = hints[i]
    if hints[i + 1] then
      line = line .. string.rep(" ", 55 - #hints[i]) .. hints[i + 1]
    end
    table.insert(hint_lines, line)
  end
  
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, hint_lines)
  
  local ns = vim.api.nvim_create_namespace("amp_hints")
  for line_idx = 0, #hint_lines - 1 do
    local base_hint_idx = line_idx * 2 + 1
    
    vim.hl.range(buf, ns, "SnacksPickerLabel", { line_idx, 0 }, { line_idx, 9 })
    vim.hl.range(buf, ns, "Comment", { line_idx, 9 }, { line_idx, 55 })
    
    if hints[base_hint_idx + 1] then
      local second_key_end = 64
      if hints[base_hint_idx + 1]:match("^%s*<[^>]+>") then
        second_key_end = 55 + #hints[base_hint_idx + 1]:match("^%s*(<[^>]+>)")
      end
      
      vim.hl.range(buf, ns, "SnacksPickerLabel", { line_idx, 55 }, { line_idx, second_key_end })
      vim.hl.range(buf, ns, "Comment", { line_idx, second_key_end }, { line_idx, -1 })
    end
  end
  
  return picker.hints_win
end

---Close hints window
---@param picker table Picker instance
function M.close_hints(picker)
  if picker.hints_win and vim.api.nvim_win_is_valid(picker.hints_win) then
    vim.api.nvim_win_close(picker.hints_win, true)
    picker.hints_win = nil
  end
end

---Format actions for picker keybindings
---@param actions table<string, function> Action functions
---@param modes table|nil Modes to apply (default: {"i", "n"})
---@return table formatted Formatted actions for picker
function M.format_actions(actions, modes)
  modes = modes or { "i", "n" }
  local formatted = {}
  
  for key, action in pairs(actions) do
    formatted[key] = { action, mode = modes }
  end
  
  return formatted
end

---Create and show a picker using configured backend
---@param opts PickerOpts Picker options
---@return boolean success
function M.show(opts)
  local config = require("amp-extras.config").get()
  
  if config.picker == "snacks" then
    return M.show_snacks(opts)
  elseif config.picker == "telescope" then
    return M.show_telescope(opts)
  else
    vim.notify("amp-extras: Unsupported picker backend: " .. config.picker, vim.log.levels.ERROR)
    return false
  end
end

---Show picker using snacks.nvim
---@param opts PickerOpts Picker options
---@return boolean success
function M.show_snacks(opts)
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("amp-extras: snacks.nvim not found", vim.log.levels.ERROR)
    return false
  end
  
  local picker_opts = {
    items = opts.items,
    title = opts.title,
    layout = opts.layout,
    format = opts.format,
    preview = opts.preview,
    confirm = opts.confirm,
    on_show = opts.on_show,
    on_close = opts.on_close,
  }
  
  if opts.actions then
    local named_actions = {}
    local key_mappings = {}
    local action_counter = 1
    
    for key, action_fn in pairs(opts.actions) do
      local action_name = "custom_action_" .. action_counter
      named_actions[action_name] = action_fn
      key_mappings[key] = { action_name, mode = { "i", "n" } }
      action_counter = action_counter + 1
    end
    
    picker_opts.actions = named_actions
    picker_opts.win = {
      input = {
        keys = key_mappings,
      },
      list = {
        keys = {
          ["?"] = "toggle_help_list",
        },
      },
    }
  end
  
  snacks.picker(picker_opts)
  return true
end

---Show picker using telescope.nvim
---@param opts PickerOpts Picker options
---@return boolean success
function M.show_telescope(opts)
  local ok, telescope = pcall(require, "telescope")
  if not ok then
    vim.notify("amp-extras: telescope.nvim not found", vim.log.levels.ERROR)
    return false
  end
  
  vim.notify("amp-extras: Telescope backend not yet implemented", vim.log.levels.WARN)
  return false
end

return M

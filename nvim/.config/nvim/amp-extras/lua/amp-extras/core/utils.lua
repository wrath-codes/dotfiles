---@class AmpExtrasUtils
local M = {}

---Generate a unique ID
---@return string id Unique identifier
function M.generate_id()
  return tostring(os.time()) .. "-" .. tostring(math.random(1000, 9999))
end

---Deep copy a table
---@param orig table Original table
---@return table copy Deep copy of the table
function M.deep_copy(orig)
  return vim.deepcopy(orig)
end

---Check if a table contains a value
---@param tbl table Table to search
---@param value any Value to find
---@return boolean found
function M.table_contains(tbl, value)
  for _, v in ipairs(tbl) do
    if v == value then
      return true
    end
  end
  return false
end

---Filter table by predicate function
---@param tbl table Table to filter
---@param predicate function Function that returns true to keep item
---@return table filtered Filtered table
function M.table_filter(tbl, predicate)
  local result = {}
  for _, item in ipairs(tbl) do
    if predicate(item) then
      table.insert(result, item)
    end
  end
  return result
end

---Map table through transform function
---@param tbl table Table to map
---@param transform function Function to transform each item
---@return table mapped Mapped table
function M.table_map(tbl, transform)
  local result = {}
  for i, item in ipairs(tbl) do
    result[i] = transform(item)
  end
  return result
end

---Get visual selection text
---@return string[] lines Selected lines
function M.get_visual_selection()
  local bufnr = vim.api.nvim_get_current_buf()
  local mode = vim.fn.mode()
  
  if mode == "v" or mode == "V" or mode == "\22" then
    local start_pos = vim.fn.getpos("'<")
    local end_pos = vim.fn.getpos("'>")
    local start_line = start_pos[2]
    local end_line = end_pos[2]
    return vim.api.nvim_buf_get_lines(bufnr, start_line - 1, end_line, false)
  else
    local start_mark = vim.api.nvim_buf_get_mark(bufnr, "<")
    local end_mark = vim.api.nvim_buf_get_mark(bufnr, ">")
    if start_mark[1] > 0 and end_mark[1] > 0 and start_mark[1] <= end_mark[1] then
      return vim.api.nvim_buf_get_lines(bufnr, start_mark[1] - 1, end_mark[1], false)
    end
  end
  
  return {}
end

---Copy text to clipboard
---@param text string Text to copy
function M.copy_to_clipboard(text)
  vim.fn.setreg("+", text)
  vim.notify("Copied to clipboard", vim.log.levels.INFO)
end

---Show success notification (green)
---@param message string Message to display
function M.notify_success(message)
  local ok, snacks = pcall(require, "snacks")
  if ok and snacks.notify then
    snacks.notify(message, { level = "success" })
  else
    vim.notify(message, vim.log.levels.INFO)
  end
end

---Ensure directory exists
---@param path string Directory path
---@return boolean success
function M.ensure_dir(path)
  local uv = vim.loop
  local stat = uv.fs_stat(path)
  
  if not stat then
    local ok = uv.fs_mkdir(path, 448)
    if not ok then
      vim.notify("Failed to create directory: " .. path, vim.log.levels.ERROR)
      return false
    end
  end
  
  return true
end

return M

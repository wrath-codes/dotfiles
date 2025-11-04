---@class TerminalOpts
---@field width number|nil Width ratio (0-1) or absolute (default: 0.5)
---@field height number|nil Height ratio (0-1) or absolute (default: 0.5)
---@field border string|nil Border style (default: "rounded")
---@field title string|nil Window title
---@field title_pos string|nil Title position (default: "center")
---@field interactive boolean|nil Whether terminal is interactive (default: true)

local M = {}

---Execute command in a floating terminal
---@param cmd string Command to execute
---@param opts TerminalOpts|nil Terminal options
---@return boolean success
function M.float_exec(cmd, opts)
  opts = opts or {}
  
  local ok, snacks = pcall(require, "snacks")
  if not ok then
    vim.notify("amp-extras: snacks.nvim not found for terminal", vim.log.levels.ERROR)
    return false
  end
  
  local terminal_opts = {
    win = {
      style = "float",
      width = opts.width or 0.5,
      height = opts.height or 0.5,
      border = opts.border or "rounded",
      title = opts.title or " Terminal ",
      title_pos = opts.title_pos or "center",
    },
    interactive = opts.interactive ~= false,
  }
  
  snacks.terminal(cmd, terminal_opts)
  return true
end

---Execute command and wait for key press to close
---@param cmd string Command to execute
---@param opts TerminalOpts|nil Terminal options
---@return boolean success
function M.wait_for_key(cmd, opts)
  opts = opts or {}
  
  local wrapped_cmd = cmd .. "; echo '\nPress any key to close...'; read -n 1"
  
  return M.float_exec(wrapped_cmd, opts)
end

---Execute amp command with output
---@param args string Amp command arguments
---@param opts TerminalOpts|nil Terminal options
---@return boolean success
function M.amp_exec(args, opts)
  opts = opts or {}
  opts.title = opts.title or " Amp Output "
  
  local cmd = "amp " .. args
  return M.wait_for_key(cmd, opts)
end

---Execute amp -x (execute prompt) command
---@param prompt string Prompt text to execute
---@param opts TerminalOpts|nil Terminal options
---@return boolean success
function M.amp_prompt(prompt, opts)
  local escaped_prompt = vim.fn.shellescape(prompt)
  return M.amp_exec("-x " .. escaped_prompt, opts)
end

return M

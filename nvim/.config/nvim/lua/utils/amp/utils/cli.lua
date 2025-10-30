local M = {}

--- Check if Amp CLI is installed
---@return boolean True if amp command is available
function M.is_amp_installed()
  return vim.fn.executable("amp") == 1
end

--- Run an amp command and call callback with output lines
---@param args string The command arguments (without 'amp')
---@param callback fun(lines: table) Callback with array of output lines
function M.run_command(args, callback)
  if not M.is_amp_installed() then
    vim.notify("Amp CLI is not installed or not in PATH", vim.log.levels.ERROR)
    return
  end

  local output = {}

  vim.fn.jobstart("amp " .. args, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_exit = function()
      callback(output)
    end,
    stdout_buffered = true,
  })
end

--- Run an amp command that outputs JSON and call callback with parsed table
---@param args string The command arguments
---@param callback fun(data: table|nil) Callback with parsed JSON or nil on error
function M.run_json_command(args, callback)
  if not M.is_amp_installed() then
    vim.notify("Amp CLI is not installed or not in PATH", vim.log.levels.ERROR)
    return
  end

  vim.fn.jobstart("amp " .. args, {
    on_stdout = function(_, data)
      local json_str = table.concat(data or {}, "")
      if json_str == "" then
        callback(nil)
        return
      end
      local ok, parsed = pcall(vim.json.decode, json_str)
      if ok then
        callback(parsed)
      else
        callback(nil)
      end
    end,
    stdout_buffered = true,
  })
end

--- Run an amp command and call callback with output lines and exit code
---@param args string The command arguments (without 'amp')
---@param callback fun(lines: table, exit_code: number) Callback with output lines and exit code
function M.run_command_with_exit(args, callback)
  if not M.is_amp_installed() then
    vim.notify("Amp CLI is not installed or not in PATH", vim.log.levels.ERROR)
    return
  end

  local output = {}

  vim.fn.jobstart("amp " .. args, {
    on_stdout = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_stderr = function(_, data)
      if data then
        for _, line in ipairs(data) do
          if line ~= "" then
            table.insert(output, line)
          end
        end
      end
    end,
    on_exit = function(_, exit_code)
      callback(output, exit_code)
    end,
    stdout_buffered = true,
    stderr_buffered = true,
  })
end

--- Check if user is logged in to Amp
---@param callback fun(logged_in: boolean) Callback with login status
function M.is_logged_in(callback)
  M.run_command_with_exit("threads list", function(lines, exit_code)
    callback(exit_code == 0)
  end)
end

return M

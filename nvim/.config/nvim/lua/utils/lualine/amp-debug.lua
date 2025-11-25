-- Debug version to test Amp status
local M = {}

function M.test_status()
  local amp = require("amp_extras")
  
  print("=== Amp Status Debug ===")
  
  -- Check if server is running
  local running = amp.server_is_running()
  print("Server running (direct check):", running)
  
  -- Get hub info
  local status = amp.get_status()
  print("Status from get_status():", vim.inspect(status))
  
  -- Check state table
  print("State table:", vim.inspect(amp.state))
  
  -- Try calling the Rust command directly
  local ok, result = pcall(amp.call, "server.status", {})
  if ok then
    print("Direct Rust call result:", vim.inspect(result))
  else
    print("Direct Rust call failed:", result)
  end
end

return M

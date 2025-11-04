local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpPermissionsTest", function(cmd_opts)
    local args = cmd_opts.args
    
    if args == "" then
      vim.notify("Usage: AmpPermissionsTest <tool-name> [args...]", vim.log.levels.WARN)
      vim.notify("Example: AmpPermissionsTest Bash --cmd 'ls*'", vim.log.levels.INFO)
      return
    end
    
    terminal.wait_for_key("amp permissions test " .. args, {
      width = 0.6,
      height = 0.4,
      title = " Amp Permissions Test ",
    })
  end, {
    nargs = "*",
    desc = "Test Amp permissions",
  })
end

return M

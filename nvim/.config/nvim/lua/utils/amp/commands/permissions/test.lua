local M = {}

function M.setup()
  -- Test permissions
  vim.api.nvim_create_user_command("AmpPermissionsTest", function(cmd_opts)
    local args = cmd_opts.args
    
    if args == "" then
      vim.notify("Usage: AmpPermissionsTest <tool-name> [args...]", vim.log.levels.WARN)
      vim.notify("Example: AmpPermissionsTest Bash --cmd 'ls*'", vim.log.levels.INFO)
      return
    end
    
    local cmd = "amp permissions test " .. args .. "; echo '\nPress any key to close...'; read -n 1"
    require("snacks").terminal(cmd, {
      win = {
        style = "float",
        width = 0.6,
        height = 0.4,
        border = "rounded",
        title = " Amp Permissions Test ",
        title_pos = "center",
      },
      interactive = true,
    })
  end, {
    nargs = "*",
    desc = "Test Amp permissions",
  })
end

return M

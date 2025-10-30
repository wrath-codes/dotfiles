local M = {}
local cli = require("utils.amp.utils.cli")

function M.setup()
  -- Log out from Amp
  vim.api.nvim_create_user_command("AmpLogout", function()
    cli.run_command("logout", function(lines)
      vim.notify("Logged out from Amp", vim.log.levels.INFO)
    end)
  end, {
    desc = "Log out from Amp",
  })
end

return M

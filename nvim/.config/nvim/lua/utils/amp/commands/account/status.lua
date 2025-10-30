local M = {}
local cli = require("utils.amp.utils.cli")

function M.setup()
  -- Check login status
  vim.api.nvim_create_user_command("AmpLoginStatus", function()
    cli.is_logged_in(function(logged_in)
      if logged_in then
        vim.notify("Logged in to Amp", vim.log.levels.INFO)
      else
        vim.notify("Not logged in to Amp. Run 'amp login' to authenticate.", vim.log.levels.WARN)
      end
    end)
  end, {
    desc = "Check Amp login status",
  })
end

return M

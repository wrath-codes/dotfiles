local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpLogout", function()
    terminal.wait_for_key("amp logout", {
      title = " Amp Logout ",
    })
  end, {
    desc = "Log out from Amp",
  })
end

return M

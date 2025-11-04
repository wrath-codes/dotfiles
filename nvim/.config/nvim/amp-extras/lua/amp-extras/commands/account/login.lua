local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpLogin", function()
    terminal.wait_for_key("amp login", {
      title = " Amp Login ",
    })
  end, {
    desc = "Log in to Amp",
  })
end

return M

local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpPermissionsEdit", function()
    terminal.wait_for_key("amp permissions edit", {
      width = 0.8,
      height = 0.8,
      title = " Amp Permissions ",
    })
  end, {
    desc = "Edit Amp permissions",
  })
end

return M

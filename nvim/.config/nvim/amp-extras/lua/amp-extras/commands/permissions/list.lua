local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpPermissionsList", function()
    terminal.wait_for_key("amp permissions list", {
      width = 0.6,
      height = 0.6,
      title = " Amp Permissions List ",
    })
  end, {
    desc = "List Amp permissions",
  })
end

return M

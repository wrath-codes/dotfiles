local M = {}

function M.setup()
  -- Edit permissions (opens in buffer)
  vim.api.nvim_create_user_command("AmpPermissionsEdit", function()
    local cmd = "amp permissions edit; echo '\nPress any key to close...'; read -n 1"
    require("snacks").terminal(cmd, {
      win = {
        style = "float",
        width = 0.8,
        height = 0.8,
        border = "rounded",
        title = " Amp Permissions ",
        title_pos = "center",
      },
      interactive = true,
    })
  end, {
    desc = "Edit Amp permissions",
  })
end

return M

local M = {}

function M.setup()
  -- List permissions
  vim.api.nvim_create_user_command("AmpPermissionsList", function()
    local cmd = "amp permissions list; echo '\nPress any key to close...'; read -n 1"
    require("snacks").terminal(cmd, {
      win = {
        style = "float",
        width = 0.6,
        height = 0.6,
        border = "rounded",
        title = " Amp Permissions List ",
        title_pos = "center",
      },
      interactive = true,
    })
  end, {
    desc = "List Amp permissions",
  })
end

return M

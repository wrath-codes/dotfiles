local M = {}

function M.setup()
  -- Log out from Amp
  vim.api.nvim_create_user_command("AmpLogout", function()
    local cmd = "amp logout; echo '\nPress any key to close...'; read -n 1"
    require("snacks").terminal(cmd, {
      win = {
        style = "float",
        width = 0.5,
        height = 0.5,
        border = "rounded",
        title = " Amp Logout ",
        title_pos = "center",
      },
      interactive = true,
    })
  end, {
    desc = "Log out from Amp",
  })
end

return M

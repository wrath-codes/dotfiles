local M = {}

function M.setup()
  -- Log in to Amp (interactive command in floating terminal)
  vim.api.nvim_create_user_command("AmpLogin", function()
    local cmd = "amp login; echo '\nPress any key to close...'; read -n 1"
    require("snacks").terminal(cmd, {
      win = {
        style = "float",
        width = 0.5,
        height = 0.5,
        border = "rounded",
        title = " Amp Login ",
        title_pos = "center",
      },
      interactive = true,
    })
  end, {
    desc = "Log in to Amp",
  })
end

return M

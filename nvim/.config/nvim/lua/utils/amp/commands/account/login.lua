local M = {}

function M.setup()
  -- Log in to Amp (interactive command in floating terminal)
  vim.api.nvim_create_user_command("AmpLogin", function()
    require("snacks").terminal("amp login", {
      win = { style = "float" },
    })
  end, {
    desc = "Log in to Amp (interactive)",
  })
end

return M

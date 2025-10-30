local M = {}

function M.setup()
  -- Update Amp (interactive command in floating terminal)
  vim.api.nvim_create_user_command("AmpUpdate", function()
    require("snacks").terminal("amp update", {
      win = { style = "float" },
    })
  end, {
    desc = "Update Amp (interactive)",
  })
end

return M

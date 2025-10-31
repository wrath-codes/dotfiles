local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpDoctorAll", function()
    require("snacks").terminal("amp tools list", {
      win = { style = "float" },
    })
  end, {
    desc = "Check all MCP server status",
  })
end

return M

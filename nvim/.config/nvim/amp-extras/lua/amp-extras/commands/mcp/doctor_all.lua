local M = {}

local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpDoctorAll", function()
    terminal.float_exec("amp tools list", {
      title = " MCP Doctor ",
    })
  end, {
    desc = "Check all MCP server status",
  })
end

return M

local M = {}

local input = require("amp-extras.core.input")
local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpDoctorSingle", function()
    input.prompt({
      prompt = "Server Name",
      title = "Server Name",
      on_submit = function(name)
        if not name or name == "" then
          vim.notify("No name provided", vim.log.levels.WARN)
          return
        end
        terminal.float_exec("amp mcp doctor " .. vim.fn.shellescape(name), {
          title = " MCP Doctor: " .. name .. " ",
        })
      end,
      on_cancel = function()
        vim.notify("Doctor cancelled", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Check single MCP server status",
  })
end

return M

local M = {}

local input = require("amp-extras.core.input")
local terminal = require("amp-extras.core.terminal")

function M.setup()
  vim.api.nvim_create_user_command("AmpPermissionsAdd", function()
    input.prompt({
      prompt = "Rule",
      title = "Add Permission Rule",
      width = 80,
      default = "allow ",
      on_submit = function(rule)
        if not rule or rule == "" then
          vim.notify("No rule provided", vim.log.levels.WARN)
          return
        end
        terminal.wait_for_key("amp permissions add " .. vim.fn.shellescape(rule), {
          width = 0.6,
          height = 0.4,
          title = " Add Permission ",
        })
      end,
      on_cancel = function()
        vim.notify("Add permission cancelled", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Add Amp permission rule",
  })
end

return M

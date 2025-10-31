local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpDoctorSingle", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    local input = Input({
      position = "50%",
      size = {
        width = 40,
      },
      border = {
        style = "rounded",
        text = {
          top = " Server Name ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Name: ",
      on_close = function()
        vim.notify("Doctor cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(name)
        if not name or name == "" then
          vim.notify("No name provided", vim.log.levels.WARN)
          return
        end

        -- Run amp mcp doctor <name>
        require("snacks").terminal("amp mcp doctor " .. vim.fn.shellescape(name), {
          win = { style = "float" },
        })
      end,
    })

    input:mount()
    input:map("n", "<Esc>", function()
      input:unmount()
    end)
    input:map("n", "q", function()
      input:unmount()
    end)
    input:on(event.BufLeave, function()
      input:unmount()
    end)
  end, {
    desc = "Check single MCP server status",
  })
end

return M

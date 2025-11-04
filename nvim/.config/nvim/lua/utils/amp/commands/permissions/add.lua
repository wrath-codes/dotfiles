local M = {}

function M.setup()
  -- Add permission rule
  vim.api.nvim_create_user_command("AmpPermissionsAdd", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- Prompt for permission rule
    local input = Input({
      position = "50%",
      size = {
        width = 80,
      },
      border = {
        style = "rounded",
        text = {
          top = " Add Permission Rule ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Rule: ",
      default_value = "allow ",
      on_close = function()
        vim.notify("Add permission cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(rule)
        if not rule or rule == "" then
          vim.notify("No rule provided", vim.log.levels.WARN)
          return
        end

        local cmd = "amp permissions add " .. vim.fn.shellescape(rule) .. "; echo '\nPress any key to close...'; read -n 1"
        require("snacks").terminal(cmd, {
          win = {
            style = "float",
            width = 0.6,
            height = 0.4,
            border = "rounded",
            title = " Add Permission ",
            title_pos = "center",
          },
          interactive = true,
        })
      end,
    })

    input:mount()
    input:map("n", "<Esc>", function() input:unmount() end)
    input:map("n", "q", function() input:unmount() end)
    input:on(event.BufLeave, function() input:unmount() end)
  end, {
    desc = "Add Amp permission rule",
  })
end

return M

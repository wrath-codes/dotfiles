local M = {}

local input = require("amp-extras.core.input")

function M.setup()
  vim.api.nvim_create_user_command("AmpSessionWithMessage", function()
    input.prompt({
      prompt = "Message",
      title = "Amp Message",
      on_submit = function(message)
        if not message or message == "" then
          vim.notify("No message provided", vim.log.levels.WARN)
          return
        end

        local buf = vim.api.nvim_create_buf(false, true)
        
        vim.cmd("vsplit")
        vim.api.nvim_win_set_buf(0, buf)
        
        local cmd = 'echo ' .. vim.fn.shellescape(message) .. ' | amp --ide'
        vim.fn.termopen(cmd, {
          on_exit = function(_, exit_code)
            if exit_code ~= 0 then
              vim.notify("Amp session exited with code: " .. exit_code, vim.log.levels.WARN)
            end
          end,
        })
        
        vim.cmd("startinsert")
      end,
      on_cancel = function()
        vim.notify("Session cancelled", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Open new Amp session with message in vertical split",
  })
end

return M

local M = {}

function M.setup()
  -- Open a new Amp interactive session with a message in a vertical split
  vim.api.nvim_create_user_command("AmpSessionWithMessage", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- Prompt for message
    local input = Input({
      position = "50%",
      size = {
        width = 60,
      },
      border = {
        style = "rounded",
        text = {
          top = " Amp Message ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Message: ",
      on_close = function()
        vim.notify("Session cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(message)
        if not message or message == "" then
          vim.notify("No message provided", vim.log.levels.WARN)
          return
        end

        -- Create a new buffer
        local buf = vim.api.nvim_create_buf(false, true)
        
        -- Create a vertical split and set the buffer
        vim.cmd("vsplit")
        vim.api.nvim_win_set_buf(0, buf)
        
        -- Pipe message to amp --ide
        local cmd = 'echo ' .. vim.fn.shellescape(message) .. ' | amp --ide'
        vim.fn.termopen(cmd, {
          on_exit = function(_, exit_code)
            if exit_code ~= 0 then
              vim.notify("Amp session exited with code: " .. exit_code, vim.log.levels.WARN)
            end
          end,
        })
        
        -- Enter insert mode in the terminal
        vim.cmd("startinsert")
      end,
    })

    input:mount()
    input:map("n", "<Esc>", function() input:unmount() end)
    input:map("n", "q", function() input:unmount() end)
    input:on(event.BufLeave, function() input:unmount() end)
  end, {
    desc = "Open new Amp session with message in vertical split",
  })
end

return M

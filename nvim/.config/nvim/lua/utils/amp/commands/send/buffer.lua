local M = {}

function M.setup()
  -- Add entire buffer contents to Amp prompt
  vim.api.nvim_create_user_command("AmpSendBuffer", function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(content)
  end, {
    nargs = "?",
    desc = "Add current buffer contents to Amp prompt",
  })
end

return M

local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpPromptSelection", function(cmd_opts)
    local start = vim.api.nvim_buf_get_mark(0, '<')
    local end_ = vim.api.nvim_buf_get_mark(0, '>')
    local lines = vim.api.nvim_buf_get_text(0, start[1] - 1, start[2], end_[1] - 1, end_[2], {})
    local text = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(text)
  end, {
    range = true,
    desc = "Add selected text to Amp prompt",
  })
end

return M

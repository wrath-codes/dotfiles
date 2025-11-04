local M = {}

function M.setup()
  -- Add file reference to prompt
  vim.api.nvim_create_user_command("AmpPromptFileRef", function()
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      vim.notify("Current buffer has no filename", vim.log.levels.WARN)
      return
    end

    local relative_path = vim.fn.fnamemodify(bufname, ":.")
    local ref = "@" .. relative_path

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(ref)
  end, {
    desc = "Add current file reference to Amp prompt",
  })
end

return M

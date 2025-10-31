local M = {}

function M.setup()
  -- Add file+selection reference to prompt
  vim.api.nvim_create_user_command("AmpPromptRef", function(cmd_opts)
    ---@param cmd_opts table Command options with line1 and line2
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      vim.notify("Current buffer has no filename", vim.log.levels.WARN)
      return
    end

    local relative_path = vim.fn.fnamemodify(bufname, ":.")
    local ref = "@" .. relative_path
    if cmd_opts.line1 ~= cmd_opts.line2 then
      ref = ref .. "#L" .. cmd_opts.line1 .. "-" .. cmd_opts.line2
    elseif cmd_opts.line1 > 1 then
      ref = ref .. "#L" .. cmd_opts.line1
    end

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(ref)
  end, {
    range = true,
    desc = "Add file reference (with selection) to Amp prompt",
  })
end

return M

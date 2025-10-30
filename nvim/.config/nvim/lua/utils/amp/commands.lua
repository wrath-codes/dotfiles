local M = {}

---@param cmd_opts table Command options containing args
function M.setup()
  -- Send a quick message to Amp
  vim.api.nvim_create_user_command("AmpSend", function(cmd_opts)
    ---@param cmd_opts table Command options containing args
    local message = cmd_opts.args
    if message == "" then
      print("Please provide a message to send")
      return
    end

    local amp_message = require("amp.message")
    amp_message.send_message(message)
  end, {
    nargs = "*",
    desc = "Send a message to Amp",
  })

  -- Send entire buffer contents
  vim.api.nvim_create_user_command("AmpSendBuffer", function()
    local buf = vim.api.nvim_get_current_buf()
    local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
    local content = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_message(content)
  end, {
    nargs = "?",
    desc = "Send current buffer contents to Amp",
  })

  -- Add selected text to prompt
  vim.api.nvim_create_user_command("AmpPromptSelection", function(cmd_opts)
    ---@param cmd_opts table Command options with line1 and line2
    local lines = vim.api.nvim_buf_get_lines(0, cmd_opts.line1 - 1, cmd_opts.line2, false)
    local text = table.concat(lines, "\n")

    local amp_message = require("amp.message")
    amp_message.send_to_prompt(text)
  end, {
    range = true,
    desc = "Add selected text to Amp prompt",
  })

  -- Add file+selection reference to prompt
  vim.api.nvim_create_user_command("AmpPromptRef", function(cmd_opts)
    ---@param cmd_opts table Command options with line1 and line2
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname == "" then
      print("Current buffer has no filename")
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

  -- Setup account commands
  require("utils.amp.commands.account.login").setup()
  require("utils.amp.commands.account.logout").setup()

  -- Setup tools and threads list commands
  require("utils.amp.commands.tools.list").setup()
  require("utils.amp.commands.threads.list").setup()
end

return M
local M = {}

-- Send a quick message to Amp
local function open_multiline_input(callback)
  local Popup = require("nui.popup")
  local event = require("nui.utils.autocmd").event

  local popup = Popup({
    enter = true,
    focusable = true,
    border = {
      style = "rounded",
      text = {
        top = " Amp Message ",
        top_align = "center",
      },
    },
    position = "50%",
    size = {
      width = 80,
      height = 10,
    },
    buf_options = {
      buftype = "nofile",
      bufhidden = "wipe",
      swapfile = false,
    },
    win_options = {
      wrap = true,
      linebreak = true,
      breakindent = true,
    },
  })

  popup:mount()

  vim.bo[popup.bufnr].textwidth = 78
  vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, { "" })

  local function confirm()
    local lines = vim.api.nvim_buf_get_lines(popup.bufnr, 0, -1, false)
    local input = table.concat(lines, "\n"):gsub("^%s+", ""):gsub("%s+$", "")
    popup:unmount()
    if input ~= "" then
      vim.notify("Sending message: " .. input:sub(1, 50) .. (input:len() > 50 and "..." or ""), vim.log.levels.INFO)
      callback(input)
    end
  end

  local function cancel()
    popup:unmount()
  end

  popup:map("i", "<CR>", confirm, { noremap = true })
  popup:map("n", "<Esc>", cancel, { noremap = true })
  popup:map("n", "q", cancel, { noremap = true })

  popup:on(event.BufLeave, cancel)

  vim.cmd.startinsert()
end

function M.setup()
  vim.api.nvim_create_user_command("AmpSend", function(cmd_opts)
    ---@param cmd_opts table Command options containing args
    local message = cmd_opts.args
    if message == "" then
      open_multiline_input(function(input)
        local amp_message = require("amp.message")
        amp_message.send_message(input)
      end)
    else
      local amp_message = require("amp.message")
      amp_message.send_message(message)
    end
  end, {
    nargs = "*",
    desc = "Send a message to Amp",
  })
end

return M

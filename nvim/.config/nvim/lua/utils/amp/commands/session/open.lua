local M = {}

function M.setup()
  -- Open a new Amp interactive session in a vertical split
  vim.api.nvim_create_user_command("AmpSessionOpen", function()
    -- Create a new buffer
    local buf = vim.api.nvim_create_buf(false, true)
    
    -- Create a vertical split and set the buffer
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)
    
    -- Open terminal with amp --ide
    vim.fn.termopen("amp --ide", {
      on_exit = function(_, exit_code)
        if exit_code ~= 0 then
          vim.notify("Amp session exited with code: " .. exit_code, vim.log.levels.WARN)
        end
      end,
    })
    
    -- Enter insert mode in the terminal
    vim.cmd("startinsert")
  end, {
    desc = "Open new Amp interactive session in vertical split",
  })
end

return M

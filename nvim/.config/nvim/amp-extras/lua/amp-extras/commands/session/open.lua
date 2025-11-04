local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpSessionOpen", function()
    local buf = vim.api.nvim_create_buf(false, true)
    
    vim.cmd("vsplit")
    vim.api.nvim_win_set_buf(0, buf)
    
    vim.fn.termopen("amp --ide", {
      on_exit = function(_, exit_code)
        if exit_code ~= 0 then
          vim.notify("Amp session exited with code: " .. exit_code, vim.log.levels.WARN)
        end
      end,
    })
    
    vim.cmd("startinsert")
  end, {
    desc = "Open new Amp interactive session in vertical split",
  })
end

return M

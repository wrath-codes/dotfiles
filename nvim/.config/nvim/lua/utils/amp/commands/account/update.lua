local M = {}

function M.setup()
  -- Update Amp and show result as notification
  vim.api.nvim_create_user_command("AmpUpdate", function()
    vim.notify("Updating Amp...", vim.log.levels.INFO)
    
    vim.fn.jobstart("amp update", {
      on_exit = function(_, exit_code)
        if exit_code == 0 then
          vim.schedule(function()
            vim.notify("Amp updated successfully!", vim.log.levels.INFO)
          end)
        else
          vim.schedule(function()
            vim.notify("Amp update failed (exit code: " .. exit_code .. ")", vim.log.levels.ERROR)
          end)
        end
      end,
      on_stdout = function(_, data)
        if data and #data > 0 then
          local output = table.concat(data, "\n"):gsub("^%s*(.-)%s*$", "%1")
          if output ~= "" then
            vim.schedule(function()
              vim.notify(output, vim.log.levels.INFO)
            end)
          end
        end
      end,
      on_stderr = function(_, data)
        if data and #data > 0 then
          local output = table.concat(data, "\n"):gsub("^%s*(.-)%s*$", "%1")
          if output ~= "" then
            vim.schedule(function()
              vim.notify(output, vim.log.levels.WARN)
            end)
          end
        end
      end,
    })
  end, {
    desc = "Update Amp",
  })
end

return M

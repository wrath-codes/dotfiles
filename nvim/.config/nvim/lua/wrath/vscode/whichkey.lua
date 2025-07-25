-- Optional which-key.nvim integration for Nvim UI+ VSCode extension
-- Add this to your Neovim config to enable which-key display in VSCode

if vim.g.vscode then
  -- Function to send which-key content to VSCode
  vim.g.vscode_which_key_update = function(buf)
    if buf and vim.api.nvim_buf_is_valid(buf) then
      local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
      local content = table.concat(lines, "\n")
      
      -- Call VSCode command to show which-key content
      vscode.action("nvim-ui-plus.updateWhichKey", {
        args = { content = content, visible = true }
      })
    else
      -- Hide which-key display
      vscode.action("nvim-ui-plus.updateWhichKey", {
        args = { content = "", visible = false }
      })
    end
  end

  -- Hook into which-key.nvim buffer events
  vim.api.nvim_create_autocmd({"BufWinEnter", "BufWinLeave"}, {
    pattern = "*",
    callback = function(ev)
      local buf = ev.buf
      local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
      
      if buf_ft == "WhichKey" then
        if ev.event == "BufWinEnter" then
          -- Show which-key content in VSCode
          vim.g.vscode_which_key_update(buf)
        else
          -- Hide which-key content in VSCode
          vim.g.vscode_which_key_update(nil)
        end
      end
    end
  })

  -- Optional: Also hook into which-key show/hide functions if available
  vim.schedule(function()
    local has_which_key, wk = pcall(require, "which-key")
    if has_which_key then
      -- Try to hook into which-key's display functions
      -- This is optional and may need adjustment based on which-key version
      local original_show = wk.show
      if original_show then
        wk.show = function(...)
          local result = original_show(...)
          
          -- Get the which-key buffer content after a brief delay
          vim.schedule(function()
            local buffers = vim.api.nvim_list_bufs()
            for _, buf in ipairs(buffers) do
              local buf_ft = vim.api.nvim_buf_get_option(buf, "filetype")
              if buf_ft == "WhichKey" then
                vim.g.vscode_which_key_update(buf)
                break
              end
            end
          end)
          
          return result
        end
      end
    end
  end)
end


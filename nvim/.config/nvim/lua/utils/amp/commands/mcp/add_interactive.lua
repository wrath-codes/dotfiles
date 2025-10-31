local M = {}

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpAddInteractive", function()
    local Input = require("nui.input")
    local event = require("nui.utils.autocmd").event

    -- First input: server name
    local name_input = Input({
      position = "50%",
      size = {
        width = 40,
      },
      border = {
        style = "rounded",
        text = {
          top = " Server Name ",
          top_align = "center",
        },
      },
      win_options = {
        winhighlight = "Normal:Normal,FloatBorder:Normal",
      },
    }, {
      prompt = "Name: ",
      on_close = function()
        vim.notify("Add cancelled", vim.log.levels.INFO)
      end,
      on_submit = function(name)
        if not name or name == "" then
          vim.notify("No name provided", vim.log.levels.WARN)
          return
        end

        -- Second input: command
        local cmd_input = Input({
          position = "50%",
          size = {
            width = 60,
          },
          border = {
            style = "rounded",
            text = {
              top = " Command ",
              top_align = "center",
            },
          },
          win_options = {
            winhighlight = "Normal:Normal,FloatBorder:Normal",
          },
        }, {
          prompt = "> ",
          on_close = function()
            vim.notify("Add cancelled", vim.log.levels.INFO)
          end,
          on_submit = function(command)
            if not command or command == "" then
              vim.notify("No command provided", vim.log.levels.WARN)
              return
            end

            -- Edit config file
            local config_path = vim.fn.expand("~/.config/amp/settings.json")
            local config = {}
            if vim.fn.filereadable(config_path) == 1 then
              local content = table.concat(vim.fn.readfile(config_path), "\n")
              config = vim.json.decode(content) or {}
            end
            config["amp.mcpServers"] = config["amp.mcpServers"] or {}
            config["amp.mcpServers"][name] = { command = command }
            local new_content = vim.json.encode(config)
            vim.fn.writefile(vim.split(new_content, "\n"), config_path)
            vim.notify("MCP server '" .. name .. "' added", vim.log.levels.INFO)
          end,
        })

        cmd_input:mount()
        cmd_input:map("n", "<Esc>", function()
          cmd_input:unmount()
        end)
        cmd_input:map("n", "q", function()
          cmd_input:unmount()
        end)
        cmd_input:on(event.BufLeave, function()
          cmd_input:unmount()
        end)
      end,
    })

    name_input:mount()
    name_input:map("n", "<Esc>", function()
      name_input:unmount()
    end)
    name_input:map("n", "q", function()
      name_input:unmount()
    end)
    name_input:on(event.BufLeave, function()
      name_input:unmount()
    end)
  end, {
    desc = "Add MCP server (interactive)",
  })
end

return M

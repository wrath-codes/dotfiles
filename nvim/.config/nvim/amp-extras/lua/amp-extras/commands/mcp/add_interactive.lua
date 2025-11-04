local M = {}

local input = require("amp-extras.core.input")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpAddInteractive", function()
    input.multi_step({
      steps = {
        {
          type = "input",
          key = "name",
          prompt = "Server Name",
          title = "Server Name",
        },
        {
          type = "input",
          key = "command",
          prompt = "Command",
          title = "Command",
          width = 60,
        },
      },
      on_complete = function(results)
        if not results.name or results.name == "" then
          vim.notify("No name provided", vim.log.levels.WARN)
          return
        end
        if not results.command or results.command == "" then
          vim.notify("No command provided", vim.log.levels.WARN)
          return
        end

        local config_path = vim.fn.expand("~/.config/amp/settings.json")
        local config = {}
        
        if vim.fn.filereadable(config_path) == 1 then
          local content = table.concat(vim.fn.readfile(config_path), "\n")
          config = vim.json.decode(content) or {}
        end
        
        config["amp.mcpServers"] = config["amp.mcpServers"] or {}
        config["amp.mcpServers"][results.name] = { command = results.command }
        
        local new_content = vim.json.encode(config)
        vim.fn.writefile(vim.split(new_content, "\n"), config_path)
        vim.notify("MCP server '" .. results.name .. "' added", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Add MCP server (interactive)",
  })
end

return M

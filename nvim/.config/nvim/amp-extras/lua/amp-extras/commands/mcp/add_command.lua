local M = {}

local input = require("amp-extras.core.input")

---Save MCP server to config
---@param name string Server name
---@param command string Server command
local function save_mcp_server(name, command)
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
end

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpAddCommand", function(cmd_opts)
    local args = cmd_opts.args
    
    if args == "" then
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
          save_mcp_server(results.name, results.command)
        end,
      })
      return
    end

    local parts = vim.split(args, " ", { trimempty = true })
    if #parts < 2 then
      vim.notify("Usage: AmpMcpAddCommand <name> <command>", vim.log.levels.WARN)
      return
    end

    local name = parts[1]
    local command = table.concat(parts, " ", 2)
    save_mcp_server(name, command)
  end, {
    nargs = "*",
    desc = "Add MCP server with command",
  })
end

return M

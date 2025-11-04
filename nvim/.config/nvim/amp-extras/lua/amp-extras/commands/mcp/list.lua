local M = {}

local picker = require("amp-extras.core.picker")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpList", function()
    local cli = require("amp-extras.utils.cli")
    
    cli.run_command("mcp doctor", function(doctor_lines)
      local config_path = vim.fn.expand("~/.config/amp/settings.json")
      local config = {}
      
      if vim.fn.filereadable(config_path) == 1 then
        local content = table.concat(vim.fn.readfile(config_path), "\n")
        config = vim.json.decode(content) or {}
      end
      
      local servers = config["amp.mcpServers"] or {}

      local status_map = {}
      for _, line in ipairs(doctor_lines) do
        local name, status = line:match("([^:]+):%s*(.+)")
        if not name then
          name, status = line:match("(.+)%s*%- (.+)")
        end
        if name and status then
          status_map[name:match("^%s*(.-)%s*$")] = status:match("^%s*(.-)%s*$")
        end
      end

      local items = {}
      for name, cfg in pairs(servers) do
        local status = status_map[name] or "unknown"
        table.insert(items, {
          text = name .. ": " .. (cfg.command or cfg.url or "unknown") .. " [" .. status .. "]",
        })
      end
      
      if #items == 0 then
        vim.notify("No MCP servers configured", vim.log.levels.INFO)
        return
      end
      
      picker.show({
        items = items,
        title = " MCP Servers ",
        format = function(item)
          return { item.text }
        end,
      })
    end)
  end, {
    desc = "List MCP servers",
  })
end

return M

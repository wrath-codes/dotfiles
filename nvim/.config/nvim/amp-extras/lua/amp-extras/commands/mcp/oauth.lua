local M = {}

local picker = require("amp-extras.core.picker")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpOauth", function()
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
          name = name,
          cfg = cfg,
          status = status,
          text = name .. ": " .. (cfg.command or cfg.url or "unknown") .. " [" .. status .. "]",
        })
      end
      
      if #items == 0 then
        vim.notify("No MCP servers configured", vim.log.levels.INFO)
        return
      end

      picker.show({
        items = items,
        title = " MCP OAuth ",
        actions = {
          ["<C-S-l>"] = function(p, item)
            cli.run_command("mcp oauth login " .. vim.fn.shellescape(item.name), function(lines)
              vim.notify("OAuth login for '" .. item.name .. "' completed", vim.log.levels.INFO)
            end)
          end,
          ["<C-S-o>"] = function(p, item)
            cli.run_command("mcp oauth logout " .. vim.fn.shellescape(item.name), function(lines)
              vim.notify("OAuth logout for '" .. item.name .. "' completed", vim.log.levels.INFO)
            end)
          end,
        },
        format = function(item)
          return { { item.text, "SnacksPickerLabel" } }
        end,
        confirm = function(p, item)
          p:close()
          cli.run_command("mcp oauth status " .. vim.fn.shellescape(item.name), function(lines)
            local output = table.concat(lines, "\n")
            vim.notify("OAuth status for '" .. item.name .. "': " .. output, vim.log.levels.INFO)
          end)
        end,
      })
    end)
  end, {
    desc = "MCP OAuth management",
  })
end

return M

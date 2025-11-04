local M = {}

local input = require("amp-extras.core.input")

function M.setup()
  vim.api.nvim_create_user_command("AmpMcpRemove", function()
    local config_path = vim.fn.expand("~/.config/amp/settings.json")
    local config = {}
    
    if vim.fn.filereadable(config_path) == 1 then
      local content = table.concat(vim.fn.readfile(config_path), "\n")
      config = vim.json.decode(content) or {}
    end
    
    local servers = config["amp.mcpServers"] or {}
    if not servers or vim.tbl_isempty(servers) then
      vim.notify("No MCP servers configured", vim.log.levels.INFO)
      return
    end

    input.prompt({
      prompt = "Server Name to Remove",
      title = "Server Name to Remove",
      on_submit = function(name)
        if not name or name == "" then
          vim.notify("No name provided", vim.log.levels.WARN)
          return
        end

        if config["amp.mcpServers"] and config["amp.mcpServers"][name] then
          config["amp.mcpServers"][name] = nil
          local new_content = vim.json.encode(config)
          vim.fn.writefile(vim.split(new_content, "\n"), config_path)
          vim.notify("MCP server '" .. name .. "' removed", vim.log.levels.INFO)
        else
          vim.notify("MCP server '" .. name .. "' not found", vim.log.levels.WARN)
        end
      end,
      on_cancel = function()
        vim.notify("Remove cancelled", vim.log.levels.INFO)
      end,
    })
  end, {
    desc = "Remove MCP server",
  })
end

return M

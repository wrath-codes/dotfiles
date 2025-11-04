local M = {}

local picker = require("amp-extras.core.picker")
local utils = require("amp-extras.core.utils")

M.tools_cache = {}

---Format description
---@param desc string
---@return string
function M.format_description(desc)
  desc = desc:gsub("<examples>", "**Examples:**")
  desc = desc:gsub("</examples>", "")
  desc = desc:gsub("<example>\n", "```json\n")
  desc = desc:gsub("</example>", "```")
  desc = desc:gsub("<[^>]+>", "")
  return desc
end

---Fetch tool details
---@param tool_name string
---@param callback function
function M.fetch_tool_details(tool_name, callback)
  local cli = require("amp-extras.utils.cli")
  cli.run_json_command("tools show --json " .. vim.fn.shellescape(tool_name), function(data)
    if data then
      M.tools_cache[tool_name] = data
      callback(data)
    end
  end)
end

function M.setup()
  vim.api.nvim_create_user_command("AmpToolsList", function()
    local cli = require("amp-extras.utils.cli")
    
    cli.run_command("tools list", function(lines)
      local items = {}
      local tool_names = {}

      for i, line in ipairs(lines) do
        local tool_name, tool_type, description = line:match("^(%S+)%s+(%S+)%s+(.+)$")
        if tool_name and description then
          table.insert(tool_names, tool_name)
          table.insert(items, {
            text = tool_name .. " " .. description,
            tool_name = tool_name,
            tool_type = tool_type,
            description = description,
          })
        end
      end

      if #items == 0 then
        vim.notify("No tools found", vim.log.levels.WARN)
        return
      end

      for _, name in ipairs(tool_names) do
        if not M.tools_cache[name] then
          M.fetch_tool_details(name, function(data) end)
        end
      end

      picker.show({
        items = items,
        title = " Amp Tools ",
        format = function(item)
          return {
            { string.format("%-40s %-10s", item.tool_name, item.tool_type), "SnacksPickerLabel" },
            { item.description, "SnacksPickerComment" },
          }
        end,
        preview = function(ctx)
          local item = ctx.item
          if not item or not item.tool_name then
            return
          end

          local lines = {
            "# " .. item.tool_name,
            "",
            item.description,
          }

          if M.tools_cache[item.tool_name] and M.tools_cache[item.tool_name].description then
            local tool_data = M.tools_cache[item.tool_name]
            local formatted_desc = M.format_description(tool_data.description)
            local desc_lines = vim.split(formatted_desc, "\n")
            lines = { "# " .. tool_data.name, "" }
            vim.list_extend(lines, desc_lines)
          end

          ctx.preview:reset()
          ctx.preview:set_lines(lines)
          ctx.preview:highlight({ ft = "markdown" })
        end,
        confirm = function(p, item)
          p:close()
          utils.copy_to_clipboard(item.tool_name)
        end,
      })
    end)
  end, {
    desc = "List available Amp tools",
  })
end

return M
